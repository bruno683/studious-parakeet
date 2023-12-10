io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest", "nearest")
-- load image file
textures = love.graphics.newImage("images/tiles.png")

-- requires

scene_manager = require "scene_manager"


function love.load()

  scene_manager.changeScene(scene)
  scene_manager.current_scene.load()

end

function love.update(dt)

  scene_manager.update(dt)

end

function love.draw()

    scene_manager.draw()

end

function love.keypressed(key)

  scene_manager.keypressed(key)
  if key == "q" or key == "Q" then
      love.event.quit()
  end

end

function love.mousepressed(x, y, button)

  scene_manager.mousepressed(x, y, button)
  
end

  