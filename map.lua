local Map = {}


local json = require "json"
Map.TILESIZE = 32
Map.MAPSIZE = 32
Map.gridSize = Map.TILESIZE * Map.MAPSIZE

Map.imgTile = love.graphics.newImage("images/tiles.png")
Map.Grid = {}
Map.quads = {}

Map.level = 1


function Map.OutOfBounds(c, l)
    if c >= 1 and c <= Map.MAPSIZE and l >= 1 and l <= Map.MAPSIZE  then
        return true
    end
    return false
end
function Map.loadQuads()
    
    nbTileWidth = Map.imgTile:getWidth() / 32
    print(nbTileWidth)
    nbTileHeight = Map.imgTile:getHeight() /32
    print(nbTileHeight)

    local n = 1
    for l = 1, nbTileHeight do 
        for c = 1, nbTileWidth do
            Map.quads[n] = love.graphics.newQuad((c-1) * Map.TILESIZE, (l-1) * Map.TILESIZE, Map.TILESIZE, Map.TILESIZE, Map.imgTile:getWidth(), Map.imgTile:getHeight())
            n = n + 1
        end
    end
end


function Map.PixelToMap(x, y)
    local col = math.floor(x / Map.TILESIZE) + 1
    local line = math.floor(y / Map.TILESIZE) + 1
    return col, line
end

function Map.MapToPixel(c, l)
    local x = (l-1) * Map.TILESIZE
    local y = (c-1) * Map.TILESIZE
    return x, y
end



function Map.reset()
    Map.Grid = {}
    for l = 1, Map.MAPSIZE do 
        Map.Grid[l] = {}
        for c = 1, Map.MAPSIZE do 
            Map.Grid[l][c] = 0
        end
    end
end

function Map.Save()
    local toSave = {}
    toSave.grid = Map.Grid
    local  formatJson = json.encode(toSave)
    local fileName = "ChipLevel_"..Map.level..".json"
    local file = love.filesystem.newFile(fileName)
    file:open("w")
    file:write(formatJson)
    file:close()

end

function Map.load()
    local fileName = "ChipLevel_"..Map.level..".json"
    if love.filesystem.getInfo(fileName) ~= nil then
        local file = love.filesystem.newFile(fileName)
        file:open("r")
        local formatJson = file:read()
        local formatLua = json.decode(formatJson)
        Map.Grid = formatLua.grid
    end

end



return  Map