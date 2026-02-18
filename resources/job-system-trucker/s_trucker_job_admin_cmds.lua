--[[
 * ***********************************************************************************************************************
 * Copyright (c) 2015 OwlGaming Community - All Rights Reserved
 * All rights reserved. This program and the accompanying materials are private property belongs to OwlGaming Community
 * Unauthorized copying of this file, via any medium is strictly prohibited
 * Proprietary and confidential
 * ***********************************************************************************************************************
 ]]
 
function getJobTitleFromID(jobID)
	return exports["job-system"]:getJobTitleFromID(jobID)
end

function givePlayerJob(thePlayer, commandName, targetPlayer, jobID, jobLevel, jobProgress)
	jobID = tonumber(jobID)
	if exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer) then
		local jobTitle = getJobTitleFromID(jobID)
		if not (targetPlayer) then
			printSetJobSyntax(thePlayer, commandName)
			return
		else
			
			if jobTitle == "Unemployed" then
				jobID = 0
			end
			
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				local username = getPlayerName(thePlayer)
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				else
					if (jobID==4) then -- CITY MAINTENANCE
						exports.global:giveItem(targetPlayer, 115, "41:1:Spraycan", 2500)
						outputChatBox("Use this spray to paint over the graffiti you find.", targetPlayer, 255, 194, 14)
						exports.anticheat:changeProtectedElementDataEx(targetPlayer, "tag", 9, true)
						mysql:query_free("UPDATE characters SET tag=9 WHERE id = " .. mysql:escape_string(getElementData(targetPlayer, "dbid")) )
					end
					
					mysql:query_free("UPDATE `characters` SET `job`='" .. mysql:escape_string(jobID) .. "' WHERE `id`='"..tostring(getElementData(targetPlayer, "dbid")).."' " )
					
					exports["job-system"]:fetchJobInfoForOnePlayer(targetPlayer)
					
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					if hiddenAdmin == 0 then
						outputChatBox("Your job has been set to '" .. jobTitle .. "' by "..tostring(adminTitle) .. " " .. getPlayerName(thePlayer):gsub("_", " ") ..". ", targetPlayer, 0, 255,0)
					else
						outputChatBox("Your job has been set to '" .. jobTitle .. "' by a hidden admin. ", targetPlayer, 0, 255,0)
					end
					outputChatBox("You have set " .. targetPlayerName .. "'s job to '"..jobTitle.."'.", thePlayer)
				end
			end
		end
	end
end
addCommandHandler("setjob", givePlayerJob, false, false)

function printSetJobSyntax(thePlayer, commandName)
	outputChatBox("SÖZDIZIMI: /" .. commandName .. " [Oyuncu Adı/ID] [Meslek ID, 0 = İşsiz]", thePlayer, 255, 194, 14)
	outputChatBox("ID#1: Teslimat Şoförü", thePlayer)
	outputChatBox("ID#2: Taksi Şoförü", thePlayer)
	outputChatBox("ID#3: Otobüs Şoförü", thePlayer)
	outputChatBox("ID#4: Şehir Bakım Görevlisi", thePlayer)
	outputChatBox("ID#5: Tamirci", thePlayer)
	outputChatBox("ID#6: Çilingir", thePlayer)
	outputChatBox("ID#7: Uzun Yol Tır Şoförü", thePlayer)
end

function setjobLevel(thePlayer, commandName, target, level, progress )
	if exports.integration:isPlayerLeadAdmin(thePlayer) then
		if not target or not tonumber(level) or (tonumber(level) < 1) then
			outputChatBox( "SÖZDIZİMİ: /" .. commandName .. " [oyuncu ID veya Adı] [Seviye] [İlerleme, isteğe bağlı]", thePlayer, 255, 194, 14 )
			return false
		end
		
		if not tonumber(progress) or (tonumber(progress) < 0) then
			progress = 0
		end
		
		level = math.floor(tonumber(level))
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
			
		if not targetPlayer then
			outputChatBox("'"..target.."' adlı oyuncu bulunamadı.", thePlayer, 255,0,0)
			return false
		end
		
		jobID = getElementData(targetPlayer, "job")
		
		if jobID <=0 then
			outputChatBox("Oyuncu şu anda işsiz, lütfen önce /setjob kullanın.", thePlayer, 255,0,0)
			return false
		end
		
		local sucess, msg = setPlayerJobLevel(targetPlayer, jobID, level, progress)
		if (getPlayerName(thePlayer) ~= getPlayerName(targetPlayer)) then
			outputChatBox(msg, thePlayer, 255, 194, 14)
			outputChatBox(msg, targetPlayer, 255, 194, 14)
		else
			outputChatBox(msg, targetPlayer, 255, 194, 14)
		end
		
		if sucess then
			return true
		else
			return false
		end
	end
end
addCommandHandler("setjoblevel", setjobLevel, false, false)

function setPlayerJobLevel(targetPlayer, jobID, level, progress)
	if mysql:query_free("UPDATE `jobs` SET `jobLevel`='"..level.."', `jobProgress`='"..progress.."' WHERE `jobCharID`='"..getElementData(targetPlayer, "dbid").."' AND `jobID`='"..jobID.."' " ) then
		exports["job-system"]:fetchJobInfoForOnePlayer(targetPlayer)
		return true, getPlayerName(targetPlayer):gsub("_", " ").." now has '"..getJobTitleFromID(jobID).."' job (Level: "..level..", Progress: "..progress..")"
	else
		return false, "Database Error, please report as bug"
	end
end

function delJob( thePlayer, commandName, targetPlayerName )
	if (exports.integration:isPlayerTrialAdmin(thePlayer) or exports.integration:isPlayerSupporter(thePlayer)) then
		if targetPlayerName then
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayerName )
			if targetPlayer then
				if getElementData( targetPlayer, "loggedin" ) == 1 then
					local result = mysql:query_free("UPDATE `characters` SET `job`='0' WHERE `id`='"..tostring(getElementData(targetPlayer, "dbid")).."' " )
					
					exports["job-system"]:fetchJobInfoForOnePlayer(targetPlayer)
					if result then
						outputChatBox( targetPlayerName.." adlı oyuncunun işi silindi.", thePlayer)
						local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
						if hiddenAdmin == 0 then
							local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
							outputChatBox("İşiniz "..tostring(adminTitle) .. " " .. getPlayerName(thePlayer).." tarafından silindi. Lütfen yeniden giriş yapın (F10).", targetPlayer, 0, 255,0)
						else
							outputChatBox("İşiniz gizli bir admin tarafından silindi.", targetPlayer, 0, 255,0)
						end
					else
						outputChatBox( "İş silinemedi.", thePlayer, 255, 0, 0 )
					end
				else
					outputChatBox( "Oyuncu giriş yapmamış.", thePlayer, 255, 0, 0 )
				end
			end
		else
			outputChatBox( "SÖZDIZİMİ: /" .. commandName .. " [oyuncu]", thePlayer, 255, 194, 14 )
		end
	end
end
addCommandHandler("deljob", delJob, false, false)

function adminRespawnAllTrucks(thePlayer, commandName)
	if (exports.integration:isPlayerTrialAdmin(thePlayer)) then
		outputChatBox("Respawned " .. tostring(respawnAllTrucks()) .. " Trucks.", thePlayer)
	else
		outputChatBox("Only Admin and above can access /"..commandName..".", thePlayer, 255,0,0)
	end
end
addCommandHandler("respawntrucks", adminRespawnAllTrucks, false, false)

function scripterSkipRoute(thePlayer, commandName, target)
	if not exports.integration:isPlayerTrialAdmin(thePlayer) then
		outputChatBox("Only Super Admin and above can access /"..commandName..".", thePlayer, 255,0,0)
		return false
	end
	if not target then
		outputChatBox("SYNTAX: /" .. commandName .. " [Player/ID]", thePlayer, 255, 194, 14)
		return
	end
	local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
	if targetPlayer then
		spawnRoute(targetPlayer, true)
	end
end
addCommandHandler("skiproute", scripterSkipRoute, false, false)
