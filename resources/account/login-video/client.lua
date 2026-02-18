local screenWidth, screenHeight = guiGetScreenSize()
local browser = nil

addEventHandler("onClientResourceStart", resourceRoot, function()
    -- MTA'nın giriş ekranını gizleyelim (bazı sunucularda gerekebilir)
    showChat(false)
    showCursor(false)
    
    -- Tarayıcıyı oluştur
    browser = createBrowser(screenWidth, screenHeight, true, false)
    
    if browser then
        addEventHandler("onClientBrowserCreated", browser, function()
            -- HTML dosyasını yükle
            loadBrowserURL(source, "http://mta/" .. getResourceName(getThisResource()) .. "/html/index.html")
            
            -- Ses seviyesini ayarla (isteğe bağlı)
            setBrowserVolume(source, 0.5)
        end)
    end
end)

-- Sunucudan gelen dosya indirme yüzdesini takip et
addEventHandler("onClientTransferBoxProgressChange", root, function(downloaded, total)
    if browser then
        local percent = (downloaded / total) * 100
        -- JS'deki setProgress fonksiyonunu çağır
        executeBrowserJavascript(browser, string.format("setProgress(%f)", percent))
    end
end)

-- Belirli bir süre sonra veya veri yüklendiğinde kapatma fonksiyonu
function hideLoadingScreen()
    if browser then
        destroyElement(browser)
        -- showChat(true) -- Login panel will handle chat
        showCursor(false)
        browser = nil
        -- Eventi kaldıralım
        removeEventHandler("onClientTransferBoxProgressChange", root)
    end
end
addEvent("login-video:hide", true)
addEventHandler("login-video:hide", root, hideLoadingScreen)

-- Harita ve kaynaklar tamamen indiğinde (Yedek olarak kalsın ama süreyi uzatalım)
addEventHandler("onClientResourceStart", root, function()
    if isTransferBoxActive() == false then
        -- setTimer(hideLoadingScreen, 10000, 1) -- 10 saniye sonra yedek kapanış
    end
end)

