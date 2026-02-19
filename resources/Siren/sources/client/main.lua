-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://www.youtube.com/@TurkishSparroW/

-- Discord : https://discord.gg/DzgEcvy

local font = dxCreateFont("files/fonts/medium.ttf", 10)
local font2 = dxCreateFont("files/fonts/medium.ttf", 8)

function dx()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not isElement(vehicle) then
        closeMenu()
        return
    end
    dxDrawImage(495, 682, 376, 73, "files/imgs/base.png")
    dxDrawImage(775, 692, 10, 10, "files/imgs/ellipse.png", 0, 0, 0, math.random(1, 10) == 1 and tocolor(173, 146, 255) or tocolor(255, 255, 255, 3))
    dxDrawImage(790, 692, 10, 10, "files/imgs/ellipse.png", 0, 0, 0, math.random(1, 10) == 2 and tocolor(173, 146, 255) or tocolor(255, 255, 255, 3))
    dxDrawImage(805, 692, 10, 10, "files/imgs/ellipse.png", 0, 0, 0, math.random(1, 10) == 1 and tocolor(173, 146, 255) or tocolor(255, 255, 255, 3))
    dxDrawImage(820, 692, 10, 10, "files/imgs/ellipse.png", 0, 0, 0, math.random(1, 10) == 2 and tocolor(173, 146, 255) or tocolor(255, 255, 255, 3))
    dxDrawImage(835, 692, 10, 10, "files/imgs/ellipse.png", 0, 0, 0, math.random(1, 10) == 1 and tocolor(173, 146, 255) or tocolor(255, 255, 255, 3))
    dxDrawImage(850, 692, 10, 10, "files/imgs/ellipse.png", 0, 0, 0, math.random(1, 10) == 2 and tocolor(173, 146, 255) or tocolor(255, 255, 255, 3))
    dxDrawText("Siren Paneli", 521, 692, 71, 13, tocolor(255, 255, 255, 35), 1.00, font, "left", "center", false, false, false, false, false)
    if isMouseInPosition(533, 711, 95, 37) then
        dxDrawImage(533, 711, 95, 37, "files/imgs/button.png", 0, 0, 0, tocolor(173, 146, 255))
        dxDrawImage(541, 721, 19, 19, "files/imgs/cage.png", 0, 0, 0, tocolor(17, 17, 17))
        dxDrawText("1", 541, 721, 19, 19, tocolor(173, 146, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Siren Işığı", 567, 711, 57, 37, tocolor(17, 17, 17), 1.00, font, "left", "center", false, false, false, false, false)
    else
        dxDrawImage(533, 711, 95, 37, "files/imgs/button.png", 0, 0, 0, tocolor(255, 255, 255, 1))
        dxDrawImage(541, 721, 19, 19, "files/imgs/cage.png", 0, 0, 0, tocolor(173, 146, 255))
        dxDrawText("1", 541, 721, 19, 19, tocolor(39, 30, 66), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Siren Işığı", 567, 711, 57, 37, tocolor(255, 255, 255, 35), 1.00, font, "left", "center", false, false, false, false, false)
    end
    if isMouseInPosition(636, 711, 95, 37) then
        dxDrawImage(636, 711, 95, 37, "files/imgs/button.png", 0, 0, 0, tocolor(173, 146, 255))
        dxDrawImage(644, 721, 19, 19, "files/imgs/cage.png", 0, 0, 0, tocolor(17, 17, 17))
        dxDrawText("2", 644, 721, 19, 19, tocolor(173, 146, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Siren Sesi", 670, 711, 57, 37, tocolor(17, 17, 17), 1.00, font, "left", "center", false, false, false, false, false)
    else
        dxDrawImage(636, 711, 95, 37, "files/imgs/button.png", 0, 0, 0, tocolor(255, 255, 255, 1))
        dxDrawImage(644, 721, 19, 19, "files/imgs/cage.png", 0, 0, 0, tocolor(173, 146, 255))
        dxDrawText("2", 644, 721, 19, 19, tocolor(39, 30, 66), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Siren Sesi", 670, 711, 57, 37, tocolor(255, 255, 255, 35), 1.00, font, "left", "center", false, false, false, false, false)
    end
    if isMouseInPosition(739, 711, 95, 37) then
        dxDrawImage(739, 711, 95, 37, "files/imgs/button.png", 0, 0, 0, tocolor(173, 146, 255))
        dxDrawImage(747, 721, 19, 19, "files/imgs/cage.png", 0, 0, 0, tocolor(17, 17, 17))
        dxDrawText("3", 747, 721, 19, 19, tocolor(173, 146, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Dat Dat Korna", 773, 711, 57, 37, tocolor(17, 17, 17), 1.00, font, "left", "center", false, false, false, false, false)
    else
        dxDrawImage(739, 711, 95, 37, "files/imgs/button.png", 0, 0, 0, tocolor(255, 255, 255, 1))
        dxDrawImage(747, 721, 19, 19, "files/imgs/cage.png", 0, 0, 0, tocolor(173, 146, 255))
        dxDrawText("3", 747, 721, 19, 19, tocolor(39, 30, 66), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Dat Dat Korna", 773, 711, 57, 37, tocolor(255, 255, 255, 35), 1.00, font, "left", "center", false, false, false, false, false)
    end
end

bindKey("k", "down",
function()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not vehicle then return end
    if (config["VTR's Allowed"][(getElementModel(vehicle))]) then
        if not isEventHandlerAdded("onClientRender", root, dx) then
            addEventHandler("onClientRender", root, dx)
        else
            closeMenu()
        end
    end
end)

addEventHandler("onClientClick", root,
function(_, state)
    if state == "up" then
        if isEventHandlerAdded("onClientRender", root, dx) then
        end
    end
end)

dataVtr = {}

addEventHandler("onClientKey", root,
function(button, press)
    if isEventHandlerAdded("onClientRender", root, dx) then
        if button == "1" and press then
            local vehicle = getPedOccupiedVehicle(localPlayer)
            if not (dataVtr[vehicle]) then
                dataVtr[vehicle] = { }
            end
            local giroflexState = (getElementData(vehicle, 'JOAO.gyroFlex') or false)
            if giroflexState then
                notifyC("Sirenleri kapattın!", "info")
            else
                notifyC("Sirenleri açtın!", "info")
            end
            setElementData(vehicle, 'JOAO.gyroFlex', not giroflexState)
            triggerServerEvent('JOAO.gyroFlex', localPlayer)
        elseif button == "2" and press then
            local vehicle = getPedOccupiedVehicle(localPlayer)
            if (getElementData(vehicle, 'JOAO.sirenActive') or false) then
                if (getElementData(vehicle, 'JOAO.sirenActive') == 2) then
                    triggerServerEvent('JOAO.stopSirenRoot', localPlayer)
                else
                    triggerServerEvent('JOAO.startSirenRoot', localPlayer, 2)
                end
            else
                triggerServerEvent('JOAO.startSirenRoot', localPlayer, 2)
            end
        elseif button == "3" and press then
            local vehicle = getPedOccupiedVehicle(localPlayer)
            if (getElementData(vehicle, 'JOAO.sirenActive') or false) then
                if (getElementData(vehicle, 'JOAO.sirenActive') == 3) then
                    triggerServerEvent('JOAO.stopSirenRoot', localPlayer)
                else
                    triggerServerEvent('JOAO.startSirenRoot', localPlayer, 3)
                    setTimer(function()
                    	triggerServerEvent('JOAO.stopSirenRoot', localPlayer)
                    end, 1000, 1)
                end
            else
                triggerServerEvent('JOAO.startSirenRoot', localPlayer, 3)
                setTimer(function()
                	triggerServerEvent('JOAO.stopSirenRoot', localPlayer)
                end, 1000, 1)
            end
        end
    end
end)

Sound = {}

function startSiren(veh,idveh,tipo)
    iprint(veh, idveh, tipo)
    if veh and idveh and tipo then
        local distancia = config["VTR's Allowed"][idveh]['Distância']
        local volume = config["VTR's Allowed"][idveh]['Volume']
        if (Sound[veh] and isElement(Sound[veh])) then
            stopSound(Sound[veh])
            Sound[veh] = nil
            setElementData(veh, 'JOA.sirenActive', false)
        end
        Sound[veh] = playSound3D(config.Sirene[tipo][1], Vector3(getElementPosition(veh)), true)
        attachElements(Sound[veh], veh, 0,0,0)
        setSoundMinDistance(Sound[veh], distancia)
        setSoundVolume(Sound[veh], volume)
        setElementData(veh, 'JOAO.sirenActive', tipo)
    end
end
addEvent('JOAO.startSiren',true)
addEventHandler('JOAO.startSiren', root, startSiren)

addEvent("JOAO.changeVolumeSiren", true)
addEventHandler("JOAO.changeVolumeSiren", root,
function(veh, state)
    if isElement(Sound[veh]) then
        local idveh = getElementModel(veh)
        local volume = config["VTR's Allowed"][idveh]['Volume']
        if state then
            setSoundVolume(Sound[veh], volume)
        else
            setSoundVolume(Sound[veh], 0)
        end
    end
end)

function stopSiren(veh)
    if (Sound[veh] and isElement(Sound[veh])) then
        stopSound(Sound[veh])
        Sound[veh] = nil
        setElementData(veh, 'JOAO.sirenActive', false)
    end
end
addEvent('JOAO.stopSiren', true)
addEventHandler('JOAO.stopSiren', getRootElement(), stopSiren)

addEventHandler('onClientElementDestroy', getRootElement(), function ()
	if (Sound[source] and isElement(Sound[source])) then
        stopSound(Sound[source])
        Sound[source] = nil
    end
end)

function closeMenu()
    if isEventHandlerAdded("onClientRender", root, dx) then
        removeEventHandler("onClientRender", root, dx)
    end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == "string" and isElement( pElementAttachedTo ) and type( func ) == "function" then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == "table" and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://www.youtube.com/@TurkishSparroW/

-- Discord : https://discord.gg/DzgEcvy