local Scene = {}

-- require
local map = require "map"
local tileSelector = require "tile_selector"


local blink = 0
local blinkMessage = " "

function Scene.load()
    map.reset()
    map.loadQuads()
    map.load() -- la sauvegarde de la dernière map est 
                -- chargé au lancement de l'éditeur de niveau
    message("LEVEL "..map.level)
    local TsX = map.gridSize + 5
    local y = 5
    tileSelector.setPosition(TsX, y)
    print("Scene editor loaded")
end

function TilePicker(x, y)
    local col, line = map.PixelToMap(x, y)
    
    if map.OutOfBounds(col, line) then
        local id = map.Grid[line][col] 
        print("id :", id)
        if id > 0 then
            tileSelector.SetTile(id)
        end
    end
    
end

function changeTile(x, y, tile)
    local col, line = map.PixelToMap(x, y)
    
    if map.OutOfBounds(col, line)  then
        -- affichage de la tuile de notre choix par action du click
        map.Grid[line][col] = tile
    end
end

function Scene.update(dt)
    if blink > 0 then 
        blink = blink - dt
    end
    local leftB = love.mouse.isDown(1)
    local rightB = love.mouse.isDown(2) 
    local x, y = love.mouse.getPosition()
    if leftB then  
        changeTile(x,y, tileSelector.tile)
    elseif rightB then 
        changeTile(x, y, 0)
    end
    tileSelector.update(dt)
end

function message(pMessage)
    blinkMessage = pMessage
    blink = 2
end


function Scene.draw()
    map.draw()
    
    if blink > 0 then 
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("fill", 0,0,250, 20)
        love.graphics.setColor(0,0,0)
        love.graphics.print(blinkMessage)
        love.graphics.setColor(1,1,1,1)
    end
    tileSelector.draw()
end

function Scene.keypressed(key)
    if key == "escape" then 
        scene_manager.changeScene("menu")
    end
    if key == "s" then 
        map.Save()
        message("SAUVEGARDE EFFECTUEE")
        blink = 2
    end
    if key == "kp+" then
        map.ChangeLevel(map.level + 1)
    elseif key == "kp-" and map.level > 1 then
       map.ChangeLevel(map.level - 1)
    end
end

function Scene.mousepressed(x, y, button)
    if button == 1 then 
        print("Click")
        tileSelector.Click(x, y)
    end
    if button == 3 then 
        TilePicker(x, y)
        print("middle click")
    end
end





return Scene