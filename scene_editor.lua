local Scene = {}
local map = require "map"
local current_scene = nil
-- local scene_menu = require "scene_menu"


function Scene.update(dt)
end


function Scene.draw()
    -- love.graphics.print("Scene editeur")

    

    for l= 1, map.MAPSIZE do 
        for c = 1, map.MAPSIZE do 
            local x = (l-1) * map.TILESIZE
            local y = (c-1) * map.TILESIZE
            love.graphics.rectangle("line", x, y, TILESIZE, TILESIZE)
        end
    end


end

function Scene.keypressed(key)
end


function Scene.mousepressed(x, y, button)
    
end


return Scene