--MAXIME
mysql = exports.mysql
local streams = {}
local TURKISH_DEFAULT_STATIONS = {
	-- NOTE: Stream URLs can change over time. Use /radios panel to edit broken ones.
	{ "PowerTurk", "https://live.powerapp.com.tr/powerturk/abr/powerturk/128/playlist.m3u8" },
	{ "Power FM", "https://live.powerapp.com.tr/powerfm/abr/playlist.m3u8" },
	{ "Kral Pop", "https://dygedge.radyotvonline.com/kralpop/playlist.m3u8" },
	{ "Super FM", "https://dygedge.radyotvonline.com/superfm/playlist.m3u8" },
	{ "TRT FM", "https://radio-trtfm.live.trt.com.tr/master_128.m3u8" },
	{ "Alem FM", "https://turkmedya.radyotvonline.com/alemfm/playlist.m3u8" },
	{ "Metro FM", "https://dygedge.radyotvonline.com/metrofm/playlist.m3u8" },
	{ "Joy Turk", "https://dygedge.radyotvonline.com/joyturk/playlist.m3u8" },
}

local function getSmallestRadioStationID()
	local result = mysql:query_fetch_assoc("SELECT MIN(e1.id+1) AS nextID FROM radio_stations AS e1 LEFT JOIN radio_stations AS e2 ON e1.id +1 = e2.id WHERE e2.id IS NULL")
	if result then
		return tonumber(result["nextID"]) or 1
	end
	return 1
end

local function isLeadAdmin(player)
	return player and isElement(player) and exports.integration:isPlayerLeadAdmin(player)
end

local function stationExists(name, url)
	local q = dbQuery(exports.mysql:getConn("mta"), "SELECT id FROM radio_stations WHERE station_name = ? OR source = ? LIMIT 1", name, url)
	local rows = dbPoll(q, 10000)
	return rows and rows[1] and true or false
end

local function pushStationsToOnlinePlayers()
	for _, player in ipairs(getElementsByType("player")) do
		triggerClientEvent(player, "getStationsFromServer", player, streams)
	end
end

function fetchStation()
	local preparedQ = "SELECT * FROM `radio_stations` WHERE `enabled`='1' AND ((`expire_date` IS NULL) OR (`expire_date` > NOW())) ORDER BY `id` ASC"
	local mQuery = mysql:query(preparedQ)
	streams = {
		[0] = { "Radio Off", "" },
	}
	local count = 0
	while true do
		local row = mysql:fetch_assoc(mQuery)
		if not row then break end
		table.insert(streams, {row["station_name"], row["source"] } )
		count = count + 1
	end
	outputDebugString("Server: Fetched "..(count).." stations from db.")
	mysql:free_result(mQuery)
	return count
end

function resourceStart()
	fetchStation()
	setTimer(fetchStation, RADIO_SERVER_REFRESHRATE, 0)
end
addEventHandler("onResourceStart", resourceRoot, resourceStart)

function seedTurkishStations(player, cmd)
	if not isLeadAdmin(player) then
		outputChatBox("Bu komutu kullanmak icin Lead Admin olman gerekiyor.", player, 255, 0, 0)
		return
	end

	local added, skipped = 0, 0
	for _, station in ipairs(TURKISH_DEFAULT_STATIONS) do
		local name, url = station[1], station[2]
		if stationExists(name, url) then
			skipped = skipped + 1
		else
			local id = getSmallestRadioStationID()
			if dbExec(exports.mysql:getConn("mta"), "INSERT INTO radio_stations (id, station_name, source, owner, enabled, `order`) VALUES (?, ?, ?, 0, 1, ?)", id, name, url, id) then
				added = added + 1
			end
		end
	end

	fetchStation()
	pushStationsToOnlinePlayers()

	if player and isElement(player) then
		outputChatBox("Turkce radyo paketi tamamlandi. Eklenen: " .. added .. ", atlanan: " .. skipped .. ".", player, 0, 255, 0)
		outputChatBox("Bozuk URL olursa /radios panelinden istasyon URL'sini guncelleyebilirsin.", player, 255, 194, 14)
	end
end
addCommandHandler("seedtrradio", seedTurkishStations)

function getStreams()
	return streams
end

function sendStationsToClient()
	if streams and #streams > 0 then
		outputDebugString("Server: sending "..(#streams).." stations to client.")
		triggerClientEvent(source, "getStationsFromServer", source, streams)
	end
end
addEvent("sendStationsToClient", true)
addEventHandler("sendStationsToClient", root, sendStationsToClient)

function forceSyncStationsToAllclients()
	local stations = fetchStation()
	local syncedClients, failedClients = 0, 0
	if stations and tonumber(stations) and tonumber(stations) > 0 then
		for i, player in pairs(getElementsByType("player")) do
			if triggerClientEvent(player, "getStationsFromServer", player, streams) then
				syncedClients = syncedClients + 1
			else
				failedClients = failedClients + 1
			end
		end
		exports.hud:sendBottomNotification(client, "Radio Station Manager", stations.." radio station(s) have been successfully synced to "..syncedClients.." online clients ("..failedClients.." failed).")
	else
		exports.hud:sendBottomNotification(client, "Radio Station Manager", "Could not synced any radio stations.")
	end
end
addEvent("forceSyncStationsToAllclients", true)
addEventHandler("forceSyncStationsToAllclients", root, forceSyncStationsToAllclients)
