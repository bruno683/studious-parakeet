io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest", "nearest")
-- load image file
textures = love.graphics.newImage("images/tiles.png")

-- requires
local scene = require "scene_menu"
local scene_manager = require "scene_manager"
local tileSelector = require "tile_selector"
 
function love.load()

  scene_manager.changeScene(scene)
  scene_manager.current_scene:load()

end

function love.update(dt)

  scene_manager.current_scene:update(dt)

end

function love.draw()

    scene_manager.current_scene:draw()

end

function love.keypressed(key)

  scene_manager.current_scene.keypressed(key)
  if key == "q" or key == "Q" then
      love.event.quit()
  end

end

function love.mousepressed(x, y, button)
  
  scene_manager.current_scene.mousepressed(x, y, button)
end

  