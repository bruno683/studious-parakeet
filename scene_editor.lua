local Scene = {}
local map = require "map"
local current_scene = nil
-- local scene_menu = require "scene_menu"
function Scene.load()
    print("reset de la map")
    map.reset()
end


function Scene.update(dt)
end


function Scene.draw()
    -- love.graphics.print("Scene editeur")

    

    for l= 1, map.MAPSIZE do 
        for c = 1, map.MAPSIZE do 
            local x = (l-1) * map.TILESIZE
            local y = (c-1) * map.TILESIZE
            love.graphics.rectangle("line", x, y, TILESIZE, TILESIZE)
            love.graphics.print(map.Grid[l][c], x + 2, y + 2 )
        end
    end


end

function Scene.keypressed(key)
end

function Scene.mousepressed(x, y, button)
    local tileX = math.floor(x / 32) + 1
    print("colonne", tileX)
    local tileY = math.floor(y / 32) + 1
    print("ligne", tileY)
    if tileX >= 1 and tileX <= map.MAPSIZE and tileY >= 1 and tileY <= map.MAPSIZE  then
        -- affichage de la tuile de notre choix par action du click
        map.Grid[tileX][tileY] = 33
    else
        print("Erreur! click en dehors de la grille")
    end
end





return Scene