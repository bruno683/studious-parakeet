local Scene = {}
-- require
local map = require "map"
-- local scene_manager = require "scene_manager"
local chip = {
    line = 1,
    column = 1,
}

function Scene.load()
    map.level = 1
    map.loadQuads()
    map.load()
end

function Scene.update(dt)
end


function Scene.draw()
    map.draw()
    local x = (chip.column - 1) * map.TILESIZE
    local y = (chip.line - 1 ) * map.TILESIZE
    love.graphics.draw(map.imgTile, map.quads[369], x, y)
    -- love.graphics.print("Scene gameplay")
end


function Scene.keypressed(key)
    if key == "escape" then 
        scene_manager.changeScene("menu")
    end
end

function Scene.mousepressed(x, y, button)
    
end

return Scene