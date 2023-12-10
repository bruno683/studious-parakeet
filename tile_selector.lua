local Tile_selector = {}


Tile_selector.x = 0
Tile_selector.y = 0


function Tile_selector.setPosition(pX, pY)
    Tile_selector.x = pX
    Tile_selector.y = pY
end

function Tile_selector.update(dt)
end



function Tile_selector.draw()
    love.graphics.print("Tile Selector", Tile_selector.x, Tile_selector.y)
end


return Tile_selector