local line, route, m_number, curCpType = nil

local busMarker, busNextMarker = nil
local busBlip, busNextBlip = nil
local busStopColShape = nil

local bus = { [431]=true, [437]=true }

local blip

function resetBusJob()
	removeEventHandler("onClientRender", root, renderBusInfo) -- Paneli Kaldır
	if (isElement(blip)) then
		destroyElement(blip)
		removeEventHandler("onClientVehicleEnter", getRootElement(), startBusJob)
		blip = nil
	end
	
	if isElement(busMarker) then
		destroyElement(busMarker)
		busMarker = nil
	end
	
	if isElement(busBlip) then
		destroyElement(busBlip)
		busBlip = nil
	end
	
	if isElement(busNextMarker) then
		destroyElement(busNextMarker)
		busNextMarker = nil
	end
	
	if isElement(busNextBlip) then
		destroyElement(busNextBlip)
		busNextBlip = nil
	end
	
	m_number = 0
	triggerServerEvent("payBusDriver", getLocalPlayer(), line, -1)
end

local screenW, screenH = guiGetScreenSize()
local font = "default-bold"

function renderBusInfo()
	if not busMarker then return end
	
	local x, y, z = getElementPosition(busMarker)
	local px, py, pz = getElementPosition(localPlayer)
	local dist = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
	
	local currentStopName = "Bilinmiyor"
	local nextStopName = "Hat Sonu"
	
	if route and route.stops then
		-- m_number, mevcut checkpoint indexi. Durak isimleri stops tablosunda.
		-- Logic: route.points[i][5] durak numarasını veriyor.
		
		-- Mevcut hedef
		local currentPointInfo = route.points[m_number]
		if currentPointInfo then
			if currentPointInfo[4] == true then -- Duraksa
				currentStopName = route.stops[currentPointInfo[5]] or "Durak"
			else -- Checkpoint ise
				-- Bir sonraki durağı bulmaya çalış
				for i = m_number, #route.points do
					if route.points[i][4] == true then
						currentStopName = "Yol Üzerinde -> " .. (route.stops[route.points[i][5]] or "Durak")
						break
					end
				end
			end
		end
	end

	-- Panel Çizimi (Alt Orta)
	local panelW, panelH = 400, 80
	local panelX, panelY = (screenW - panelW) / 2, screenH - panelH - 50
	
	dxDrawRectangle(panelX, panelY, panelW, panelH, tocolor(0, 0, 0, 150))
	dxDrawRectangle(panelX, panelY, panelW, 25, tocolor(255, 165, 0, 200)) -- Başlık çubuğu (Turuncu)
	
	dxDrawText("OTOBÜS GÜZERGAHI", panelX, panelY, panelX + panelW, panelY + 25, tocolor(255, 255, 255, 255), 1, font, "center", "center")
	
	dxDrawText("Hedef: " .. currentStopName, panelX + 10, panelY + 35, panelX + panelW - 10, panelY + 55, tocolor(255, 255, 255, 255), 1.2, "default-bold", "center", "top")
	dxDrawText("Mesafe: " .. math.floor(dist) .. "m", panelX + 10, panelY + 55, panelX + panelW - 10, panelY + 75, tocolor(200, 200, 200, 255), 1, "default", "center", "top")
end

function displayBusJob()
	blip = createBlip(1787.1259765625, -1903.591796875, 13.394536972046, 0, 4, 255, 255, 0)
	exports.hud:sendBottomNotification(localPlayer, "Otobüs Şoförü", "Radarınızdaki sarı işarete gidin ve bir Otobüs'e binerek işe başlayın.")
end

function startBusJob()
	local job = getElementData(getLocalPlayer(), "job")
	if (job == 3) then
		if blip then
			destroyElement(blip)
			blip = nil
		end
		if busMarker then
			exports.hud:sendBottomNotification(localPlayer, "Otobüs Şoförü", "Zaten bir otobüs güzergahı başlattınız.")
		else
			local vehicle = getPedOccupiedVehicle(getLocalPlayer())
			if vehicle and getVehicleController(vehicle) == getLocalPlayer() and bus[getElementModel(vehicle)] then
				line = math.random( 1, #g_bus_routes )
				route = g_bus_routes[line]
				curCpType = 0
				
				local x, y, z = 1811, -1890, 13 -- Depo başlangıç noktası
				busBlip = createBlip(x, y, z, 0, 3, 255, 200, 0, 255)
				busMarker = createMarker(x, y, z, "checkpoint", 4, 255, 200, 0, 150)
				busStopColShape = createColSphere(0, 0, 0, 5)
				
				addEventHandler("onClientMarkerHit", busMarker, updateBusCheckpointCheck)
				addEventHandler("onClientMarkerLeave", busMarker, checkWaitAtStop)
				addEventHandler("onClientColShapeHit", busStopColShape,
					function(element)
						if getElementType(element) == "vehicle" and bus[getElementModel(element)] then
							setVehicleLocked(vehicle, false)
						end
					end
				)
				addEventHandler("onClientColShapeLeave", busStopColShape,
					function(element)
						if getElementType(element) == "vehicle" and bus[getElementModel(element)] then
							setVehicleLocked(vehicle, true)
						end
					end
				)
				
				local nx, ny, nz = route.points[1][1], route.points[1][2], route.points[1][3]
				if (route.points[1][4]==true) then
					busNextMarker = createMarker( nx, ny, nz, "checkpoint", 2.5, 255, 0, 0, 150)
					busNextBlip = createBlip( nx, ny, nz, 0, 2, 255, 0, 0, 255)
				else
					busNextMarker = createMarker( nx, ny, nz, "checkpoint", 2.5, 255, 200, 0, 150)
					busNextBlip = createBlip( nx, ny, nz, 0, 2, 255, 200, 0, 255)
				end
				
				m_number = 1 -- İlk nokta 1. indexten başlar
				triggerServerEvent("payBusDriver", getLocalPlayer(), line, 0)
				
				setVehicleLocked(vehicle, true)
				
				exports.hud:sendBottomNotification(localPlayer, "Otobüs Şoförü", "Otobüs güzergahı başladı. İyi yolculuklar!")
				addEventHandler("onClientRender", root, renderBusInfo) -- Panel Çizimini Başlat
			else
				exports.hud:sendBottomNotification(localPlayer, "Otobüs Şoförü", "Güzergah başlatmak için bir Otobüs veya Koç'ta olmanız gerekiyor.")
			end
		end
	else
		exports.hud:sendBottomNotification(localPlayer, "Bildirim", "Otobüs şoförü değilsiniz. Bu işi almak için Belediye Binası'na gidin.")
	end
end
addCommandHandler("startbus", startBusJob, false, false)

function updateBusCheckpointCheck(thePlayer)
	if thePlayer == getLocalPlayer() then
		local vehicle = getPedOccupiedVehicle(thePlayer)
		if vehicle and bus[getElementModel(vehicle)] then
			if curCpType == 3 then
				busStopTimer = setTimer(updateBusCheckpointAfterStop, 5000, 1, true)
				triggerEvent("hudOverlay:drawOverlayTopRight", thePlayer, { {"Bus Driver"}, {""}, {"Wait at the bus stop for a moment until the marker disappears."}, }, false, false, false, 5)
				triggerServerEvent("busAdNextStop", getLocalPlayer(), line, route.points[m_number][5])
			elseif curCpType == 2 then
				endOfTheLine()
			elseif curCpType == 1 then
				busStopTimer = setTimer(updateBusCheckpointAfterStop, 5000, 1, false)
				triggerEvent("hudOverlay:drawOverlayTopRight", thePlayer, { {"Bus Driver"}, {""}, {"Wait at the bus stop for a moment until the marker disappears."}, }, false, false, false, 5)
				triggerServerEvent("busAdNextStop", getLocalPlayer(), line, route.points[m_number][5])
			else
				updateBusCheckpoint()
			end
		else
			exports.hud:sendBottomNotification(localPlayer, "Otobüs Şoförü", "Güzergahı sürmek için bir otobüs veya koçta olmanız gerekiyor.")
		end
	end
end

function updateBusCheckpoint()
	-- Find out which marker is next.
	local max_number = #route.points
	local newnumber = m_number+1
	local nextnumber = m_number+2
	local x, y, z = nil
	local nx, ny, nz = nil
	
	x = route.points[newnumber][1]
	y = route.points[newnumber][2]
	z = route.points[newnumber][3]
	
	if (tonumber(max_number-1) == tonumber(m_number)) then -- if the next checkpoint is the final checkpoint.
		setElementPosition(busMarker, x, y, z)
		setElementPosition(busBlip, x, y, z)
		
		if (route.points[newnumber][4]==true) then -- If it is a stop.
			curCpType = 3
			setMarkerColor(busMarker, 255, 0, 0, 150)
			setBlipColor(busBlip, 255, 0, 0, 255)
			setElementPosition(busStopColShape, x, y, z)
		else -- it is just a route.
			curCpType = 2
			setMarkerColor(busMarker, 255, 200, 0, 150)
			setBlipColor(busBlip, 255, 200, 0, 255)
		end
		
		nx, ny, nz = 1811, -1890, 13 -- Depot start point
		setElementPosition(busNextMarker, nx, ny, nz)
		setElementPosition(busNextBlip, nx, ny, nz)
		setMarkerColor(busNextMarker, 255, 0, 0, 150)
		setBlipColor(busNextBlip, 255, 0, 0, 255)
		setMarkerIcon(busNextMarker, "finish")
	else
		nx = route.points[nextnumber][1]
		ny = route.points[nextnumber][2]
		nz = route.points[nextnumber][3]
		
		setElementPosition(busMarker, x, y, z)
		setElementPosition(busBlip, x, y, z)
		
		setElementPosition(busNextMarker, nx, ny, nz)
		setElementPosition(busNextBlip, nx, ny, nz)
		
		if (route.points[newnumber][4]==true) then -- If it is a stop.
			curCpType = 1
			setMarkerColor(busMarker, 255, 0, 0, 150)
			setBlipColor(busBlip, 255, 0, 0, 255)
			setElementPosition(busStopColShape, x, y, z)
		else -- it is just a route.
			curCpType = 0
			setMarkerColor(busMarker, 255, 200, 0, 150)
			setBlipColor(busBlip, 255, 200, 0, 255)
		end
		
		if (route.points[nextnumber][4] == true) then
			setMarkerColor(busNextMarker, 255, 0, 0, 150)
			setBlipColor(busNextBlip, 255, 0, 0, 255)
		else
			setMarkerColor(busNextMarker, 255, 200, 0, 150)
			setBlipColor(busNextBlip, 255, 200, 0, 255)
		end
	end
	m_number = m_number + 1
end

function checkWaitAtStop(thePlayer)
	if thePlayer == getLocalPlayer() then
		if busStopTimer then
			exports.hud:sendBottomNotification(localPlayer, "Otobüs Şoförü", "Durakta beklemediniz.")
			if isTimer(busStopTimer) then
				killTimer(busStopTimer)
				busStopTimer = nil
			end
		end
	end
end

function updateBusCheckpointAfterStop(endOfLine)
	if isTimer(busStopTimer) then
		killTimer(busStopTimer)
		busStopTimer = nil
	end
	local stopNumber = route.points[m_number][5]
	triggerServerEvent("payBusDriver", getLocalPlayer(), line, stopNumber)
	if endOfLine then
		endOfTheLine(getLocalPlayer())
	else
		updateBusCheckpoint(getLocalPlayer())
	end
end

function endOfTheLine()
	if busNextBlip then
		destroyElement(busNextBlip)
		destroyElement(busNextMarker)
		busNextBlip = nil
		busNextMarker = nil
		
		if busStopColShape then
			destroyElement(busStopColShape)
			busStopColShape = nil
		end
		
		local x, y, z = 1811, -1890, 13 -- Depot start point
		setElementPosition(busMarker, x, y, z)
		setElementPosition(busBlip, x, y, z)
		setMarkerColor(busMarker, 255, 0, 0, 150)
		setBlipColor(busBlip, 255, 0, 0, 255)
		setMarkerIcon(busMarker, "finish")
		curCpType = 2
	else
		if busBlip then
			-- Remove the old marker.
			destroyElement(busBlip)
			destroyElement(busMarker)
			busBlip = nil
			busMarker = nil
		end
		triggerServerEvent("payBusDriver", getLocalPlayer(), line, -2)
		setVehicleLocked(vehicle, false)
		exports.hud:sendBottomNotification(localPlayer, "Otobüs Şoförü", "Hat sonu. Güzergahı yeniden başlatmak için /startbus kullanın.") --if line is finished
	end
end

function enterBus ( thePlayer, seat, jacked )
	if(thePlayer == getLocalPlayer())then
		local vehID = getElementModel (source)
		if(bus[vehID])then
			if(seat~=0)then
				local driver = getVehicleOccupant(source)
				if driver then -- sürücü varsa yolcu ücreti öder
					if not exports.global:hasMoney(getLocalPlayer(), 5)then
						triggerServerEvent("removePlayerFromBus", getLocalPlayer())
						outputChatBox("$5 otobüs ücretini karşılayamazsınız.", 255, 0, 0)
					else
						triggerServerEvent("payBusFare", getLocalPlayer(), driver)
						outputChatBox("Otobüse binmek için $5 ödendi.", 0, 255, 0)
					end
				end
			elseif not busMarker and getElementData(getLocalPlayer(), "job") == 3 then
				exports.hud:sendBottomNotification(localPlayer, "Otobüs Şoförü", "Güzergahı başlatmak için /startbus kullanın.")
			end
		end
	end
end
addEventHandler("onClientVehicleEnter", getRootElement(), enterBus)

function startEnterBus(thePlayer, seat)
	if seat == 0 and bus[getElementModel(source)] then
		if getVehicleController(source) then -- birisi şoförü carjack yapmaya çalışıyorsa durdur
			cancelEvent()
			if thePlayer == getLocalPlayer() then
				exports.hud:sendBottomNotification(localPlayer, "Bildirim", "Şoför kapısı kilitli.")
			end
		else
			setVehicleLocked(source, false)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), startEnterBus)

function onPlayerQuit()
	if getElementData(source, "job") == 3 then
		vehicle = getPedOccupiedVehicle(source)
		if vehicle and bus[getElementModel(vehicle)] and getVehicleOccupant(vehicle) == source then
			setVehicleLocked(vehicle, false)
		end
	end
end
addEventHandler("onClientPlayerQuit", getRootElement(), onPlayerQuit)