local Map = {}

Map.TILESIZE = 32
Map.MAPSIZE = 32

Map.imgTile = love.graphics.newImage("images/tiles.png")
Map.Grid = {}
Map.quads = {}


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






function Map.reset()
    Map.Grid = {}

    for l = 1, Map.MAPSIZE do 
        Map.Grid[l] = {}
        for c = 1, Map.MAPSIZE do 
            Map.Grid[l][c] = 0
        end
    end

end




return  Map