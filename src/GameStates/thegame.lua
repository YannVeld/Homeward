require("src.Instances.Item")
require("src.Instances.ItemPickupManager")
require("src.Instances.conversionHandler")
require("src.Instances.infoScreenManager")
require("src.Instances.ItemStorage")
require("src.Instances.sceneManager")
require("src.Scenes")

require("src.items")

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
    infoScreenManager = InfoScreenManager(pickupManager, myGrid)
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

GetAllItemsInBag = function()
    local objs = {}

    for i=1, myGrid.cellsWide do
        for j=1, myGrid.cellsHigh do
            local obj = myGrid:getContent(i,j)
            if obj then
                if not Lume.find(objs, obj) then
                    table.insert(objs, obj)
                end
            end
        end
    end
    return objs
end

GetTotalBagValue = function()
    local totalValue = 0

    local countedObjs = {}

    for i=1, myGrid.cellsWide do
        for j=1, myGrid.cellsHigh do
            local obj = myGrid:getContent(i,j)
            if obj then
                if not Lume.find(countedObjs, obj) then
                    totalValue = totalValue + obj.value
                    table.insert(countedObjs, obj)
                end
            end
        end
    end
    return totalValue
end

BagHasType = function(itemType)
    for i=1, myGrid.cellsWide do
        for j=1, myGrid.cellsHigh do
            local obj = myGrid:getContent(i,j)
            if obj then
                local hasType = Lume.find(obj.types, itemType)
                if hasType then
                    return true
                end
            end
        end
    end
    return false
end

ClearTheBag = function()
    for i=1, myGrid.cellsWide do
        for j=1, myGrid.cellsHigh do
            local obj = myGrid:getContent(i,j)
            if obj then
                obj:destroy()
            end
        end
    end
end

BagHasItems = function()
    return myGrid:hasItems()
end