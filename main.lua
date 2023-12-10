-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest", "nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end
textures = love.graphics.newImage("images/tiles.png")

-- requires
local scene = require "scene_menu"
local scene_manager = require "scene_manager"
 






function love.load()
  scene_manager.changeScene(scene)
  scene_manager.current_scene.load()
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
    
  print(key)
  
  end

function love.mousepressed(x, y, button)
  scene_manager.current_scene.mousepressed(x, y, button)
end

  