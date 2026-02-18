--[[
 * Meslek Bilgi Paneli - c_job_info.lua
 * Her meslek noktasına yaklaşıldığında bilgi kutucuğu gösterir.
 * GTA San Andreas haritasına uygun konumlar kullanılmıştır.
]]

local localPlayer = getLocalPlayer()

-- =============================================
-- MESLEK NOKTALARI VE BİLGİLERİ
-- =============================================
local jobInfoPoints = {
    -- Taksi Şoförü - Unity Station, Los Santos
    {
        x = 1787.12, y = -1903.59, z = 13.39,
        radius = 15,
        title = "Taksi Şoförü",
        lines = {
            "📍 Konum: Unity İstasyonu, Los Santos",
            "🚕 Araçlar: Taxi (438), Cabbie (420)",
            "💰 Kazanç: Yolcu başına mesafeye göre değişir",
            "ℹ️  Taksi ışığı için: /taxilight",
            "🔴 İşten ayrılmak için: /endjob",
        }
    },
    -- Otobüs Şoförü - Unity Station Depot, Los Santos
    {
        x = 1811.0, y = -1890.0, z = 13.0,
        radius = 15,
        title = "Otobüs Şoförü",
        lines = {
            "📍 Konum: Unity İstasyonu Deposu, Los Santos",
            "🚌 Araçlar: Bus (431), Coach (437)",
            "💰 Kazanç: Her durakta $50 (saatlik azalır)",
            "ℹ️  Güzergah başlatmak için: /startbus",
            "🔴 İşten ayrılmak için: /endjob",
        }
    },
    -- Teslimat / Uzun Yol Tır Şoförü - RS Haul, Flint County
    {
        x = -71.0, y = -1166.0, z = 1.0,
        radius = 20,
        title = "Uzun Yol Tır Şoförü",
        lines = {
            "📍 Konum: RS Haul Deposu, Flint County",
            "🚛 Araçlar: Linerunner (403), Tanker (514), Roadtrain (515)",
            "💰 Kazanç: Rota tamamlandığında ödeme",
            "ℹ️  Rota atlamak için: /skiproute (Admin)",
            "🔴 İşten ayrılmak için: /endjob",
        }
    },
    -- Tamirci - Doherty Garajı, San Fierro
    {
        x = -1931.0, y = 247.0, z = 35.0,
        radius = 15,
        title = "Tamirci",
        lines = {
            "📍 Konum: Doherty Garajı, San Fierro",
            "🔧 Hizmetler: Tamir, Lastik, Boya, Far, Upgrade",
            "💰 Hızlı Tamir: $110 | Lastik: $10 | Boya: $100",
            "ℹ️  Araçlara sağ tıklayarak hizmet verin",
            "🔴 İşten ayrılmak için: /endjob",
        }
    },
    -- Balıkçı - Palomino Creek İskelesi
    {
        x = 133.87, y = -1793.34, z = 2.21,
        radius = 12,
        title = "Balıkçı",
        lines = {
            "📍 Konum: Palomino Creek İskelesi, Los Santos",
            "🎣 Gereksinim: Olta çubuğu (envanterde olmalı)",
            "💰 Kazanç: Balık satışından elde edilir",
            "ℹ️  Balık tutmak için: /fish | Durdurmak: /stopfishing",
            "ℹ️  Balıkçı John ile konuşarak balıklarınızı satın",
        }
    },
    -- Çilingir - City Hall yakını, Los Santos
    {
        x = 1481.0, y = -1771.0, z = 18.79,
        radius = 12,
        title = "Çilingir",
        lines = {
            "📍 Konum: Belediye Binası Yakını, Los Santos",
            "🔑 Hizmet: Anahtar kopyalama",
            "💰 Kazanç: Kopyalanan anahtar başına ücret",
            "ℹ️  Kopyalamak için: /copykey [tür][ID]",
            "🔴 İşten ayrılmak için: /endjob",
        }
    },
    -- Şehir Bakım Görevlisi - City Hall, Los Santos
    {
        x = 1481.0, y = -1771.0, z = 18.79,
        radius = 12,
        title = "Şehir Bakım Görevlisi",
        lines = {
            "📍 Konum: Belediye Binası, Los Santos",
            "🧹 Araç: Sweeper (574)",
            "💰 Kazanç: Grafiti temizleme başına ödeme",
            "ℹ️  Sprey ile grafitileri boyayın",
            "🔴 İşten ayrılmak için: /endjob",
        }
    },
}

-- =============================================
-- BİLGİ KUTUCUĞU SİSTEMİ
-- =============================================
local activeInfoPoints = {}
local shownPoints = {}

local function showJobInfoPanel(pointData)
    local job = getElementData(localPlayer, "job") or 0
    -- Bilgiyi her zaman göster (iş sahibi olsun ya da olmasın)
    exports.hud:sendBottomNotification(localPlayer, "📋 " .. pointData.title, table.concat(pointData.lines, "  |  "))
end

local function createJobInfoColSpheres()
    for i, point in ipairs(jobInfoPoints) do
        local col = createColSphere(point.x, point.y, point.z, point.radius)
        activeInfoPoints[i] = { col = col, data = point, shown = false }

        addEventHandler("onClientColShapeHit", col, function(hitElement, matchingDimension)
            if hitElement == localPlayer and matchingDimension then
                if not activeInfoPoints[i].shown then
                    activeInfoPoints[i].shown = true
                    showJobInfoPanel(point)
                    -- 10 saniye sonra tekrar gösterilebilir
                    setTimer(function()
                        if activeInfoPoints[i] then
                            activeInfoPoints[i].shown = false
                        end
                    end, 10000, 1)
                end
            end
        end)
    end
end

-- Kaynak başladığında colsphere'leri oluştur
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
    createJobInfoColSpheres()
end)

-- Karakter giriş yaptığında da çalıştır
addEventHandler("onClientPlayerSpawn", localPlayer, function()
    setTimer(createJobInfoColSpheres, 2000, 1)
end)
