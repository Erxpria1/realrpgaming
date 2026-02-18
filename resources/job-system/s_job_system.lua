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
	-- 1. VERİTABANI TEMİZLİĞİ (Tüm sahipsiz iş araçlarını tek seferde uçurur)
	mysql:query_free("DELETE FROM vehicles WHERE model IN (431, 420, 438) AND owner = -1 AND faction = -1")
	outputDebugString("[JOB-SYSTEM] Database cleared for sahess (owner -1, faction -1) buses and taxis.")

	-- 2. CANLI ELEMENT TEMİZLİĞİ (Görünürdeki araçları yok eder)
	local vehicles = getElementsByType("vehicle")
	local count = 0
	for _, veh in pairs(vehicles) do
		local model = getElementModel(veh)
		local owner = getElementData(veh, "owner") or -1
		local faction = getElementData(veh, "faction") or -1
		
		-- Sahipsiz ve Job modellerinden ise (Otobüs/Taksi) sil
		if (model == 431 or model == 420 or model == 438) and owner == -1 and faction == -1 then
			destroyElement(veh)
			count = count + 1
		end
	end
	outputDebugString("[JOB-SYSTEM] " .. count .. " existing vehicle elements destroyed.")

	-- 3. YAKIT GÜNCELLEMESİ (Halihazırda kalan diğer iş araçları varsa diye)
	mysql:query_free("UPDATE vehicles SET fuel=100 WHERE faction=-1 AND job > 0")

	-- 4. YENİ ARAÇLARI SPAWN ET (7 Otobüs & 7 Taksi - Karşılıklı)
	outputDebugString("[JOB-SYSTEM] Spawning 7-7 fresh buses and taxis with 100 fuel...")
	
	local startY = -1890
	local spacing = 12

	for i = 1, 7 do
		local currentY = startY - ((i-1) * spacing)
		
		-- OTOBÜS (Sol Taraf - X: 1784)
		local busQuery = "INSERT INTO vehicles SET model=431, x=1784, y="..currentY..", z=13.4, rotx=0, roty=0, rotz=270, currx=1784, curry="..currentY..", currz=13.4, currrx=0, currry=0, currrz=270, color1='[255,255,255]', color2='[0,0,0]', faction=-1, owner=-1, job=3, plate='BUS-"..i.."', locked=0, fuel=100"
		mysql:query_free(busQuery)
		
		-- TAKSİ (Sağ Taraf - X: 1810)
		local taxiQuery = "INSERT INTO vehicles SET model=420, x=1810, y="..currentY..", z=13.4, rotx=0, roty=0, rotz=90, currx=1810, curry="..currentY..", currz=13.4, currrx=0, currry=0, currrz=90, color1='[255,255,0]', color2='[0,0,0]', faction=-1, owner=-1, job=2, plate='TAXI-"..i.."', locked=0, fuel=100"
		mysql:query_free(taxiQuery)
	end

	-- 5. ARAÇLARI YENİDEN YÜKLE VE YAKITLARINI SETLE
	setTimer(function() 
		if getResourceFromName("vehicle_load") then
			restartResource(getResourceFromName("vehicle_load")) 
			setTimer(function()
				local currentVehicles = getElementsByType("vehicle")
				for _, veh in pairs(currentVehicles) do
					local job = getElementData(veh, "job") or 0
					if job > 0 and (getElementData(veh, "faction") or -1) == -1 then
						exports.anticheat:setEld(veh, "fuel", 100)
					end
				end
				outputDebugString("[JOB-SYSTEM] Final check: 14 vehicles reloaded and fueled up to 100.")
			end, 2000, 1)
		end
	end, 3000, 1)
end
addEventHandler("onResourceStart", resourceRoot, checkAndSpawnJobVehicles)