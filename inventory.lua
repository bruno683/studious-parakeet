local Inventory = {}

-- require
local map = require "map"
-- contient {id = x, qty = x}
Inventory.lstItems = {}
Inventory.x = 0
Inventory.y = 0
local fontSize = 20
function Inventory.Clear() Inventory.lstItems = {} end

function Inventory.setPosition(pX, pY)
    Inventory.x = pX
    Inventory.y = pY
    -- cette fonction est appelé au chargement de la scene gameplay, où les coordonnées x et y sont définies
end

function Inventory.Add(pId)
    -- on verifie si l'item(id) est deja dans l'inventaire
    local bFound = false
    -- ajoute les clés dans l'inventaire
    if pId == 21 or pId == 22 or pId == 23 or pId == 24 then
        for k, v in pairs(Inventory.lstItems) do
            if v.id == pId then
                v.qty = v.qty + 1
                bFound = true
                break
            end
        end
        if not bFound then
            table.insert(Inventory.lstItems, {id = pId, qty = 1})
        end
    end
    -- ajoute les boots dans l'inventaire
    if pId == 97 or pId == 98 or pId == 99 or pId == 100 or pId == 101 then
        for k, v in pairs(Inventory.lstItems) do
            if v.id == pId then
                v.qty = v.qty + 1
                bFound = true
                break
            end
        end
        if not bFound then
            table.insert(Inventory.lstItems, {id = pId, qty = 1})
        end
    end
    -- ajoute les chips dans l'inventaire
    if pId == 58 or pId == 59 or pId == 60 then
        map.TotalChips = map.TotalChips - 1
        for k, v in pairs(Inventory.lstItems) do
            if v.id == pId then
                v.qty = v.qty + 1
                bFound = true
                break
            end
        end
        if not bFound then
            table.insert(Inventory.lstItems, {id = pId, qty = 1})
        end
    end
end

function Inventory.Remove(pId)
    -- Supprime les clés
    if pId == 21 or pId == 22 or pId == 23 or pId == 24 then
        for n = #Inventory.lstItems, 1, -1 do
            local item = Inventory.lstItems[n] -- on récupére les index de l'inventaire
            if item.id == pId then --- on Compare l'id de l'index avec l'id de l'item que l'on veut supprimer au sein de l'inventaire
                item.qty = item.qty - 1 -- Modification de la quantité associé à l'index
                if item.qty == 0 then -- si la quantité est égale à zero
                    table.remove(Inventory.lstItems, n) -- on supprime l'index [n] et ses valeurs associées
                end
            end
        end
    end
    if pId == map.SUCTIONBOOTS or pId == map.ICESKATE or pId == map.FLIPPER then
        for n = #Inventory.lstItems, 1, -1 do
            local item = Inventory.lstItems[n] -- on récupére les index de l'inventaire
            if item.id == pId then --- on Compare l'id de l'index avec l'id de l'item que l'on veut supprimer au sein de l'inventaire
                item.qty = item.qty - 1 -- Modification de la quantité associé à l'index
                if item.qty == 0 then -- si la quantité est égale à zero
                    table.remove(Inventory.lstItems, n) -- on supprime l'index [n] et ses valeurs associées
                end
            end
        end
    end
end

function Inventory.Draw()
    local x = Inventory.x
    local y = Inventory.y
    -- Affiche les clés à droite de la map
    for k, v in pairs(Inventory.lstItems) do
        love.graphics.draw(map.imgTile, map.quads[v.id], x, y)
        if v.qty > 1 then
            love.graphics.print(v.qty, x + map.TILESIZE + 5, y)
        end
        y = y + map.TILESIZE + 5
    end
end

function Inventory.Has(pID)
    for k, v in pairs(Inventory.lstItems) do
        if v.id == pID then return true end
    end
    return false
end

return Inventory
