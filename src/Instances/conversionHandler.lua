require("src/conversion")

ConversionHandler = Class{
    __includes = {Instance},

    init = function(self, pickupManager, grid, itemStorage, conversion1, conversion2)
        Instance.init(self)

        self.pickupManager = pickupManager
        self.grid = grid
        self.itemStorage = itemStorage
        self.conversion1 = conversion1
        self.conversion2 = conversion2

        self:createOptionButtons()
    end,

    createOptionButtons = function(self)
        local button1pos = Vector(22, 72)
        local button2pos = Vector(85, 72)

        local buttonwidth = Sprites.OptionButton:getWidth()
        local buttonheight = Sprites.OptionButton:getHeight()

        local textColor = Colors.hexToRGB("#4B3D44")

        if self.conversion1 then
            OptionButton1 = Button(button1pos, buttonwidth, buttonheight)
            OptionButton1:setText(self.conversion1.description, {color=textColor, ha="center", va="top"})
            OptionButton1:setOnButtonReleased(function() self:performConversion(self.conversion1) end)
            OptionButton1:setBackgroundSprites(Sprites.OptionButton, Sprites.OptionButtonHover, Sprites.OptionButton, false)
            OptionButton1:setOnButtonHoverStart(function() self.pickupManager:setItemLock(true) end)
            OptionButton1:setOnButtonHoverEnd(function() self.pickupManager:setItemLock(false) end)
            OptionButton1:setDrawLayer(DrawLayers.Normal)
        end

        if self.conversion2 then
            OptionButton2 = Button(button2pos, buttonwidth, buttonheight)
            OptionButton2:setText(self.conversion2.description, {color=textColor, ha="center", va="top"})
            OptionButton2:setOnButtonReleased(function() self:performConversion(self.conversion2) end)
            OptionButton2:setBackgroundSprites(Sprites.OptionButton, Sprites.OptionButtonHover, Sprites.OptionButton, false)
            OptionButton2:setOnButtonHoverStart(function() self.pickupManager:setItemLock(true) end)
            OptionButton2:setOnButtonHoverEnd(function() self.pickupManager:setItemLock(false) end)
            OptionButton2:setDrawLayer(DrawLayers.Normal)
        end
    end,

    performConversion = function(self, conversion)
        if not self.itemStorage:isEmpty() then
            return false
        end
        
        if #conversion.inTypes == 0 then
            if not self.pickupManager:isEmpty() then
                return false
            end

            for i, fn in ipairs(conversion.outItems) do
                local item = fn(self.itemStorage.position, self.pickupManager, self.grid, self.itemStorage)
            end
            self:didConversion(1)
            return true
        end
        
        if self.pickupManager:isEmpty() then
            return false
        end

        local itemInHand = self.pickupManager.pickedupItem

        if self.checkForMatchingTypes(conversion.inTypes, itemInHand.types) then
            for i, fn in ipairs(conversion.outItems) do
                itemInHand:destroy()
                local item = fn(self.itemStorage.position, self.pickupManager, self.grid, self.itemStorage)
                self.itemStorage:putInStorage(item)
            end
            self:didConversion(2)
            return true
        end
        return false
    end,

    checkForMatchingTypes = function(typeLst1, typeLst2)
        for i, type1 in ipairs(typeLst1) do
            if Lume.find(typeLst2, type1) then
                return true
            end
        end
        return false
    end,

    didConversion = function(self, convid)
        self.pickupManager:setItemLock(false)
        if OptionButton1 then OptionButton1:destroy() end
        if OptionButton2 then OptionButton2:destroy() end
        Signal.emit("conversionsDone", convid)
        self:destroy()
    end,
}