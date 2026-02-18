mysql = exports.mysql
local lockTimer = nil
chDimension = 125
chInterior = 3

-- CALL BACKS FROM CLIENT

function onEmploymentServer()
	exports.global:sendLocalText(source, "Jessie Smith diyor: Merhaba, yeni bir iş mi arıyorsunuz?", nil, nil, nil, 10)
	exports.global:sendLocalText(source, " *Jessie Smith, " .. getPlayerName(source):gsub("_", " ") .. " adlı kişiye iş listesini uzatır.", 255, 51, 102)
end

addEvent("onEmploymentServer", true)
addEventHandler("onEmploymentServer", getRootElement(), onEmploymentServer)

function givePlayerJob(jobID)
	local charname = getPlayerName(source)
	local charID = getElementData(source, "dbid")
	mysql:query_free("UPDATE `characters` SET `job`='"..tostring(jobID).."' WHERE `id`='"..mysql:escape_string(charID).."' ")
	
	if (jobID==4) then -- CITY MAINTENANCE
		exports.global:giveItem(source, 115, "41:1:Spraycan", 2500)
		outputChatBox("Use this spray to paint over the graffiti you find.", source, 255, 194, 14)
		exports.anticheat:changeProtectedElementDataEx(source, "tag", 9, false)
		mysql:query_free("UPDATE characters SET tag=9 WHERE id = " .. mysql:escape_string(getElementData(source, "dbid")) )
	end
	fetchJobInfoForOnePlayer(source)
end
addEvent("acceptJob", true)
addEventHandler("acceptJob", getRootElement(), givePlayerJob)

function fetchJobInfo()
	if not charID then
		for key, player in pairs(getElementsByType("player")) do
			fetchJobInfoForOnePlayer(player)
		end
	end
end

function fetchJobInfoForOnePlayer(thePlayer)
	local charID = getElementData(thePlayer, "dbid")
	local jobInfo = mysql:query_fetch_assoc("SELECT `job` , `jobID`, `jobLevel`, `jobProgress`, `jobTruckingRuns` FROM `characters` LEFT JOIN `jobs` ON `id` = `jobCharID` AND `job` = `jobID` WHERE `id`='" .. tostring(charID) .. "' ")
	if jobInfo then
		local job = tonumber(jobInfo["job"])
		local jobID = tonumber(jobInfo["jobID"])
		if job and job == 0 then
			setElementData(thePlayer, "job", 0, true)
			setElementData(thePlayer, "jobLevel", 0 , true)
			setElementData(thePlayer, "jobProgress", 0, true)
			setElementData(thePlayer, "job-system-trucker:truckruns", 0, true)
			return true
		end
		
		if not jobID then
			mysql:query_free("INSERT INTO `jobs` SET `jobID`='"..tostring(job).."', `jobCharID`='"..mysql:escape_string(charID).."' ")
		end
	
		setElementData(thePlayer, "job", job, true)
		setElementData(thePlayer, "jobLevel", tonumber(jobInfo["jobLevel"]) or 1, true)
		setElementData(thePlayer, "jobProgress", tonumber(jobInfo["jobProgress"]) or 0, true)
		setElementData(thePlayer, "job-system-trucker:truckruns", tonumber(jobInfo["jobTruckingRuns"]) or 0, true)
	else
		outputDebugString("[Job system] fetchJobInfoForOnePlayer / DB error")
		return false
	end
end

function printJobInfo(thePlayer)
	outputChatBox("~-~-~-~-~-~-~-~-~-~Kariyer Bilgisi~-~-~-~-~-~-~-~-~-~-~", thePlayer, 255, 194, 14)
	outputChatBox("Meslek: "..(getJobTitleFromID(getElementData(thePlayer, "job")) or "İşsiz") , thePlayer, 255, 194, 14)
	outputChatBox("Unvan/Seviye: "..(tonumber(getElementData(thePlayer, "jobLevel")) or "0") , thePlayer, 255, 194, 14)
	outputChatBox("İlerleme: "..(tonumber(getElementData(thePlayer, "jobProgress")) or "0") , thePlayer, 255, 194, 14)
	outputChatBox("~-~-~-~--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-", thePlayer, 255, 194, 14)
end
addCommandHandler("myjob", printJobInfo)

function quitJob(source)
	local logged = getElementData(source, "loggedin")
	if logged == 1 then
		local job = getElementData(source, "job")
		if job == 0 then
			outputChatBox("Şu anda işsizsiniz.", source, 255, 0, 0)
		else
			local charID = getElementData(source, "dbid")
			mysql:query_free("UPDATE `characters` SET `job`='0' WHERE `id`='"..mysql:escape_string(charID).."' ")
			fetchJobInfoForOnePlayer(source)
			if job == 4 then
				exports.anticheat:changeProtectedElementDataEx(source, "tag", 1, false)
				mysql:query_free("UPDATE characters SET tag=1 WHERE id = " .. mysql:escape_string(charID) )
			end
			triggerClientEvent(source, "quitJob", source, job)
		end
	end
end
addCommandHandler("endjob", quitJob, false, false)
addCommandHandler("quitjob", quitJob, false, false)

-- PREVENT UNEMPLOYED PLAYER GETTING IN DRIVER SEAT OR JACKING JOB VEHICLES -- MAXIME
function startEnterVehJob(thePlayer, seat, jacked) 
	local vjob = tonumber(getElementData(source, "job")) or 0
	local job = getElementData(thePlayer, "job")
	local seat = getPedOccupiedVehicleSeat(thePlayer) or 0
	if vjob>0 and job~=vjob and seat == 0 and not (getElementData(thePlayer, "duty_admin") == 1) and not (getElementData(thePlayer, "duty_supporter") == 1) then
		if (vjob==1) then
			outputChatBox("Bu araç bir teslimat şoförüne ait. Bu işi almak için belediye binasını ziyaret edin.", thePlayer, 255, 0, 0)
		elseif (vjob==2) then
			outputChatBox("Bu araç bir taksi şoförüne ait. Bu işi almak için belediye binasını ziyaret edin.", thePlayer, 255, 0, 0)
		elseif (vjob==3) then
			outputChatBox("Bu araç bir otobüs şoförüne ait. Bu işi almak için belediye binasını ziyaret edin.", thePlayer, 255, 0, 0)
		end
		if isTimer(lockTimer) then
			killTimer(lockTimer)
			lockTimer = nil
		end
		setVehicleLocked(source, true)
		lockTimer = setTimer(setVehicleLocked, 5000, 1, source, false)
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), startEnterVehJob)

--[[ -- Removed by MAXIME  
function resetContract( thePlayer, commandName, targetPlayerName )
	if (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer)) then
		if targetPlayerName then
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayerName )
			if targetPlayer then
				if getElementData( targetPlayer, "loggedin" ) == 1 then
					local result = mysql:query_free("UPDATE characters SET jobcontract = 0 WHERE id = " .. mysql:escape_string(getElementData( targetPlayer, "dbid" )) .. " AND jobcontract > 0" )
					if result then
						outputChatBox( "Reset Job Contract for " .. targetPlayerName, thePlayer, 0, 255, 0 )
					else
						outputChatBox( "Failed to reset Job Contract Time.", thePlayer, 255, 0, 0 )
					end
				else
					outputChatBox( "Player is not logged in.", thePlayer, 255, 0, 0 )
				end
			end
		else
			outputChatBox( "SYNTAX: /" .. commandName .. " [player]", thePlayer, 255, 194, 14 )
		end
	end
end
--addCommandHandler("resetcontract", resetContract, false, false)
]]

-- AUTO SPAWN JOB VEHICLES IF MISSING
function checkAndSpawnJobVehicles()
	-- Mevcut job araçlarının yakıtını veritabanında güncelle (benzinsiz başlama sorununu kökten çözer)
	mysql:query_free("UPDATE vehicles SET fuel=100 WHERE faction=-1 AND job > 0")

	-- 1. BUS CHECK
	local busCount = 0
	local buses = exports.pool:getPoolElementsByType("vehicle")
	for key, veh in pairs(buses) do
		if getElementModel(veh) == 431 then
			busCount = busCount + 1
		end
	end

	if busCount == 0 then
		outputDebugString("[JOB-SYSTEM] No buses found! Spawning default buses...")
		-- Unity Station Bus Stop (Geniş aralık - 25 birim mesafe, garaja daha uygun konum)
		local positions = {
			{1784, -1890, 13.4, 0, 0, 270},
			{1784, -1915, 13.4, 0, 0, 270},
			{1784, -1940, 13.4, 0, 0, 270},
			{1784, -1965, 13.4, 0, 0, 270}
		}
		
		for i, pos in ipairs(positions) do
			local query = "INSERT INTO vehicles SET model=431, x="..pos[1]..", y="..pos[2]..", z="..pos[3]..", rotx="..pos[4]..", roty="..pos[5]..", rotz="..pos[6]..", currx="..pos[1]..", curry="..pos[2]..", currz="..pos[3]..", currrx="..pos[4]..", currry="..pos[5]..", currrz="..pos[6]..", color1='[255,255,255]', color2='[0,0,0]', faction=-1, owner=-1, job=3, plate='BUS-"..i.."', locked=0, fuel=100"
			mysql:query_free(query)
		end
		outputDebugString("[JOB-SYSTEM] 4 Buses spawned and saved to DB with full fuel.")
	end

	-- 2. TAXI CHECK
	local taxiCount = 0
	for key, veh in pairs(buses) do
		if getElementModel(veh) == 420 or getElementModel(veh) == 438 then
			taxiCount = taxiCount + 1
		end
	end

	if taxiCount == 0 then
		outputDebugString("[JOB-SYSTEM] No taxis found! Spawning default taxis...")
		-- Unity Station Taxi Stand (Otobüslerin karşı tarafına, geniş aralıkla - 15 birim mesafe)
		local positions = {
			{1810, -1890, 13.4, 0, 0, 90},
			{1810, -1905, 13.4, 0, 0, 90},
			{1810, -1920, 13.4, 0, 0, 90},
			{1810, -1935, 13.4, 0, 0, 90}
		}
		
		for i, pos in ipairs(positions) do
			local query = "INSERT INTO vehicles SET model=420, x="..pos[1]..", y="..pos[2]..", z="..pos[3]..", rotx="..pos[4]..", roty="..pos[5]..", rotz="..pos[6]..", currx="..pos[1]..", curry="..pos[2]..", currz="..pos[3]..", currrx="..pos[4]..", currry="..pos[5]..", currrz="..pos[6]..", color1='[255,255,0]', color2='[0,0,0]', faction=-1, owner=-1, job=2, plate='TAXI-"..i.."', locked=0, fuel=100"
			mysql:query_free(query)
		end
		outputDebugString("[JOB-SYSTEM] 4 Taxis spawned and saved to DB with full fuel.")
	end
	
	-- Reload vehicles if we spawned any
	if busCount == 0 or taxiCount == 0 then
		setTimer(function() 
			if getResourceFromName("vehicle_load") then
				restartResource(getResourceFromName("vehicle_load")) 
			end
		end, 5000, 1) -- Wait 5 sec for DB insert then reload vehicles
	end
end
addEventHandler("onResourceStart", resourceRoot, checkAndSpawnJobVehicles)