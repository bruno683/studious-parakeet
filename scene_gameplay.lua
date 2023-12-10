local Scene = {}
-- require

-- local scene_manager = require "scene_manager"


function Scene.load()
end

function Scene.update(dt)
end


function Scene.draw()
    love.graphics.print("Scene gameplay")
end


function Scene.keypressed(key)
    if key == "escape" then 
        scene_manager.changeScene("menu")
    end
end

function Scene.mousepressed(x, y, button)
    
end

return Scene