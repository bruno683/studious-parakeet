local Map = {}


local json = require "json"
Map.TILESIZE = 32
Map.MAPSIZE = 32
Map.gridSize = Map.TILESIZE * Map.MAPSIZE

Map.imgTile = love.graphics.newImage("images/tiles.png")
Map.Grid = {}
Map.quads = {}
Map.SolidTiles = {
    17,
    18,
    19,
    20,
    34
}
Map.level = 1


function Map.OutOfBounds(c, l)
    if c >= 1 and c <= Map.MAPSIZE and l >= 1 and l <= Map.MAPSIZE  then
        return true
    end
    return false
end

function Map.isSolid(c, l)
    local id = Map.Grid[l][c]
    for n = 1, #Map.SolidTiles do 
        if id == Map.SolidTiles[n] then 
            return true
        end
    end
    -- return false
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
    local x = (c-1) * Map.TILESIZE
    local y = (l-1) * Map.TILESIZE
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
    local toSave = {} -- toutes les données que l'on veut sauvegarder
    toSave.grid = Map.Grid
    local formatJson = json.encode(toSave)
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
        local formatJson = file:read() -- on ouvre en lecture le fichier json
        local formatLua = json.decode(formatJson) -- on decode du json le fichier
        Map.Grid = formatLua.grid -- on extrait les données
    else 
        print('No save(s) founded')
    end

end

function Map.draw()
    for l= 1, Map.MAPSIZE do 
        for c = 1, Map.MAPSIZE do 
            local x, y = Map.MapToPixel(c, l)
            love.graphics.draw(Map.imgTile, Map.quads[33] , x, y)
            local id = Map.Grid[l][c]
            if id > 0 then 
                love.graphics.draw(Map.imgTile, Map.quads[id], x, y )
            end
        end
    end
end




return  Map