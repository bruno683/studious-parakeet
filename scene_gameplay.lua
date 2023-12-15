local Scene = {}
-- require
local map = require "map"
local Chip = require "chip"
local Inventory = require "inventory"
-- local scene_manager = require "scene_manager"

local bMove = false
local timeToMove = 0
local moveSpeed = 0.1
local chipsLeft = 0

function Start()
    Chip.column = 1
    Chip.line = 1
    Inventory.Clear()
    chipsLeft = map.TotalChips
end

function Scene.load()
    map.level = 1
    map.loadQuads()
    map.load()
    chipsLeft = map.TotalChips
    Start()
    local InX = map.gridSize + 5
    local y = 5
    Inventory.setPosition(InX, y)
end

function Scene.update(dt)
    map.Update(dt)
    fps = math.floor(1 / dt)
    local old_column, old_line = Chip.column, Chip.line
    -- Le booléen est vrai lorsqu'un bouton est enfoncé
    bMove = love.keyboard.isDown("right") or love.keyboard.isDown("down") or love.keyboard.isDown("left") or love.keyboard.isDown("up")

    -- Si un boutton est enfoncé et le timer est supérieur à 0 alors le timer décrémente pour stopper le mouvement
    if bMove and timeToMove > 0 then
        timeToMove = timeToMove - dt
    end

    -- quand le timer est à 0 ou moins alors les mouvements sont possibles
    if timeToMove <= 0 then 
        if love.keyboard.isDown("right") and Chip.column < map.MAPSIZE  then 
            Chip.column = Chip.column + 1
        elseif love.keyboard.isDown("down") and Chip.line < map.MAPSIZE then 
            Chip.line = Chip.line + 1
        elseif love.keyboard.isDown("left") and Chip.column > 1 then 
            Chip.column = Chip.column - 1
        elseif love.keyboard.isDown("up") and Chip.line > 1 then 
            Chip.line = Chip.line - 1
        end
        if map.isCollectible(Chip.column, Chip.line) then
            collect(Chip.column, Chip.line)
        end
        if map.isChip(Chip.column, Chip.line) then
            collect(Chip.column, Chip.line)
        end
        if map.isDoor(Chip.column,Chip.line) then
             for k, v in pairs(Inventory.lstItems.keys) do
                local idDoor = map.getId(Chip.column, Chip.line)
                if map.canOpenDoor(idDoor, v.id) then
                    map.Remove(Chip.column,Chip.line)
                    Inventory.Remove(v.id)
                end 
             end
        end
        if map.isVortex(Chip.column, Chip.line) then
            map.ChangeLevel(map.level + 1)
            Start()
        end
        if map.isSolid(Chip.column, Chip.line) then
            Chip.column = old_column
            Chip.line = old_line
        end
        timeToMove = moveSpeed
    end
    chipsLeft = map.TotalChips
    if chipsLeft < 1 then
        map.DestroyObject(map.DOOR)
    end
end


function Scene.draw()
    map.draw()
    Inventory.Draw()
    x, y = map.MapToPixel(Chip.column, Chip.line)
    love.graphics.draw(map.imgTile, map.quads[369], x, y)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

    love.graphics.print("CHIPS LEFT : "..chipsLeft, map.gridSize + 5, love.graphics.getHeight() - 40 )
end


function Scene.keypressed(key)
    if key == "escape" then 
        scene_manager.changeScene("menu")
    end
end

function Scene.mousepressed(x, y, button)
    
end

function collect(c, l)
    local id = map.getId(c, l)
    Inventory.Add(id)
    map.Remove(c,l)
end

return Scene