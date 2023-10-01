
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

        self.textColor = Colors.hexToRGB("#4B3D44")
        self.storyTexty = 9
        self.storyTextx_noimage = 13
        self.storyTextx_withImage = 55

        self.storyTextMaxX = 144
        self.storyText = ""

        --self.questionTextPosition = Vector(13, 55)
        self.questionTextPosition = Vector(13, 75)
        self.questionText = ""

        self.secPerChar = 0.01
        self.showAllChars = false
        self:resetCharsShown()

        self.continueButtonPos = Vector(79 - Sprites.ContinueButton:getWidth()/2, 95)
        self.continueButton = nil

        Signal.register('conversionsDone', function(id) self:afterConversion(id) end)
        self:setupScene()
    end,

    update = function(self, dt)
        self:incrementCharsShown()
        self:showFullTextOnClick()
        self:setContinueButtonText()
    end,

    draw = function(self)

        if self.curScene.image then
            love.graphics.draw(Sprites.CharacterFrameNoHeader, self.imagePosition:unpack())
            love.graphics.draw(self.curScene.image, self.imagePosition:unpack())
        end

        love.graphics.setColor(self.textColor)
        local font = love.graphics.getFont()
        local maxwidth = self.storyTextMaxX - self.storyTextPosition.x
        local texttoprint = string.sub(self.storyText,1,self.curCharPos)
        local width, wrapped = font:getWrap(texttoprint, maxwidth)
        for i,line in ipairs(wrapped) do
            love.graphics.print(line, self.storyTextPosition.x, self.storyTextPosition.y + (i-1) * font:getLineHeight() * font:getHeight())
        end

        local questiontexttoprint = string.sub(self.questionText,1,self.curQuestionCharPos)
        love.graphics.print(questiontexttoprint, self.questionTextPosition.x, self.questionTextPosition.y)
        love.graphics.setColor(Colors.white)
    end,

    resetCharsShown = function(self)
        self.curCharPos = 0
        self.curQuestionCharPos = 0
        self.showAllChars = false
        self.startTime = love.timer.getTime()
    end,

    incrementCharsShown = function(self)
        if self.showAllChars then
            self.curCharPos = 99999999
            self.curQuestionCharPos = 99999999
            return
        end

        self.curCharPos = math.floor( (love.timer.getTime() - self.startTime) / self.secPerChar )

        self.curQuestionCharPos = self.curCharPos - #self.storyText
        if self.curQuestionCharPos < 0 then
            self.curQuestionCharPos = 0
        end
    end,

    showFullTextOnClick = function(self)
        if (not love.keyboard.isDown("space")) and (not love.keyboard.isDown("return")) then
            return
        end

        self.showAllChars = true
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

        self.storyText = self.curScene.story
        self.questionText = self.curScene.question
        self.conversionHandler = ConversionHandler(self.pickupManager, self.grid, self.itemStorage, conversion1, conversion2)

        self.curScene.onEntry()
        self:resetCharsShown()
    end,

    afterConversion = function(self, id)
        local buttonwidth = Sprites.ContinueButton:getWidth()
        local buttonheight = Sprites.ContinueButton:getHeight()
        self:resetCharsShown()

        if id == 1 then
            self.storyText = self.curScene.afterstory1
        else
            self.storyText = self.curScene.afterstory2
        end

        self.questionText = ""

        self.continueButton = Button(self.continueButtonPos, buttonwidth, buttonheight)
        self.continueButton:setText("Continue", {color=self.textColor, ha="center", va="top"})
        self.continueButton:setOnButtonReleased(function() self:continueToNextScene(id) end)
        self.continueButton:setBackgroundSprites(Sprites.ContinueButton, Sprites.ContinueButtonHover, Sprites.ContinueButton, false)
        self.continueButton:setDrawLayer(DrawLayers.Normal)
    end,

    continueToNextScene = function(self, id)
        if not self.pickupManager:isEmpty() then
            return
        end
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

    setContinueButtonText = function(self)
        if not self.continueButton then 
            return
        end
       
        local str
        if self.itemStorage:isEmpty() then
            str = "Continue"
        else
            str = "Leave the\n" .. self.itemStorage.item.name
        end
        
        self.continueButton:setText(str, {color=self.textColor, ha="center", va="top"})
    end,


}