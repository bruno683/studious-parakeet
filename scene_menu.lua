local Scene = {}




-- local scene_manager = require "scene_manager"



function Scene.load()
    print("menu loaded")
end

function Scene.update(dt)

end


function Scene.draw()

  
    love.graphics.print("Menu")
    local x = 10
    local y = 20 
    love.graphics.print("[E]diteur de scene", x, y)
    y = y + 20
    love.graphics.print("[G]ameplay", x, y)
    y = y + 20
    love.graphics.print("[Q]uitter", x, y)
    

    
end
function Scene.keypressed(key)
    if current_scene ~= nil then 
        current_scene.keypressed(key)
    end
     

    if key == "e" or key == "E" then 
        scene_manager.changeScene("editor")
    elseif key == "g" or key == "G" then 
        scene_manager.changeScene("gameplay")
    elseif key == "escape" then 
        scene_manager.changeScene("menu")
    end

end

function Scene.mousepressed(x, y, button)
    
end

return Scene