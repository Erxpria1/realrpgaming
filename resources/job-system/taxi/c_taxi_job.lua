local blip

function resetTaxiJob()
	if (isElement(blip)) then
		destroyElement(blip)
		removeEventHandler("onClientVehicleEnter", getRootElement(), startTaxiJob)
	end
end

function displayTaxiJob()
	removeEventHandler("onClientVehicleEnter", getRootElement(), startTaxiJob)
	blip = createBlip(1787.1259765625, -1903.591796875, 13.394536972046, 0, 4, 255, 255, 0) --Unity station blip
	exports.hud:sendBottomNotification(localPlayer, "Taksi Şoförü", "Radarınızdaki sarı işarete gidin ve bir Taksi'ye binerek işe başlayın.") --Text upon job selection and spawn
	addEventHandler("onClientVehicleEnter", getRootElement(), startTaxiJob)
end

function startTaxiJob(thePlayer)
	if (thePlayer==localPlayer) then
		if (getElementModel(source)==438 or getElementModel(source)==420) then
			removeEventHandler("onClientVehicleEnter", getRootElement(), startTaxiJob)
			exports.hud:sendBottomNotification(localPlayer, "Taksi Şoförü", "Birisi taksi çağırdığında bildirim alacaksınız. Taksi ışığını açıp kapatmak için /taxilight kullanın.") --When a taxi driver enters a taxi
			if (isElement(blip)) then
				destroyElement(blip)
			end
		end
	end
end
--[[
-- taxi drivers occupied light
local keytime = 0
local function checkTaxiLights( key, state )
	local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
	if getVehicleOccupant( vehicle ) == getLocalPlayer( ) and ( getElementModel( vehicle ) == 438 or getElementModel( vehicle ) == 420 ) then
		if state == "down" then
			keytime = getTickCount()
		elseif state == "up" and keytime ~= 0 then
			local delay = getTickCount() - keytime
			keytime = 0
			
			if delay < 200 then
				triggerServerEvent("toggleTaxiLights", getLocalPlayer( ), vehicle )
			end
		end
	else
		keytime = 0
	end
end
bindKey("horn", "both", checkTaxiLights)]]