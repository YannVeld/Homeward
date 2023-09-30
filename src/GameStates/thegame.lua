require("src/Instances/Item")
require("src/Instances/itemPickupManager")
require("src/Instances/conversionHandler")
require("src/Instances/infoScreenManager")
require("src/Instances/itemStorage")

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
    infoScreenManager = InfoScreenManager(pickupManager)
    itemStorage = ItemStorage()
    conversionHandler = ConversionHandler(pickupManager, myGrid, itemStorage, 1)

    anItem = NewSwordItem(Vector(64, 16), pickupManager, myGrid, itemStorage)
    --anItem2 = NewGoldItem(Vector(96, 16), pickupManager, myGrid, itemStorage)
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
