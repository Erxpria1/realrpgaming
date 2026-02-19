addEventHandler('onClientResourceStart', resourceRoot,
function()
local txd = engineLoadTXD('intpd.txd',true)
engineImportTXD(txd, 1869)
local dff = engineLoadDFF('intpd.dff', 0)
engineReplaceModel(dff, 1869)
local col = engineLoadCOL('intpd.col')
engineReplaceCOL(col, 1869)
engineSetModelLODDistance(1869, 5500) 
end)

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy
