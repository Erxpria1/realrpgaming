function showStats(thePlayer, commandName, targetPlayerName)
	if getElementData(thePlayer, "loggedin") ~= 1 then
		outputChatBox("Giriş yapmamışsınız.", thePlayer, 255, 0, 0)
		return
	end

	local showPlayer = thePlayer
	if exports.integration:isPlayerTrialAdmin(thePlayer) and targetPlayerName then
		targetPlayer = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerName)
		if targetPlayer then
			if getElementData(targetPlayer, "loggedin") == 1 then
				thePlayer = targetPlayer
			else
				outputChatBox("Oyuncu giriş yapmamış.", showPlayer, 255, 0, 0)
				return
			end
		else
			return
		end
	end
	
	local isOverlayDisabled = getElementData(showPlayer, "hud:isOverlayDisabled")
	--LICNESES
	local carlicense = getElementData(thePlayer, "license.car")
	local bikelicense = getElementData(thePlayer, "license.bike")
	local boatlicense = getElementData(thePlayer, "license.boat")
	--local pilotlicense = getElementData(thePlayer, "license.pilot")
	local fishlicense = getElementData(thePlayer, "license.fish")
	local gunlicense = getElementData(thePlayer, "license.gun")
	local gun2license = getElementData(thePlayer, "license.gun2")
	if (carlicense==1) then
		carlicense = "Evet"
	elseif (carlicense==3) then
		carlicense = "Teorik sınavı geçti"
	else
		carlicense = "Hayır"
	end
	if (bikelicense==1) then
		bikelicense = "Evet"
	elseif (bikelicense==3) then
		bikelicense = "Teorik sınavı geçti"
	else
		bikelicense = "Hayır"
	end
	if (boatlicense==1) then
		boatlicense = "Evet"
	else
		boatlicense = "Hayır"
	end
	
	local pilotLicenses = exports.mdc:getPlayerPilotLicenses(thePlayer) or {}
	local pilotlicense = ""
	local maxShow = 5
	local numAdded = 0
	local numOverflow = 0
	local typeratings = 0
	for k,v in ipairs(pilotLicenses) do
		local licenseID = v[1]
		local licenseValue = v[2]
		local licenseName = v[3]
		if licenseID == 7 then --if typerating
			if licenseValue then
				typeratings = typeratings + 1
			end
		else
			if numAdded >= maxShow then
				numOverflow = numOverflow + 1
			else
				if numAdded == 0 then
					pilotlicense = pilotlicense..tostring(licenseName)
				else
					pilotlicense = pilotlicense..", "..tostring(licenseName)
				end
				numAdded = numAdded + 1
			end
		end
	end
	if(numAdded == 0) then
		pilotlicense = "Hayır"
	else
		if numOverflow > 0 then
			pilotlicense = pilotlicense.." (+"..tostring(numOverflow+typeratings)..")"
		else
			if typeratings > 0 then
				pilotlicense = pilotlicense.." (+"..tostring(typeratings)..")"
			else
				pilotlicense = pilotlicense.."."
			end
		end
	end
	
	if (fishlicense==1) then
		fishlicense = "Evet"
	else
		fishlicense = "Hayır"
	end
	if (gunlicense==1) then
		gunlicense = "Evet"
	else
		gunlicense = "Hayır"
	end
	if (gun2license==1) then
		gun2license = "Evet"
	else
		gun2license = "Hayır"
	end
	--VEHICLES
	local dbid = tonumber(getElementData(thePlayer, "dbid"))
	local carids = ""
	local numcars = 0
	local printCar = ""
	for key, value in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
		local owner = tonumber(getElementData(value, "owner"))

		if (owner) and (owner==dbid) then
			local id = getElementData(value, "dbid")
			carids = carids .. id .. ", "
			numcars = numcars + 1
			exports.anticheat:changeProtectedElementDataEx(value, "owner_last_login", exports.datetime:now(), true)
		end
	end
	printCar = numcars .. "/" .. getElementData(thePlayer, "maxvehicles")

	-- PROPERTIES
	local properties = ""
	local numproperties = 0
	for key, value in ipairs(getElementsByType("interior")) do
		local stt = getElementData(value, "status")
		if stt.owner and stt.owner == dbid and getElementData(value, "name") then
			local id = getElementData(value, "dbid")
			properties = properties .. id .. ", "
			numproperties = numproperties + 1
			--Update owner last login / MAXIME 2015.01.07
			exports.anticheat:changeProtectedElementDataEx(value, "owner_last_login", exports.datetime:now(), true)
		end
	end

	if (properties=="") then properties = "Yok.  " end
	if (carids=="") then carids = "Yok.  " end
	--FETCH ABOVE
	local hoursplayed = getElementData(thePlayer, "hoursplayed")
	local info = {}
	if isOverlayDisabled then
		outputChatBox(getPlayerName(thePlayer):gsub("_", " "), showPlayer , 255, 194, 14)
		outputChatBox(" Araç Ehliyeti: " .. carlicense, showPlayer)
		outputChatBox(" Motosiklet Ehliyeti: " .. bikelicense, showPlayer)
		outputChatBox(" Tekne Ehliyeti: " .. boatlicense, showPlayer)
		outputChatBox(" Pilotluk Lisansı: " .. pilotlicense, showPlayer)
		outputChatBox(" Seviye 1 Ateşli Silah Lisansı: " .. gunlicense , showPlayer)
		outputChatBox(" Seviye 2 Ateşli Silah Lisansı: " .. gun2license , showPlayer)
		outputChatBox(" Balıkçılık İzni: " .. fishlicense, showPlayer)
		outputChatBox(" Araçlar (" .. printCar .. "): " .. string.sub(carids, 1, string.len(carids)-2) , showPlayer)
		outputChatBox(" Mülkler (" .. numproperties .. "/"..(getElementData(thePlayer, "maxinteriors") or 10).."): " .. string.sub(properties, 1, string.len(properties)-2) , showPlayer)
		outputChatBox(" Karakterde geçirilen süre: " .. hoursplayed .. " saat." , showPlayer)
		outputChatBox(" Diller: " , showPlayer)
	else
		info = {
			{getPlayerName(thePlayer):gsub("_", " ")},
			{""},
			{" Doğum tarihi: "..exports.global:getPlayerDoB(thePlayer)},
			{" Araç Ehliyeti: " .. carlicense},
			{" Motosiklet Ehliyeti: " .. bikelicense},
			{" Tekne Ehliyeti: " .. boatlicense},
			{" Pilotluk Lisansı: " .. pilotlicense},
			{" Seviye 1 Ateşli Silah Lisansı: " .. gunlicense},
			{" Seviye 2 Ateşli Silah Lisansı: " .. gun2license},
			{" Balıkçılık İzni: " .. fishlicense},
			{" Araçlar (" .. printCar .. "): " .. string.sub(carids, 1, string.len(carids)-2)},
			{" Mülkler (" .. numproperties .. "/"..(getElementData(thePlayer, "maxinteriors") or 10).."): " .. string.sub(properties, 1, string.len(properties)-2)},
			{" Karakterde geçirilen süre: " .. hoursplayed .. " saat."},
			{" Diller: "},
		}
	end
	--LANGUAGES
	for i = 1, 3 do
		local lang = getElementData(thePlayer, "languages.lang" .. i)
		if lang and lang ~= 0 then
			local skill = getElementData(thePlayer, "languages.lang" .. i .. "skill")
			local langname = exports['language-system']:getLanguageName( lang )
			if langname then
				if isOverlayDisabled then
					outputChatBox("   - "..langname.." (" .. skill .. "%)", showPlayer)
				else
					table.insert(info, {"   - "..langname.." (" .. skill .. "%)"})
				end
			end
		end
	end
	--CAREER
	local job = getElementData(thePlayer, "job") or 0
	if job == 0 then
		if isOverlayDisabled then
			outputChatBox(" Meslek: İşsiz", showPlayer)
		else
			table.insert(info, {" Meslek: İşsiz"})
		end
	else
		local jobName = exports["job-system"]:getJobTitleFromID(job)
		local joblevel = getElementData(thePlayer, "jobLevel") or 1
		local jobProgress = getElementData(thePlayer, "jobProgress") or 0
		if isOverlayDisabled then
			outputChatBox(" Meslek: "..jobName, showPlayer)
			outputChatBox("   - Yetenek Seviyesi: "..joblevel, showPlayer)
			outputChatBox("   - İlerleme: "..jobProgress, showPlayer)
		else
			table.insert(info, {" Meslek: "..jobName})
			table.insert(info, {"   - Yetenek Seviyesi: "..joblevel})
			table.insert(info, {"   - İlerleme: "..jobProgress})
		end
	end
	--CARRIED
	local carried = " Taşınan Ağırlık: "..("%.2f/%.2f" ):format( exports["item-system"]:getCarriedWeight( thePlayer ), exports["item-system"]:getMaxWeight( thePlayer ) ).." kg"
	if isOverlayDisabled then
		outputChatBox( carried, showPlayer)
	else
		table.insert(info, {carried})
	end
	--FINANCE
	local currentGC = getElementData(thePlayer, "credits") or 0
	local bankmoney = getElementData(thePlayer, "bankmoney") or 0
	local money = getElementData(thePlayer, "money") or 0
	if isOverlayDisabled then
		outputChatBox( " Finans: ", showPlayer)
		outputChatBox( "   - GCs: "..exports.global:formatMoney(currentGC), showPlayer)
		outputChatBox( "   - Nakit: $"..exports.global:formatMoney(money), showPlayer)
		outputChatBox( "   - Bankadaki Para: $"..exports.global:formatMoney(bankmoney), showPlayer)
	else
		table.insert(info, {" Finans: "})
		table.insert(info, {"   - GCs: "..exports.global:formatMoney(currentGC)})
		table.insert(info, {"   - Nakit: $"..exports.global:formatMoney(money)})
		table.insert(info, {"   - Bankadaki Para: $"..exports.global:formatMoney(bankmoney)})
	end
	
	if not isOverlayDisabled then
		triggerClientEvent(showPlayer, "hudOverlay:drawOverlayTopRight", showPlayer, info ) 
	end
end
addCommandHandler("stats", showStats, false, false)
addEvent("showStats", true)
addEventHandler("showStats", root, showStats)
