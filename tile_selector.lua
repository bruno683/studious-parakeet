local TileSelector = {}
local Map = require "map"

TileSelector.x = 0
TileSelector.y = 0
TileSelector.marginY = 16

TileSelector.tiles = {
    17,18,19,20,21,22,23,24,34,58,59,60,305,306,307,308,321,322,323,324,
}

TileSelector.tile = TileSelector.tiles[1]

function TileSelector.setPosition(pX, pY)
    TileSelector.x = pX
    TileSelector.y = pY
    
end

function TileSelector.Click(pX, pY)
   if pX < TileSelector.x then 
    return
   end

   local x = pX - TileSelector.x
   local y = pY - TileSelector.marginY

   local tileX = math.floor(x / Map.TILESIZE) + 1
   print("Colonne ", tileX)
   local tileY = math.floor(y / Map.TILESIZE) + 1
   print("Ligne ", tileY)

end

function TileSelector.update(dt)
end



function TileSelector.draw()
    local x = TileSelector.x
    local y = TileSelector.y
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle("fill", x - 3, y, love.graphics.getWidth() - Map.gridSize, love.graphics.getHeight() - 10 / 2 )
    love.graphics.setColor(1,1,1,1)
    love.graphics.print("Tile Selector", TileSelector.x, TileSelector.y)

    y = y + TileSelector.marginY
    for q = 1, #TileSelector.tiles do
        local id  = TileSelector.tiles[q] 
        love.graphics.draw(Map.imgTile, Map.quads[id], x, y)
        x = x + Map.TILESIZE + 1
        if x > love.graphics.getWidth() - Map.TILESIZE then
            x = TileSelector.x + 5
            y = y + Map.TILESIZE + 5
        end

    end

end




function TileSelector.mousepressed(x, y, button)
    
end



return TileSelector