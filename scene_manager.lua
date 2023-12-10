local Scene_manager = {}

Scene_manager.current_scene = nil 


function Scene_manager.changeScene(pScene)
    Scene_manager.current_scene = pScene
    Scene_manager.current_scene.load()
end

function Scene_manager.update(dt)
    Scene_manager.current_scene.update(dt)
end


function Scene_manager.draw()
    Scene_manager.current_scene.draw()
end


function Scene_manager.keypressed(key)
    Scene_manager.current_scene.keypressed(key)
end


function Scene_manager.mousepressed(x, y, button)
    Scene_manager.current_scene.mousepressed()
end




return Scene_manager