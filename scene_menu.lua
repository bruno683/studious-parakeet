local Scene = {}


local current_scene = nil
local scene_editor = require "scene_editor"
local scene_gameplay = require "scene_gameplay"

function Scene.update(dt)
    if current_scene ~= nil then 
        current_scene.update(dt)
    end
end


function Scene.draw()

    if current_scene ~= nil then 
        current_scene.draw()
    else
        love.graphics.print("Menu")
        local x = 10
        local y = 20 
        love.graphics.print("[E]diteur de scene", x, y)
        y = y + 20
        love.graphics.print("[G]ameplay", x, y)
        y = y + 20
        love.graphics.print("[Q]uitter", x, y)
    end

    
end
function Scene.keypressed(key)
    if current_scene ~= nil then 
        current_scene.keypressed(key)
    end
     

    if key == "e" or key == "E" then 
        current_scene = scene_editor 
    elseif key == "g" or key == "G" then 
        current_scene = scene_gameplay 
    elseif key == "escape" then 
        current_scene = nil
    end

end

function Scene.mousepressed(x, y, button)
    
end

return Scene