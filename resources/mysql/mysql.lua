--[[
* ***********************************************************************************************************************
* Copyright (c) 2015 OwlGaming Community - All Rights Reserved
* All rights reserved. This program and the accompanying materials are private property belongs to OwlGaming Community
* Unauthorized copying of this file, via any medium is strictly prohibited
* Proprietary and confidential
* ***********************************************************************************************************************
]]
-- Production Server
production = (get( "production_server" ) == "1" or false)
socket = get( "socket" ) or ""

-- connection settings
hostname = get( "hostname" )
username = get( "username" )
password = get( "password" )
database = get( "database" )
port = tonumber( get( "port" ) )

core_hostname = get( "core_hostname" )
core_username = get( "core_username" )
core_password = get( "core_password" )
core_database = get( "core_database" )
core_port = tonumber( get( "core_port" ) )
core_fallback_to_mta = get( "core_fallback_to_mta" ) ~= "0"

local dbConns = {}
local coreAliasAnnounced = false

local function isValidConnection(conn)
	return isElement(conn)
end

local function shouldAliasCoreToMta()
	if not core_database or tostring(core_database) == "" then
		return true
	end

	return tostring(core_database) == tostring(database)
		and tostring(core_hostname or "") == tostring(hostname or "")
		and tonumber(core_port or 0) == tonumber(port or 0)
		and tostring(core_username or "") == tostring(username or "")
		and tostring(core_password or "") == tostring(password or "")
end

local function announceCoreAlias(reason)
	if coreAliasAnnounced then
		return
	end
	coreAliasAnnounced = true
	outputDebugString("[MYSQL] core connection routed to mta connection ("..reason..")")
end

local function connectMta(res)
	if isValidConnection(dbConns.mta) then
		return dbConns.mta
	end

	dbConns.mta = dbConnect("mysql", "dbname=".. database ..";host="..hostname..";port="..port..";"..socket, username, password, "autoreconnect=1")
	if dbConns.mta then
		if eventName then
			outputDebugString("[MYSQL] createConnection / "..database.." / OK")
		else
			connectToDatabase(res) -- Restart the connection for the MySQL Module
			outputDebugString("[MYSQL] reconnectConnection / "..database.." / OK")
		end
	else
		if eventName then
			outputDebugString("[MYSQL] createConnection / "..database.." / FAILED")
		else
			outputDebugString("[MYSQL] reconnectConnection / "..database.." / FAILED")
		end
	end

	if isValidConnection(dbConns.mta) then
		createMigrationsTable()
	end
	return dbConns.mta
end

local function connectCore(res)
	if isValidConnection(dbConns.core) then
		return dbConns.core
	end

	local mtaConn = connectMta(res)
	if shouldAliasCoreToMta() and isValidConnection(mtaConn) then
		dbConns.core = mtaConn
		announceCoreAlias("shared configuration")
		return dbConns.core
	end

	dbConns.core = dbConnect("mysql", "dbname=".. core_database ..";host="..core_hostname..";port="..core_port..";"..socket, core_username, core_password, "autoreconnect=1")
	if dbConns.core then
		if eventName then
			outputDebugString("[MYSQL] createConnection / "..core_database.." / OK")
		else
			outputDebugString("[MYSQL] reconnectConnection / "..core_database.." / OK")
		end
		return dbConns.core
	end

	if eventName then
		outputDebugString("[MYSQL] createConnection / "..core_database.." / FAILED")
	else
		outputDebugString("[MYSQL] reconnectConnection / "..core_database.." / FAILED")
	end

	if core_fallback_to_mta and isValidConnection(mtaConn) then
		dbConns.core = mtaConn
		announceCoreAlias("fallback after failed core connect")
	end

	return dbConns.core
end

function createConnection(res, db)
	local dbName = db or "mta"
	if dbName == "core" then
		connectCore(res)
	else
		connectMta(res)
	end

	if not eventName then
		return dbConns[dbName]
	end
end
addEventHandler("onResourceStart", resourceRoot, createConnection)

function getConn(db)
	local dbName = db or "mta"
	if isValidConnection(dbConns[dbName]) then
		return dbConns[dbName]
	end

	if dbName == "core" then
		return connectCore(false)
	else
		return connectMta(false)
	end
end

function getSmallestID( table, index )
	index = index or 'id'
	return "(SELECT MIN(e1."..index.."+1) FROM "..table.." AS e1 LEFT JOIN "..table.." AS e2 ON e1."..index.." +1 = e2."..index.." WHERE e2."..index.." IS NULL)"
end
