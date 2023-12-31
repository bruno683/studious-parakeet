local Scene = {}
-- require
local map = require "map"
local Chip = require "chip"
local Inventory = require "inventory"
-- local scene_manager = require "scene_manager"

local bMove = false
local timeToMove = 0
local moveSpeed = 0.1
local chipsLeft = 0
-- Musiques et sons
local music = love.audio.newSource("Music/Theme.ogg", "stream")
local changeLevel = love.audio.newSource("Music/changeLevel.wav", "static")
local collectChip = love.audio.newSource("Music/collectChip.wav", "static")
local collectkey = love.audio.newSource("Music/collectkey.wav", "static")
local openDoor = love.audio.newSource("Music/openDoor.wav", "static")
local openPortal = love.audio.newSource("Music/openPortal.wav", "static")

-- set looping on main theme
music:setLooping(true)
local play = false

-- le joueur n'est pas mort
local isDead = false

function Start()
    map.reset()
    map.loadQuads()
    map.load()
    isDead = false
    Chip.column = 1
    Chip.line = 1
    Chip.direction = " "
    Inventory.Clear()
end

function Scene.load()
    map.level = 1
    
    Start()
    local InX = map.gridSize + 5
    local y = 5
    Inventory.setPosition(InX, y)
    music:play()
    music:setVolume(0.05)
end
function removeChips(c, l, pId)

    if pId == 58 or pId == 59 or pId == 60 then map.Remove(c, l) end

end

function Scene.update(dt)
    map.Update(dt)
    fps = math.floor(1 / dt)

    local old_column, old_line = Chip.column, Chip.line
    bMove = false
    local moveDirection = " "
    if map.GetFlagByPos(Chip.column, Chip.line, map.flags.ice) then
        if Inventory.Has(map.ICESKATE) == false then
            bMove = true
            moveDirection = Chip.direction
        end
    end
    if map.GetFlagByPos(Chip.column, Chip.line, map.flags.water) then
        if Inventory.Has(map.FLIPPER) then
            isDead = false
        else
            isDead = true
        end
    end

    if map.GetFlagByPos(Chip.column, Chip.line, map.flags.thief) then
        Thief(map.SUCTIONBOOTS)
        Thief(map.ICESKATE)
        Thief(map.FLIPPER)
    end

    if map.isConveyorBelt(Chip.column, Chip.line) then
        for k, v in pairs(map.ConveyorBelt) do
            local idConveyor = map.getId(Chip.column, Chip.line)
            if map.ChangeDirection(idConveyor, v.direction) and
                Inventory.Has(map.SUCTIONBOOTS) == false then
                bMove = true
                moveDirection = v.direction
            end
        end
    end
    -- On teste le clavier afin de definir la direction
    if moveDirection == " " and isDead == false then
        if love.keyboard.isDown("right") then
            moveDirection = "right"
            bMove = true
        elseif love.keyboard.isDown("down") then
            moveDirection = "down"
            bMove = true
        elseif love.keyboard.isDown("left") then
            moveDirection = "left"
            bMove = true
        elseif love.keyboard.isDown("up") then
            moveDirection = "up"
            bMove = true
        end
    end
    -- Si un boutton est enfoncé et le timer est supérieur à 0 alors le timer décrémente pour stopper le mouvement
    if bMove and timeToMove > 0 then timeToMove = timeToMove - dt end

    -- quand le timer est à 0 ou moins alors les mouvements sont possibles
    if timeToMove <= 0 then
        if moveDirection == "right" and Chip.column < map.MAPSIZE then
            Chip.column = Chip.column + 1
            Chip.direction = "right"
        elseif moveDirection == "down" and Chip.line < map.MAPSIZE then
            Chip.line = Chip.line + 1
            Chip.direction = "down"
        elseif moveDirection == "left" and Chip.column > 1 then
            Chip.column = Chip.column - 1
            Chip.direction = "left"
        elseif moveDirection == "up" and Chip.line > 1 then
            Chip.direction = "up"
            Chip.line = Chip.line - 1
        end

        if map.GetFlagByPos(Chip.column, Chip.line, map.flags.collectible) then
            collect(Chip.column, Chip.line)
            collectkey:stop()
            collectkey:play()
        end

        if map.GetFlagByPos(Chip.column, Chip.line, map.flags.chip) then
            collect(Chip.column, Chip.line)
            collectChip:stop()
            collectChip:play()
        end

        if map.isDoor(Chip.column, Chip.line) then
            for k, v in pairs(Inventory.lstItems) do
                local idDoor = map.getId(Chip.column, Chip.line)
                if map.canOpenDoor(idDoor, v.id) then
                    openDoor:stop()
                    openDoor:play()
                    map.Remove(Chip.column, Chip.line)
                    Inventory.Remove(v.id)
                end
            end
        end

        if map.GetFlagByPos(Chip.column, Chip.line, map.flags.vortex) then
            map.ChangeLevel(map.level + 1, false)
            changeLevel:play()
            Start()
        end

        if map.GetFlagByPos(Chip.column, Chip.line, map.flags.solid) then
            Chip.column = old_column
            Chip.line = old_line
        end
        timeToMove = moveSpeed
    end
    chipsLeft = map.TotalChips
    if chipsLeft < 1 then map.DestroyObject(map.DOOR) end
end

function Scene.draw()
    map.draw()
    Inventory.Draw()
    if isDead == false then
        x, y = map.MapToPixel(Chip.column, Chip.line)
        love.graphics.draw(map.imgTile, map.quads[369], x, y)
    else
        love.graphics.draw(map.imgTile, map.quads[397], x, y)
    end
    love.graphics
        .print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)

    love.graphics.print("CHIPS LEFT : " .. chipsLeft, map.gridSize + 5,
                        love.graphics.getHeight() - 40)
end

function Scene.keypressed(key)
    if key == "escape" then scene_manager.changeScene("menu") 
        music:stop()
    elseif key == "r" then 
        Start()
    end
end

function Scene.mousepressed(x, y, button) end

function collect(c, l)
    local id = map.getId(c, l)
    Inventory.Add(id)
    map.Remove(c, l)
end

function Thief(pItem) 
    if Inventory.Has(pItem) then
        Inventory.Remove(pItem)
    end 
end


return Scene
