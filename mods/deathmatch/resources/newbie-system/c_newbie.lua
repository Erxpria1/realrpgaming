--[[
    Newbie Help System - Client Side
    Antigravity
]]

local screenWidth, screenHeight = guiGetScreenSize()

function showNewbieMenu()
    if newbieWindow then destroyElement(newbieWindow) end
    
    newbieWindow = guiCreateWindow((screenWidth - 300) / 2, (screenHeight - 200) / 2, 300, 200, "Yeni Oyuncu Destek Paneli", false)
    guiWindowSetSizable(newbieWindow, false)
    
    local lbl = guiCreateLabel(20, 30, 260, 40, "Hoş geldin! Aşağıdaki butonları kullanarak destek alabilirsin.", false, newbieWindow)
    guiLabelSetHorizontalAlign(lbl, "center", true)
    
    local btnKit = guiCreateButton(50, 80, 200, 35, "Başlangıç Paketini Al", false, newbieWindow)
    local btnVeh = guiCreateButton(50, 125, 200, 35, "Ücretsiz Motor Kirala", false, newbieWindow)
    local btnClose = guiCreateButton(110, 170, 80, 25, "Kapat", false, newbieWindow)
    
    addEventHandler("onClientGUIClick", btnKit, function()
        triggerServerEvent("newbie:requestKit", localPlayer)
    end, false)
    
    addEventHandler("onClientGUIClick", btnVeh, function()
        triggerServerEvent("newbie:rentVehicle", localPlayer)
    end, false)
    
    addEventHandler("onClientGUIClick", btnClose, function()
        destroyElement(newbieWindow)
        showCursor(false)
    end, false)
    
    showCursor(true)
end

-- NPC'ye sağ tıklandığında veya etkileşime girildiğinde (Basit mesafe kontrolü + Tuş şimdilik)
bindKey("f", "down", function()
    local peds = getElementsByType("ped", root, true)
    for _, ped in ipairs(peds) do
        if getElementData(ped, "name") == "Rehber Ahmet" then
            local x, y, z = getElementPosition(localPlayer)
            local px, py, pz = getElementPosition(ped)
            if getDistanceBetweenPoints3D(x, y, z, px, py, pz) < 3 then
                showNewbieMenu()
                break
            end
        end
    end
end)

outputChatBox("[Newbie] Rehber Ahmet ile konuşmak için yanına gidip 'F' tuşuna basabilirsin.", 255, 255, 255)
