
SceneManager = Class{
    __includes = {Instance},

    init = function(self, initialScene, pickupManager, grid, itemStorage)
        Instance.init(self)

        self.curScene = initialScene
        self.pickupManager = pickupManager
        self.grid = grid
        self.itemStorage = itemStorage

        --self.imagePosition = Vector(10,10)
        self.imagePosition = Vector(12,8)

        self.storyTexty = 9
        self.storyTextx_noimage = 13
        self.storyTextx_withImage = 55

        self.storyTextMaxX = 144
        self.storyText = ""

        self.questionTextPosition = Vector(13, 55)
        self.questionText = ""

        self.continueButtonPos = Vector(79 - Sprites.ContinueButton:getWidth()/2, 95)
        self.continueButton = nil

        Signal.register('conversionsDone', function(id) self:afterConversion(id) end)
        self:setupScene()
    end,

    draw = function(self)

        if self.curScene.image then
            love.graphics.draw(Sprites.CharacterFrameNoHeader, self.imagePosition:unpack())
            love.graphics.draw(self.curScene.image, self.imagePosition:unpack())
        end

        local textColor = Colors.hexToRGB("#4B3D44")

        love.graphics.setColor(textColor)

        local font = love.graphics.getFont()
        local maxwidth = self.storyTextMaxX - self.storyTextPosition.x 
        local width, wrapped = font:getWrap(self.storyText, maxwidth)
        for i,line in ipairs(wrapped) do
            love.graphics.print(line, self.storyTextPosition.x, self.storyTextPosition.y + (i-1) * font:getLineHeight() * font:getHeight())
        end

        love.graphics.print(self.questionText, self.questionTextPosition.x, self.questionTextPosition.y)
        love.graphics.setColor(Colors.white)
    end,

    setupScene = function(self)
        self.storyTextPosition = Vector(self.storyTextx_noimage, self.storyTexty)

        if not self.curScene then
            self.storyText = "No scene to show"
            self.questionText = ""
            return
        end

        if self.curScene.image then
            self.storyTextPosition.x = self.storyTextx_withImage
        end

        local conversion1 = self.curScene.conversion1
        if conversion1 and (not conversion1.condition()) then
            conversion1 = nil
        end

        local conversion2 = self.curScene.conversion2
        if conversion2 and (not conversion2.condition()) then
            conversion2 = nil
        end

        self.conversionHandler = ConversionHandler(self.pickupManager, self.grid, self.itemStorage, conversion1, conversion2)
        self.storyText = self.curScene.story
        self.questionText = self.curScene.question
    end,

    afterConversion = function(self, id)
        local buttonwidth = Sprites.ContinueButton:getWidth()
        local buttonheight = Sprites.ContinueButton:getHeight()

        if id == 1 then
            self.storyText = self.curScene.afterstory1
        else
            self.storyText = self.curScene.afterstory2
        end
        self.questionText = ""

        self.continueButton = Button(self.continueButtonPos, buttonwidth, buttonheight)
        self.continueButton:setText("Continue", {color=textColor, ha="center", va="top"})
        self.continueButton:setOnButtonReleased(function() self:continueToNextScene(id) end)
        self.continueButton:setBackgroundSprites(Sprites.ContinueButton, Sprites.ContinueButtonHover, Sprites.ContinueButton, false)
        self.continueButton:setDrawLayer(DrawLayers.Normal)
    end,

    continueToNextScene = function(self, id)
        if self.itemStorage.item then
            self.itemStorage.item:destroy()
        end

        if id == 1 then
            self.curScene = self.curScene.getNextScene1()
        else
            self.curScene = self.curScene.getNextScene2()
        end
       
        self.continueButton:destroy()
        self.continueButton = nil

        self:setupScene()
    end,

    playerHasType = function(self, itemType)
        for i=1, self.grid.cellsWide do
            for j=1, self.grid.cellsHigh do
                local obj = self.grid:getContent(i,j)
                if obj then
                    local hasType = Lume.find(obj.types, itemType)
                    if hasType then
                        return true
                    end
                end
            end
        end
        return false
    end,
}