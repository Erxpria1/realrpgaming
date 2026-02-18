--[[
* ***********************************************************************************************************************
* SERVER AUTO-STRENGTHEN SCRIPT (Gemini CLI)
* Bu script sunucuyu canlandırmak için gerekli olan her şeyi otomatik yapar.
* ***********************************************************************************************************************
]]

function runAutoSetup()
    local conn = getConn("mta")
    if not conn then 
        outputDebugString("[AUTO-SETUP] Veritabanı bağlantısı henüz hazır değil, 5 saniye sonra tekrar denenecek...")
        setTimer(runAutoSetup, 5000, 1)
        return 
    end

    outputDebugString("[AUTO-SETUP] Sunucu güçlendirme işlemi başlatılıyor...")

    -- 1. SENİ ADMİN YAPALIM
    dbExec(conn, "UPDATE account_details SET adminreports_saved = 100, adminreports = 100, appstate = 3 WHERE account_id = (SELECT account FROM characters WHERE charactername = 'erxpria1' LIMIT 1)")
    dbExec(conn, "UPDATE accounts SET admin = 10 WHERE username = (SELECT account FROM characters WHERE charactername = 'erxpria1' LIMIT 1)")

    -- 2. ARAÇLAR (Eğer veritabanı boşsa ekle)
    local checkVeh = dbQuery(conn, "SELECT id FROM vehicles LIMIT 1")
    local vehResult = dbPoll(checkVeh, -1)
    if #vehResult == 0 then
        outputDebugString("[AUTO-SETUP] Araçlar ekleniyor...")
        local startVehicles = {
            {560, 1544.7, -1672.4, 13.5, 90, "1", "1"}, -- Sultan @ Otopark
            {541, 1544.7, -1668.4, 13.5, 90, "6", "6"}, -- Bullet @ Otopark
            {411, 1544.7, -1664.4, 13.5, 90, "0", "0"}, -- Infernus @ Otopark
            {415, 1178.5, -1323.5, 13.8, 270, "7", "7"}, -- Cheetah @ Market
            {487, 1178.5, -1318.5, 13.8, 270, "0", "0"}, -- Maverick @ Market (Helikopter)
            {522, 1178.5, -1313.5, 13.8, 270, "3", "3"}, -- NRG-500 @ Market
            {596, 1535.5, -1672.4, 13.5, 270, "0", "0"}, -- LS Police @ LSPD
            {411, 1535.5, -1668.4, 13.5, 270, "0", "0"}, -- Infernus @ LSPD
        }
        for _, v in ipairs(startVehicles) do
            dbExec(conn, "INSERT INTO `vehicles` (`model`, `x`, `y`, `z`, `rotx`, `roty`, `rotz`, `currx`, `curry`, `currz`, `fuel`, `hp`, `color1`, `color2`, `owner`, `faction`, `registered`) VALUES (?, ?, ?, ?, 0, 0, ?, ?, ?, ?, 100, 1000, ?, ?, -1, -1, 1)", v[1], v[2], v[3], v[4], v[5], v[2], v[3], v[4], v[6], v[7])
        end
    end

    -- 3. İÇ MEKANLAR (Eğer veritabanı boşsa ekle)
    local checkInt = dbQuery(conn, "SELECT id FROM interiors LIMIT 1")
    local intResult = dbPoll(checkInt, -1)
    if #intResult == 0 then
        outputDebugString("[AUTO-SETUP] İç mekanlar ekleniyor...")
        local startInteriors = {
            {1171.5, -1413.5, 13.5, 0, "Baslangic Evi", 1, 223.2, 1287.08, 10.82, 0}, -- Ev
            {1481.5, -1739.5, 13.5, 1, "Belediye Binasi", 2, 384.8, 173.7, 1008.3, 3}, -- City Hall
            {1172.1, -1323.5, 13.8, 1, "Market", 3, 6.1, -28.9, 1003.5, 10}, -- 24/7
            {1368.5, -1279.5, 13.5, 1, "Hastane", 4, 1141.2, -1313.1, 13.9, 0}, -- Hospital
            {1535.5, -1675.5, 13.5, 2, "LSPD (Polis)", 6, 246.85, 62.49, 1003.64, 0}, -- Police Station
            {1178.5, -1323.5, 13.8, 1, "Banka", 10, 2019.02, 1017.93, 996.87, 29}, -- Bank
            {772.43, -5.19, 1000.72, 0, "Spor Salonu", 5, 772.43, -5.19, 1000.72, 3}, -- Gym
            {-204.31, -44.08, 1002.27, 0, "Dövme Salonu", 3, -204.31, -44.08, 1002.27, 15}, -- Tattoo
            {501.84, -67.84, 998.75, 1, "Bar", 11, 501.84, -67.84, 998.75, 2}, -- Ten Green Bottles
            {1412.14, -2.28, 1000.92, 1, "Silah Magazasi", 4, 316.37, -170.02, 999.59, 20}, -- Ammunation
            {415.5, -1800.5, 13.5, 1, "Itfaiye Istasyonu", 10, -204.23, -8.88, 1002.27, 16}, -- Fire Department
            {2130.5, -1160.5, 23.5, 1, "Eczane", 17, -25.91, -188.05, 1003.54, 18}, -- Pharmacy
        }
        for _, i in ipairs(startInteriors) do
            dbExec(conn, "INSERT INTO `interiors` (`x`, `y`, `z`, `type`, `owner`, `locked`, `cost`, `name`, `interior`, `interiorx`, `interiory`, `interiorz`, `dimensionwithin`, `interiorwithin`) VALUES (?, ?, ?, ?, -1, 0, 0, ?, ?, ?, ?, ?, 0, ?)", i[1], i[2], i[3], i[4], i[5], i[6], i[7], i[8], i[9], i[10])
        end
    end

    -- 4. MARKET NPC'LERİ (Eğer shops boşsa ekle)
    local checkShop = dbQuery(conn, "SELECT id FROM shops LIMIT 1")
    local shopResult = dbPoll(checkShop, -1)
    if #shopResult == 0 then
        outputDebugString("[AUTO-SETUP] Market NPC'leri ekleniyor...")
        -- Shop tipleri: 1=Genel, 2=Silah, 3=Giyim, 4=Yiyecek
        local startShops = {
            {"Market_NPC1", 1172.1, -1325.5, 13.8, 1, 10, 0, 1}, -- 24/7 Market
            {"Market_NPC2", 1481.5, -1741.5, 13.5, 1, 3, 180, 1}, -- City Hall Market
            {"Market_NPC3", 1544.7, -1676.4, 13.5, 1, 3, 270, 1}, -- Otopark Market
            {"Market_NPC4", 2130.5, -1158.5, 23.5, 1, 18, 90, 1}, -- Market near Eczane
            {"Market_NPC5", 772.5, -7.19, 1000.72, 1, 3, 180, 1}, -- Gym Market
        }
        for _, s in ipairs(startShops) do
            dbExec(conn, "INSERT INTO `shops` (`pedName`, `x`, `y`, `z`, `dimension`, `interior`, `shoptype`, `rotationz`, `skin`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", s[1], s[2], s[3], s[4], s[5], s[6], s[7], s[8], s[9])
        end
    end

    outputDebugString("[AUTO-SETUP] Tamamlandı! erxpria1 artık Admin ve dünya hazır.")
end
setTimer(runAutoSetup, 2000, 1) -- Sunucu açıldıktan 2 saniye sonra çalıştır
