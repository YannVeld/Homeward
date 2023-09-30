require("src/Instances/Item")
require("src/Instances/itemPickupManager")

require("src/items")

gamestates.thegame = {}

function gamestates.thegame:enter()
    InstanceManager.removeAll()

    local pos = Vector(166,19)
    local width = 4
    local height = 4
    local cellWidth = 16
    local cellHeight = 16
    myGrid = Grid(pos, width, height, cellWidth, cellHeight)
    
    pickupManager = ItemPickupManager()

    anItem = NewSwordItem(Vector(16, 16), pickupManager, myGrid)
    anItem2 = NewKnifeItem(Vector(16, 64), pickupManager, myGrid)
end

function gamestates.thegame:update(dt)

end

function gamestates.thegame:keyreleased(key, code)
    if key == 'escape' then
        love.event.quit()
    end

    --if key == 'space' then
    --    myGrid:clearAll()
    --end
end

function gamestates.thegame:draw()
    --myGrid:draw()
end
