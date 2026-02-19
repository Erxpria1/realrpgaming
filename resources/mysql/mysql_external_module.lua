--[[
* ***********************************************************************************************************************
* MySQL export wrapper
* Keeps legacy mysql:* API compatible while routing queries to the correct connection.
* ***********************************************************************************************************************
]]

local resultPool = {}
local resultCursor = 0
local countqueries = 0

local forumsPrefix = get("forums_prefix") or get("forum_prefix") or ""

local coreTables = {
	accounts = true,
	bans = true,
	don_purchases = true,
	donates = true,
	purchases = true,
	serial_whitelist = true,
	tc_tickets = true,
	forum = true,
	post = true,
	thread = true,
	user = true,
	phpbb_ugposts = true
}

local function trim(value)
	return (tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function normalizeResultId(resultId)
	if resultId == nil then
		return nil
	end

	local numericResultId = tonumber(resultId)
	if numericResultId then
		return numericResultId
	end

	return resultId
end

local function getResultPoolEntry(resultId)
	local normalizedId = normalizeResultId(resultId)
	if normalizedId == nil then
		return nil, nil
	end

	return resultPool[normalizedId], normalizedId
end

local function normalizeTableName(rawName)
	if not rawName then
		return nil
	end

	local cleaned = tostring(rawName):gsub("`", "")
	local tableName = cleaned:match("([%w_]+)$")
	if not tableName then
		return nil
	end
	return tableName:lower()
end

local function extractTables(sql)
	local normalizedSql = string.lower(sql or "")
	local tables = {}

	local function addFromPattern(pattern)
		for rawName in normalizedSql:gmatch(pattern) do
			local tableName = normalizeTableName(rawName)
			if tableName then
				tables[tableName] = true
			end
		end
	end

	addFromPattern("from%s+`?([%w_%.]+)`?")
	addFromPattern("join%s+`?([%w_%.]+)`?")
	addFromPattern("update%s+`?([%w_%.]+)`?")
	addFromPattern("into%s+`?([%w_%.]+)`?")
	addFromPattern("delete%s+from%s+`?([%w_%.]+)`?")

	return tables
end

local function shouldUseCoreConnection(sql)
	local tables = extractTables(sql)
	local hasCoreTable = false
	local hasNonCoreTable = false

	for tableName in pairs(tables) do
		if coreTables[tableName] then
			hasCoreTable = true
		else
			hasNonCoreTable = true
		end
	end

	-- If the query mixes core and non-core tables, keep it on mta for compatibility.
	if hasCoreTable and not hasNonCoreTable then
		return true
	end

	return false
end

local function resolveConnection(sql, forcedConnection)
	local connectionName = forcedConnection
	if not connectionName then
		connectionName = shouldUseCoreConnection(sql) and "core" or "mta"
	end

	local connection = getConn(connectionName)
	if not isElement(connection) and connectionName ~= "mta" then
		connection = getConn("mta")
	end

	return connection
end

local function runQuery(sql, forcedConnection, ...)
	local queryString = trim(sql)
	if queryString == "" then
		return false
	end

	local connection = resolveConnection(queryString, forcedConnection)
	if not isElement(connection) then
		outputDebugString("[MYSQL] Query rejected: no active connection.")
		return false
	end

	countqueries = countqueries + 1

	local queryHandle = dbQuery(connection, queryString, ...)
	if not queryHandle then
		return false
	end

	local rows, _, lastInsertId = dbPoll(queryHandle, 10000)
	if rows == nil or rows == false then
		dbFree(queryHandle)
		return false
	end

	resultCursor = resultCursor + 1
	resultPool[resultCursor] = {
		data = rows,
		pointer = 1,
		count = #rows,
		last_id = lastInsertId,
		str = queryString
	}
	return resultCursor
end

function ping()
	return isElement(getConn("mta"))
end

function escape_string(str)
	if str == nil then
		return ""
	end
	return tostring(str):gsub("\\", "\\\\"):gsub("'", "''")
end

function query(sql, ...)
	return runQuery(sql, nil, ...)
end

function unbuffered_query(sql, ...)
	return query(sql, ...)
end

function query_free(sql, ...)
	local resultId = query(sql, ...)
	if not resultId then
		return false
	end

	free_result(resultId)
	return true
end

function rows_assoc(resultId)
	local pool = getResultPoolEntry(resultId)
	return pool and pool.data or false
end

function fetch_assoc(resultId)
	local pool = getResultPoolEntry(resultId)
	if not pool then
		return false
	end

	local row = pool.data[pool.pointer]
	if row then
		pool.pointer = pool.pointer + 1
		return row
	end
	return false
end

function free_result(resultId)
	local _, normalizedId = getResultPoolEntry(resultId)
	if not normalizedId then
		return false
	end

	resultPool[normalizedId] = nil
	return true
end

function result(resultId, row, field)
	local pool = getResultPoolEntry(resultId)
	if not pool or not pool.data[row + 1] then
		return false
	end
	return pool.data[row + 1][field]
end

function num_rows(resultId)
	local pool = getResultPoolEntry(resultId)
	return pool and pool.count or 0
end

function insert_id(resultId)
	local pool = getResultPoolEntry(resultId)
	return pool and pool.last_id or false
end

function query_fetch_assoc(sql, ...)
	local resultId = query(sql, ...)
	if not resultId then
		return false
	end

	local row = fetch_assoc(resultId)
	free_result(resultId)
	return row
end

function query_rows_assoc(sql, ...)
	local resultId = query(sql, ...)
	if not resultId then
		return false
	end

	local rows = rows_assoc(resultId)
	free_result(resultId)
	return rows
end

function query_insert_free(sql, ...)
	local resultId = query(sql, ...)
	if not resultId then
		return false
	end

	local id = insert_id(resultId)
	free_result(resultId)
	return id
end

function debugMode()
	return false
end

function returnQueryStats()
	return countqueries
end

function getOpenQueryStr(resultId)
	local pool = getResultPoolEntry(resultId)
	return pool and pool.str or ""
end

function forumQuery(sql, ...)
	return runQuery(sql, "core", ...)
end

function forum_query_fetch_assoc(sql, ...)
	local resultId = forumQuery(sql, ...)
	if not resultId then
		return false
	end

	local row = fetch_assoc(resultId)
	free_result(resultId)
	return row
end

function forum_query_free(sql, ...)
	local resultId = forumQuery(sql, ...)
	if not resultId then
		return false
	end

	free_result(resultId)
	return true
end

function forum_query_insert_free(sql, ...)
	local resultId = forumQuery(sql, ...)
	if not resultId then
		return false
	end

	local id = insert_id(resultId)
	free_result(resultId)
	return id
end

function getForumsPrefix()
	return forumsPrefix
end

function getMySQLUsername()
	return username
end

function getMySQLPassword()
	return password
end

function getMySQLDBName()
	return database
end

function getMySQLHost()
	return hostname
end

function getMySQLPort()
	return port
end

local function sqlIdentifier(identifier)
	if type(identifier) ~= "string" or identifier == "" then
		return nil
	end

	if not identifier:match("^[%w_%.]+$") then
		return nil
	end

	local parts = {}
	for part in identifier:gmatch("[^%.]+") do
		table.insert(parts, "`" .. part .. "`")
	end
	return table.concat(parts, ".")
end

local function sqlValue(value)
	if value == nil then
		return "NULL"
	end

	local valueType = type(value)
	if valueType == "number" then
		return tostring(value)
	elseif valueType == "boolean" then
		return value and "1" or "0"
	end

	return "'" .. escape_string(value) .. "'"
end

local function buildWhereClause(clause)
	if clause == nil then
		return ""
	end

	if type(clause) == "string" then
		if trim(clause) == "" then
			return ""
		end
		return " WHERE " .. clause
	end

	if type(clause) ~= "table" then
		return nil
	end

	local predicates = {}
	for key, value in pairs(clause) do
		local column = sqlIdentifier(key)
		if not column then
			return nil
		end

		if value == nil then
			table.insert(predicates, column .. " IS NULL")
		else
			table.insert(predicates, column .. "=" .. sqlValue(value))
		end
	end

	if #predicates == 0 then
		return ""
	end

	table.sort(predicates)
	return " WHERE " .. table.concat(predicates, " AND ")
end

local function buildSetClause(values)
	if type(values) ~= "table" then
		return nil
	end

	local assignments = {}
	for key, value in pairs(values) do
		local column = sqlIdentifier(key)
		if not column then
			return nil
		end
		table.insert(assignments, column .. "=" .. sqlValue(value))
	end

	if #assignments == 0 then
		return nil
	end

	table.sort(assignments)
	return table.concat(assignments, ", ")
end

function select(tableName, clause)
	local sqlTable = sqlIdentifier(tableName)
	local sqlWhere = buildWhereClause(clause)
	if not sqlTable or sqlWhere == nil then
		return false
	end
	return query_rows_assoc("SELECT * FROM " .. sqlTable .. sqlWhere)
end

function select_one(tableName, clause)
	local sqlTable = sqlIdentifier(tableName)
	local sqlWhere = buildWhereClause(clause)
	if not sqlTable or sqlWhere == nil then
		return false
	end
	return query_fetch_assoc("SELECT * FROM " .. sqlTable .. sqlWhere .. " LIMIT 1")
end

function insert(tableName, values)
	local sqlTable = sqlIdentifier(tableName)
	local setClause = buildSetClause(values)
	if not sqlTable or not setClause then
		return false
	end
	return query_insert_free("INSERT INTO " .. sqlTable .. " SET " .. setClause)
end

function update(tableName, values, clause)
	local sqlTable = sqlIdentifier(tableName)
	local setClause = buildSetClause(values)
	local sqlWhere = buildWhereClause(clause)
	if not sqlTable or not setClause or sqlWhere == nil then
		return false
	end
	return query_free("UPDATE " .. sqlTable .. " SET " .. setClause .. sqlWhere)
end

function delete(tableName, clause)
	local sqlTable = sqlIdentifier(tableName)
	local sqlWhere = buildWhereClause(clause)
	if not sqlTable or sqlWhere == nil or sqlWhere == "" then
		return false
	end
	return query_free("DELETE FROM " .. sqlTable .. sqlWhere)
end
