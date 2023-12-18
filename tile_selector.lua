local TileSelector = {}
local Map = require "map"

TileSelector.x = 0
TileSelector.y = 0
TileSelector.marginY = 16
local blinkTimer = 0
local blinkDuration = 0.2
local blinkFlag = false

TileSelector.index = 1
Map.tile = Map.tiles[TileSelector.index]
TileSelector.Columns = 7

function TileSelector.setPosition(pX, pY)
    TileSelector.x = pX
    TileSelector.y = pY
    
end

function TileSelector.SetTile(tileId)
    for n = 1, #Map.tiles do 
        if Map.tiles[n] == tileId then
            Map.tile = tileId
            Map.index = n
        end
    end
end

function TileSelector.Click(pX, pY)
   if pX < TileSelector.x  then 
    return
   end

   local x = pX - TileSelector.x
   local y = pY - TileSelector.marginY

   local Column = math.floor(x / Map.TILESIZE) + 1
   
   local Ligne = math.floor(y / Map.TILESIZE) + 1
   

   local n =  ((Ligne - 1) * TileSelector.Columns) + Column
   if n <= #Map.tiles then 
    Map.index = n
    Map.tile = Map.tiles[n]
   end
end

function TileSelector.update(dt)
    blinkTimer = blinkTimer + dt
    if blinkTimer > blinkDuration then 
        blinkTimer = 0
        blinkFlag = not blinkFlag
    end
end




function TileSelector.draw()
    local x = TileSelector.x
    local y = TileSelector.y
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle("fill", x - 3, y, love.graphics.getWidth() - Map.gridSize, love.graphics.getHeight() - 10 / 2 )
    love.graphics.setColor(1,1,1,1)
    love.graphics.print("Tile Selector", TileSelector.x, TileSelector.y)

    local col = 1
    y = y + TileSelector.marginY
    

    for q = 1, #Map.tiles do
        local id  = Map.tiles[q] 
        love.graphics.setColor(1, 1, 1, 1)
        if q == Map.index then
            if blinkFlag == true then
                love.graphics.setColor(1, 0.5, 0.5, 0.8)
            end
        end
        love.graphics.draw(Map.imgTile, Map.quads[id], x, y)
        col = col + 1
        x = x + Map.TILESIZE + 1
        if col > TileSelector.Columns then
            x = TileSelector.x + 5
            y = y + Map.TILESIZE + 5
            col = 1
        end
    end
    love.graphics.setColor(1, 1, 1, 1)


end




function TileSelector.mousepressed(x, y, button)
    
end



return TileSelector