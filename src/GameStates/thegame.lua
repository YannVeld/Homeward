require("src/Instances/Item")
require("src/Instances/itemPickupManager")
require("src/Instances/conversionHandler")
require("src/Instances/infoScreenManager")
require("src/Instances/itemStorage")
require("src/Instances/sceneManager")
require("src/Scenes/scenes")

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

    local initialScene = GetInitialScene()
    sceneManager = SceneManager(initialScene, pickupManager, myGrid, itemStorage)

    --local conversion1 = GainGoldConversion()
    --local conversion2 = GainSwordConversion()
    --conversionHandler = ConversionHandler(pickupManager, myGrid, itemStorage, conversion1, conversion2)
end

function gamestates.thegame:update(dt)
    pickupManager:update(dt)
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
