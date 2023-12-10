local Scene = {}
local map = require "map"
local current_scene = nil

function Scene.load()
    print("reset de la map")
    map.reset()
    map.loadQuads()
end


function changeTile(x, y, tile)
    local tileX = math.floor(x / map.TILESIZE) + 1
    print("colonne", tileX)
    local tileY = math.floor(y / map.TILESIZE) + 1
    print("ligne", tileY)
    if tileX >= 1 and tileX <= map.MAPSIZE and tileY >= 1 and tileY <= map.MAPSIZE  then
        -- affichage de la tuile de notre choix par action du click
        map.Grid[tileX][tileY] = tile
    else
        print("Erreur! click en dehors de la grille")
    end
end

function Scene.update(dt)
    local leftB = love.mouse.isDown(1)
    local rightB = love.mouse.isDown(2) 
    local x, y = love.mouse.getPosition()
    if leftB then  
        changeTile(x,y,33)
    elseif rightB then 
        changeTile(x, y, 0)
    end
end


function Scene.draw()

    for l= 1, map.MAPSIZE do 
        for c = 1, map.MAPSIZE do 
            local x = (l-1) * map.TILESIZE
            local y = (c-1) * map.TILESIZE
            love.graphics.rectangle("line", x, y, map.TILESIZE, map.TILESIZE)
            local id = map.Grid[l][c]
            if id > 0 then 
                love.graphics.draw(map.imgTile, map.quads[id], x, y )
            end

        end
    end
end

function Scene.keypressed(key)
end

function Scene.mousepressed(x, y, button)
end





return Scene