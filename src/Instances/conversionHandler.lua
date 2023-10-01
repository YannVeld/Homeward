require("src.conversion")

ConversionHandler = Class{
    __includes = {Instance},

    init = function(self, pickupManager, grid, itemStorage, conversion1, conversion2)
        Instance.init(self)

        self.pickupManager = pickupManager
        self.grid = grid
        self.itemStorage = itemStorage
        self.conversion1 = conversion1
        self.conversion2 = conversion2

        self:setupButtonSounds()
        self:createOptionButtons()
    end,

    setupButtonSounds = function(self)
        --self.clickSound = love.audio.newSource("Sounds/clickButton.wav", "static")
        self.clickSound = love.audio.newSource("Sounds/blibSound.wav", "static")
        self.clickSound:setVolume(SoundsVolume)

        self.noClickSound = love.audio.newSource("Sounds/noClickButton.wav", "static")
        self.noClickSound:setVolume(SoundsVolume)
    end,

    playClickSound = function(self)
        self.clickSound:setPitch(love.math.random(0.9, 1.1))
        self.clickSound:play()
    end,

    playNoClickSound = function(self)
        self.noClickSound:setPitch(love.math.random(0.9, 1.1))
        self.noClickSound:play()
    end,

    createOptionButtons = function(self)
        --local button1pos = Vector(22, 72)
        --local button2pos = Vector(85, 72)
        local button1pos = Vector(22, 95)
        local button2pos = Vector(85, 95)


        --local buttonwidth = Sprites.OptionButton:getWidth()
        --local buttonheight = Sprites.OptionButton:getHeight()
        local buttonwidth = Sprites.ContinueButton:getWidth()
        local buttonheight = Sprites.ContinueButton:getHeight()

        local textColor = Colors.hexToRGB("#4B3D44")

        if self.conversion1 then
            OptionButton1 = Button(button1pos, buttonwidth, buttonheight)
            OptionButton1:setText(self.conversion1.description, {color=textColor, ha="center", va="top"})
            OptionButton1:setOnButtonReleased(function() self:performConversion(self.conversion1, 1) end)
            --OptionButton1:setBackgroundSprites(Sprites.OptionButton, Sprites.OptionButtonHover, Sprites.OptionButton, false)
            OptionButton1:setBackgroundSprites(Sprites.ContinueButton, Sprites.ContinueButtonHover, Sprites.ContinueButton, false)
            OptionButton1:setOnButtonHoverStart(function() self.pickupManager:setItemLock(true) end)
            OptionButton1:setOnButtonHoverEnd(function() self.pickupManager:setItemLock(false) end)
            OptionButton1:setDrawLayer(DrawLayers.Normal)
        end

        if self.conversion2 then
            OptionButton2 = Button(button2pos, buttonwidth, buttonheight)
            OptionButton2:setText(self.conversion2.description, {color=textColor, ha="center", va="top"})
            OptionButton2:setOnButtonReleased(function() self:performConversion(self.conversion2, 2) end)
            --OptionButton2:setBackgroundSprites(Sprites.OptionButton, Sprites.OptionButtonHover, Sprites.OptionButton, false)
            OptionButton2:setBackgroundSprites(Sprites.ContinueButton, Sprites.ContinueButtonHover, Sprites.ContinueButton, false)
            OptionButton2:setOnButtonHoverStart(function() self.pickupManager:setItemLock(true) end)
            OptionButton2:setOnButtonHoverEnd(function() self.pickupManager:setItemLock(false) end)
            OptionButton2:setDrawLayer(DrawLayers.Normal)
        end

        if (not self.conversion1) and (not self.conversion2) then
            self:didConversion(1)
        end
    end,

    performConversion = function(self, conversion, id)
        if not self.itemStorage:isEmpty() then
            self:playNoClickSound()
            return false
        end
        
        if #conversion.inTypes == 0 then
            if not self.pickupManager:isEmpty() then
                self:playNoClickSound()
                return false
            end

            for i, fn in ipairs(conversion.outItems) do
                local item = fn(self.itemStorage.position, self.pickupManager, self.grid, self.itemStorage)
            end
            self:didConversion(id)
            self:playClickSound()
            return true
        end
        
        if self.pickupManager:isEmpty() then
            self:playNoClickSound()
            return false
        end

        local itemInHand = self.pickupManager.pickedupItem

        if self.checkForMatchingTypes(conversion.inTypes, itemInHand.types) then
            itemInHand:destroy()
            for i, fn in ipairs(conversion.outItems) do
                local item = fn(self.itemStorage.position, self.pickupManager, self.grid, self.itemStorage)
                self.itemStorage:putInStorage(item)
            end
            self:didConversion(id)
            self:playClickSound()
            return true
        end
        self:playNoClickSound()
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