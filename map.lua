local Map = {}


local json = require "json"

Map.TILESIZE = 32
Map.MAPSIZE = 32
Map.gridSize = Map.TILESIZE * Map.MAPSIZE
Map.DOOR = 37
Map.TILEVORTEX = 39
Map.imgTile = love.graphics.newImage("images/tiles.png")
Map.Grid = {}
Map.quads = {}
Map.SolidTiles = {
    17,
    18,
    19,
    20,
    34,
    37
}
Map.level = 1
Map.TotalChips = 0
Map.Collectibles = {
    21,22,23,24
}


Map.Chips = {58,59,60}
Map.Vortex = {39,40,41,42}
Map.Doors = {
    {id = 17, key = 21}, {id = 18, key = 22}, {id = 19, key = 23}, {id = 20, key = 24}
}

local vortexOffset = 0
local animTimer = 0
local animSpeed = 0.2

local openPortal = love.audio.newSource("Music/openPortal.wav", "static")


function Map.OutOfBounds(c, l)
    if c >= 1 and c <= Map.MAPSIZE and l >= 1 and l <= Map.MAPSIZE  then
        return true
    end
    return false
end

function Map.Remove(c, l)
    if c >= 1 and c <= Map.MAPSIZE and l >= 1 and l <= Map.MAPSIZE  then
        Map.Grid[l][c] = 0
    else
        print("Map.remove ERROR :  Out of Bounds")
    end
end


function Map.isSolid(c, l)
    local id = Map.Grid[l][c]
    for n = 1, #Map.SolidTiles do 
        if id == Map.SolidTiles[n] then 
            return true
        end
    end
    return false
end

function Map.isCollectible(c, l)
    local id = Map.Grid[l][c]
    for n = 1, #Map.Collectibles do 
        if id == Map.Collectibles[n] then 
            return true
        end
    end
    return false
end

function Map.isChip(c, l)
    local id = Map.Grid[l][c]
    for n = 1, #Map.Chips do 
        if id == Map.Chips[n] then 
            return true
        end
    end
    return false
end

function Map.isDoor(c, l)
    local id = Map.Grid[l][c]
    for n = 1, #Map.Doors do 
        if id == Map.Doors[n].id then 
            return true
        end
    end
    return false
end

function Map.isVortex(c, l)
    local id = Map.Grid[l][c]
    for n = 1, #Map.Vortex do 
        if id == Map.Vortex[n] then 
            return true
        end
    end
    return false
end

function Map.canOpenDoor(idDoor, idKey)
    for k,v in pairs(Map.Doors) do 
        if v.id == idDoor and v.key == idKey then 
            return true
        end
    end
    return false
end

function Map.ChangeLevel(pLevel, bSave)
    bSave = bSave or false
    if pLevel >= 1 then
        if bSave then 
            Map.Save()
        end
        Map.level = pLevel
        if bSave == false then
            Map.load()
        end
    message("LEVEL "..Map.level)
    end
end


function Map.Update(dt)
    animTimer = animTimer + dt
    if animTimer >= animSpeed then 
        vortexOffset = vortexOffset + 1
        if vortexOffset > 3 then 
            vortexOffset = 0
        end
        animTimer = 0
    end
    
end

function Map.DestroyObject(pId) 
    for l = 1, Map.MAPSIZE do 
        for c = 1, Map.MAPSIZE do 
            local id = Map.Grid[l][c]
            if id == pId then
               Map.Remove(c,l)
               openPortal:play()
            --    openPortal:stop()
            end
        end
    end
    

end

function Map.getId(c,l)
    if c >= 1 and c <= Map.MAPSIZE and l >= 1 and l <= Map.MAPSIZE  then
        return Map.Grid[l][c]
    end
    return -1
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
    Map.TotalChips = 0
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
        Map.reset()
        print('No save(s) founded')
    end

    for l = 1, Map.MAPSIZE do 
        for c = 1, Map.MAPSIZE do 
            if Map.isChip(c, l) then 
                Map.TotalChips = Map.TotalChips + 1
            end
        end
    end
end

function Map.draw()
    for l= 1, Map.MAPSIZE do 
        for c = 1, Map.MAPSIZE do 
            local x, y = Map.MapToPixel(c, l)
            love.graphics.draw(Map.imgTile, Map.quads[33] , x, y)
            local id = Map.Grid[l][c]
            if id == Map.TILEVORTEX then 
                id = id + vortexOffset
            end
            if id > 0 then 
                love.graphics.draw(Map.imgTile, Map.quads[id], x, y )
            end
            
        end
    end
end




return  Map