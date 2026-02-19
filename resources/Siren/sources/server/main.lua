-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://www.youtube.com/@TurkishSparroW/

-- Discord : https://discord.gg/DzgEcvy

addEventHandler("onResourceStart", resourceRoot,
function()
    if config["Mensagem Start"] then
        outputDebugString("["..getResourceName(getThisResource()).."] Script aktif edildi!")
    end
    for i, v in ipairs(getElementsByType("vehicle")) do
        if (getElementData(v, "JOAO.gyroFlex") or false) then
            setElementData(v, "JOAO.gyroFlex", false)
        end
        if (getElementData(v, "JOAO.sirenActive") or false) then
            setElementData(v, "JOAO.sirenActive", false)
        end
    end
end)

addEventHandler("onVehicleExit", root,
function(player)
    if (getElementData(source, "JOAO.sirenActive") or false) then
        triggerClientEvent(root, "JOAO.changeVolumeSiren", root, source, false)
    end
end)

addEventHandler("onVehicleEnter", root,
function(player)
    if (getElementData(source, "JOAO.sirenActive") or false) then
        triggerClientEvent(root, "JOAO.changeVolumeSiren", root, source, true)
    end
end)

function startSiren(tipo)
    local veh = getPedOccupiedVehicle(source)
    if (veh) then
        local idveh = getElementModel(veh)
        local tipo = tonumber(tipo)
        if (config["VTR's Allowed"][idveh]) then
            triggerClientEvent(root, "JOAO.startSiren", root, veh, idveh, tipo)
        end
    end
end
addEvent("JOAO.startSirenRoot", true)
addEventHandler("JOAO.startSirenRoot", root, startSiren)

function stopSiren()
    local veh = getPedOccupiedVehicle(source)
    if (veh) then
        triggerClientEvent(root, "JOAO.stopSiren", root, veh)
    end
end
addEvent("JOAO.stopSirenRoot", true)
addEventHandler("JOAO.stopSirenRoot", root, stopSiren)



-- Giroflex Gringo
function requestEmergency(value)
	triggerClientEvent(root, "setEmerlights", root, getPlayerName(source), value)
end
addEvent("JOAO.gyroFlex", true)
addEventHandler("JOAO.gyroFlex", root, requestEmergency)

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://www.youtube.com/@TurkishSparroW/

-- Discord : https://discord.gg/DzgEcvy