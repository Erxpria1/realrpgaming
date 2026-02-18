--[[
    Newbie Help System - Server Side
    Antigravity
]]

local mysql = exports.mysql

-- NPC Spawn (Belediye Binası Girişi - LS City Hall)
local guideNPC = createPed(211, 1481.3, -1747.8, 13.5)
setElementRotation(guideNPC, 0, 0, 180)
setElementInterior(guideNPC, 0)
setElementDimension(guideNPC, 0)
setElementData(guideNPC, "talk", 1)
setElementData(guideNPC, "name", "Rehber Ahmet")
setElementData(guideNPC, "rpp.npc.type", "newbie.guide")
setElementFrozen(guideNPC, true)

-- Başlangıç Paketi Paketi (Starter Kit)
function giveStarterKit(thePlayer)
    if not thePlayer or not isElement(thePlayer) then return end
    
    local hoursPlayed = getElementData(thePlayer, "hoursplayed") or 0
    if hoursPlayed > 5 then
        outputChatBox("[!] Sadece yeni oyuncular başlangıç paketi alabilir.", thePlayer, 255, 0, 0)
        return
    end

    if getElementData(thePlayer, "newbie:received_kit") then
        outputChatBox("[!] Zaten başlangıç paketi aldınız.", thePlayer, 255, 194, 14)
        return
    end

    exports.global:giveItem(thePlayer, 2, "1") -- Telefon
    exports.global:giveItem(thePlayer, 18, "1") -- Şehir Rehberi
    exports.global:giveItem(thePlayer, 111, "1") -- GPS
    
    exports.global:giveMoney(thePlayer, 1000)
    
    setElementData(thePlayer, "newbie:received_kit", true)
    outputChatBox("[#57ff57]Hoş geldin! Başlangıç paketi verildi: Telefon, GPS, Şehir Rehberi ve $1000.", thePlayer, 255, 255, 255, true)
end
addEvent("newbie:requestKit", true)
addEventHandler("newbie:requestKit", root, function()
    giveStarterKit(client)
end)

-- Araç Kiralama Sistemi
function rentNewbieVehicle(thePlayer)
    if not thePlayer or not isElement(thePlayer) then return end
    
    local hoursPlayed = getElementData(thePlayer, "hoursplayed") or 0
    if hoursPlayed > 10 then
        outputChatBox("[!] Sadece yeni oyuncular (10 saat altı) araç kiralayabilir.", thePlayer, 255, 0, 0)
        return
    end

    -- Eski aracını sil
    local oldVeh = getElementData(thePlayer, "newbie:veh")
    if isElement(oldVeh) then destroyElement(oldVeh) end

    local x, y, z = getElementPosition(thePlayer)
    local rx, ry, rz = getElementRotation(thePlayer)
    
    local veh = createVehicle(462, x, y + 2, z, 0, 0, rz) -- Faggio
    setElementData(veh, "newbie:owner", thePlayer)
    setElementData(thePlayer, "newbie:veh", veh)
    
    -- Aracın anahtarını verme (isteğe bağlı, kilit sistemi varsa)
    -- exports.global:giveItem(thePlayer, 3, getElementData(veh, "dbid")) 

    warpPedIntoVehicle(thePlayer, veh)
    outputChatBox("[#57ff57]Ücretsiz motorunuz teslim edildi! Sunucudan çıkınca silinecektir.", thePlayer, 255, 255, 255, true)
end
addEvent("newbie:rentVehicle", true)
addEventHandler("newbie:rentVehicle", root, function()
    rentNewbieVehicle(client)
end)

-- Çıkışta aracı sil
addEventHandler("onPlayerQuit", root, function()
    local veh = getElementData(source, "newbie:veh")
    if isElement(veh) then destroyElement(veh) end
end)

-- Karakter spawn olduğunda bilgilendirme
addEventHandler("account:character:spawned", root, function()
    local hoursPlayed = getElementData(source, "hoursplayed") or 0
    if hoursPlayed < 1 then
        outputChatBox("--------------------------------------------------", source, 255, 194, 14)
        outputChatBox("Şehre hoş geldin! Belediye Binası'ndaki (City Hall) rehberden", source, 255, 255, 255)
        outputChatBox("başlangıç paketini almayı unutma! İyi oyunlar.", source, 255, 255, 255)
        outputChatBox("--------------------------------------------------", source, 255, 194, 14)
    end
end)
