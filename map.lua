local Map = {}

Map.TILESIZE = 32
Map.MAPSIZE = 32


Map.Grid = {}

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