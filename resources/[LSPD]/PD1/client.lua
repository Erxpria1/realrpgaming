addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('pd.txd',true)
engineImportTXD(txd, 1868)
local dff = engineLoadDFF('pd.dff', 0)
engineReplaceModel(dff, 1868)
local col = engineLoadCOL('pd.col')
engineReplaceCOL(col, 1868)
engineSetModelLODDistance(1868, 5500)
end)

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy
