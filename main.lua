-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest", "nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end
textures = love.graphics.newImage("images/tiles.png")

local scene = require "scene_menu"



local current_scene 
TILESIZE = 32
textureWidth = textures:getWidth()
textureHeight = textures:getHeight()
local quads = {}


-- Taille de la map
MAPSIZE = 32

function creerNiveau(pNum) 
  local level = {} -- initialisation de level

  for l= 1, MAPSIZE do
      level[l] = {} -- on creer un tqblequ de ligne vide
      for c = 1, MAPSIZE do 
        level[l][c] = 33 -- on remplit les lignes et colonnes du tile n°33
      end
  end

  return level -- on retourne level avec ses valeurs associées

end


local currentLevel = nil -- le niveau courant vide pour l'instant
function love.load()
  
  largeur_ecran = love.graphics.getWidth()
  hauteur_ecran = love.graphics.getHeight()

  current_scene = scene
  -- scene:load()
  local n = 1
  local tileWidth = textureWidth / 16
  local tileHeight = textureHeight / 32
  
  for l = 1, 32 do 
    for c = 1, 16 do
        quads[n] = love.graphics.newQuad( (c-1) * tileWidth, (l-1) * tileWidth, TILESIZE, TILESIZE, textureWidth, textureHeight)
        n = n + 1
    end
  end
  currentLevel = creerNiveau(1) -- on determine le niveau courant avec la fonction CreerNiveau()


end

function love.update(dt)
  scene:update(dt)
end

function love.draw()
    
    -- love.graphics.draw(textures,quads[371], 10, 10)
    -- love.graphics.scale(0.9,0.9)
   
    current_scene:draw()
end

function love.keypressed(key)
  current_scene.keypressed(key)
  if key == "q" or key == "Q" then
    love.event.quit()
  end
  
  print(key)
  
end

function love.mousepresses(x, y, button)
  current_scene.mousepressed(x, y, button)
end
  