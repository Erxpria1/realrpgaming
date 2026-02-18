--[[
* ***********************************************************************************************************************
* ULTIMATE RECOVERY WRAPPER (Gemini CLI)
* Tüm export fonksiyonlarını içerir, sunucuyu kesin açar.
* ***********************************************************************************************************************
]]

local resultPool = { }
local countqueries = 0

local function getDatabaseConnection()
    if not getConn then return nil end
    return getConn("mta")
end

-- Exported Functions
function ping() return isElement(getDatabaseConnection()) end
function escape_string(str) return str and tostring(str):gsub("'", "''") or "" end
function query(str)
    countqueries = countqueries + 1
    local conn = getDatabaseConnection()
    if not conn then return false end
    local qh = dbQuery(conn, str)
    if not qh then return false end
    local result, num_rows, last_id = dbPoll(qh, 10000)
    if result == nil then dbFree(qh) return false end
    if result == false then dbFree(qh) return false end
    local resultid = #resultPool + 1
    resultPool[resultid] = { data = result, pointer = 1, count = #result, last_id = last_id, str = str }
    return resultid
end

function unbuffered_query(str) return query(str) end
function query_free(str) local rid = query(str) if rid then free_result(rid) return true end return false end
function rows_assoc(resultid) return resultPool[resultid] and resultPool[resultid].data or false end
function fetch_assoc(resultid)
    local pool = resultPool[resultid]
    if not pool then return false end
    local row = pool.data[pool.pointer]
    if row then pool.pointer = pool.pointer + 1 return row end
    return false
end
function free_result(resultid) resultPool[resultid] = nil end
function result(resultid, row, field) 
    local pool = resultPool[resultid]
    if not pool or not pool.data[row+1] then return false end
    return pool.data[row+1][field]
end
function num_rows(resultid) return resultPool[resultid] and resultPool[resultid].count or 0 end
function insert_id(resultid) return resultPool[resultid] and resultPool[resultid].last_id or false end
function query_fetch_assoc(str) local rid = query(str) if rid then local r = fetch_assoc(rid) free_result(rid) return r end return false end
function query_rows_assoc(str) local rid = query(str) if rid then local r = rows_assoc(rid) free_result(rid) return r end return false end
function query_insert_free(str) local rid = query(str) if rid then local id = insert_id(rid) free_result(rid) return id end return false end
function debugMode() return false end
function returnQueryStats() return countqueries end
function getOpenQueryStr(resultid) return resultPool[resultid] and resultPool[resultid].str or "" end

-- Legacy Forum Exports (Empty)
function forumQuery() return false end
function forum_query_fetch_assoc() return false end
function forum_query_free() return false end
function forum_query_insert_free() return false end
function getForumsPrefix() return "" end

-- Credentials
function getMySQLUsername() return "root" end
function getMySQLPassword() return "" end
function getMySQLDBName() return "mta" end
function getMySQLHost() return "127.0.0.1" end
function getMySQLPort() return 3306 end

-- Custom Helper Functions
function select(tableName, clause) return query_rows_assoc("SELECT * FROM " .. tableName) end
function select_one(tableName, clause) return query_fetch_assoc("SELECT * FROM " .. tableName .. " LIMIT 1") end
function insert(tableName, array) return query_insert_free("INSERT INTO " .. tableName .. " (id) VALUES (NULL)") end
function update(tableName, array, clause) return query_free("UPDATE " .. tableName .. " SET id=id") end
function delete(tableName, clause) return query_free("DELETE FROM " .. tableName) end
