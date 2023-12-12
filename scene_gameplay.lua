local Scene = {}
-- require
local map = require "map"
local Chip = require "chip"
-- local scene_manager = require "scene_manager"

local bMove = false
local timeToMove = 0
local moveSpeed = 0.2


function Scene.load()
    map.level = 1
    map.loadQuads()
    map.load()
end

function Scene.update(dt)
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
        timeToMove = moveSpeed
    end
    
    
end


function Scene.draw()
    map.draw()
    x, y = map.MapToPixel(Chip.column, Chip.line)
    love.graphics.draw(map.imgTile, map.quads[369], x, y)
end


function Scene.keypressed(key)
    if key == "escape" then 
        scene_manager.changeScene("menu")
    end
end

function Scene.mousepressed(x, y, button)
    
end

return Scene