--[[
	Migrations allow resources to specify MySQL alterations that they wish to only run once.
	This will allow for developers on different databases to stay up to date with the latest
	changes that others have made.
]]

function createMigrationsTable()
	local db = getConn()
	local query = [[
	CREATE TABLE IF NOT EXISTS `migrations` (
	  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	  `resource` VARCHAR(45) NULL,
	  `migration` INT NULL,
	  UNIQUE INDEX `UNIQUE` (`resource` ASC, `migration` ASC));
	]]
	db:exec(query)
end

local function parseAlterAddColumn(migrationSql)
	if type(migrationSql) ~= "string" then
		return nil, nil
	end

	local sql = migrationSql:gsub("%s+", " "):gsub(";$", "")
	local tableName, columnName = sql:match("^%s*[Aa][Ll][Tt][Ee][Rr]%s+[Tt][Aa][Bb][Ll][Ee]%s+`?([%w_]+)`?%s+[Aa][Dd][Dd]%s+[Cc][Oo][Ll][Uu][Mm][Nn]%s+`?([%w_]+)`?")
	if tableName and columnName then
		return tableName, columnName
	end

	tableName, columnName = sql:match("^%s*[Aa][Ll][Tt][Ee][Rr]%s+[Tt][Aa][Bb][Ll][Ee]%s+`?([%w_]+)`?%s+[Aa][Dd][Dd]%s+`?([%w_]+)`?")
	return tableName, columnName
end

local function columnExists(db, tableName, columnName)
	if not tableName or not columnName then
		return false
	end

	local qh = dbQuery(db, [[
		SELECT 1
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_SCHEMA = DATABASE()
		  AND TABLE_NAME = ?
		  AND COLUMN_NAME = ?
		LIMIT 1
	]], tableName, columnName)

	if not qh then
		return false
	end

	local result = dbPoll(qh, -1)
	return type(result) == "table" and #result > 0
end

local function isAlreadySatisfied(db, migrationSql)
	local tableName, columnName = parseAlterAddColumn(migrationSql)
	if tableName and columnName then
		return columnExists(db, tableName, columnName)
	end

	return false
end

local function buildMigrations(query, resource, migrations)
	local db = getConn()
	local result = query:poll(0) or {}
	local applied = {}

	for _, row in ipairs(result) do
		local migrationIndex = tonumber(row.migration)
		if migrationIndex then
			applied[migrationIndex] = true
		end
	end

	for migrationIndex, migration in ipairs(migrations) do
		if not applied[migrationIndex] then
			local appliedNow = false
			if isAlreadySatisfied(db, migration) then
				appliedNow = true
				outputServerLog('[ Migration ] ' .. resource .. ': ' .. tostring(migrationIndex) .. ' (already satisfied)')
			else
				appliedNow = db:exec(migration) and true or false
				if appliedNow then
					outputServerLog('[ Migration ] ' .. resource .. ': ' .. tostring(migrationIndex))
				end
			end

			if appliedNow then
				db:exec('INSERT IGNORE INTO `migrations` (`resource`, `migration`) VALUES (?, ?)', resource, migrationIndex)
			end
		end
	end
end

--[[
	createMigrations
	params:
		(string) resource - the name of the resource the migration applies to.
		(array) migrations - the array of migrations to be applied.
]]
function createMigrations(resource, migrations)
	local db = getConn()
	db:query(buildMigrations, { resource, migrations }, "SELECT `migration` FROM `migrations` WHERE `resource` = ?", resource)
end
