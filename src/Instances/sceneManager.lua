
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
        self.charsPerTypeSound = 3
        self:setupTypeSounds()
        self:resetCharsShown()

        self.continueButtonPos = Vector(79 - Sprites.ContinueButton:getWidth()/2, 95)
        self.continueButton = nil
        self:setupButtonSounds()

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

    setupButtonSounds = function(self)
        --self.clickSound = love.audio.newSource("Sounds/clickButton.wav", "static")
        self.clickSound = love.audio.newSource("Sounds/blibSound.wav", "static")
        self.clickSound:setVolume(SoundsVolume)

        self.noClickSound = love.audio.newSource("Sounds/noClickButton.wav", "static")
        self.noClickSound:setVolume(SoundsVolume)
    end,

    setupTypeSounds = function(self)
        self.typeSounds = {}
        self.typeSounds[1] = love.audio.newSource("Sounds/typesound1.wav", "static")
        self.typeSounds[2] = love.audio.newSource("Sounds/typesound2.wav", "static")
        self.typeSounds[3] = love.audio.newSource("Sounds/typesound3.wav", "static")

        for i,sound in ipairs(self.typeSounds) do
            sound:setVolume(SoundsVolume)
        end
    end,

    playTypeSound = function(self)
        if self.curCharPos > #self.storyText + #self.questionText then
            return
        end

        self.typeSound:setPitch(love.math.random(0.8, 1.2))
        self.typeSound:play()
    end,

    playClickSound = function(self)
        self.clickSound:setPitch(love.math.random(0.9, 1.1))
        self.clickSound:play()
    end,

    playNoClickSound = function(self)
        self.noClickSound:setPitch(love.math.random(0.9, 1.1))
        self.noClickSound:play()
    end,

    resetCharsShown = function(self)
        self.curCharPos = 0
        self.curQuestionCharPos = 0
        self.showAllChars = false
        self.nextCharNumForSound = 0
        self.typeSound = Lume.randomchoice(self.typeSounds)
        self.startTime = love.timer.getTime()
    end,

    incrementCharsShown = function(self)
        if self.showAllChars then
            self.curCharPos = 99999999
            self.curQuestionCharPos = 99999999
            return
        end

        self.curCharPos = math.floor( (love.timer.getTime() - self.startTime) / self.secPerChar )

        if self.curCharPos > self.nextCharNumForSound then
            self.nextCharNumForSound = self.curCharPos + self.charsPerTypeSound
            self:playTypeSound()
        end

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


        if self.curScene.entrySound then
            self.curScene.entrySound:play()
        end

        self.curScene.onEntry()
        self:resetCharsShown()
    end,

    afterConversion = function(self, id)
        local buttonwidth = Sprites.ContinueButton:getWidth()
        local buttonheight = Sprites.ContinueButton:getHeight()
        self:resetCharsShown()

        if id == 1 then
            self.storyText = self.curScene.afterstory1
            if self.curScene.sound1 then
                self.curScene.sound1:play()
            end
        else
            self.storyText = self.curScene.afterstory2
            if self.curScene.sound2 then
                self.curScene.sound2:play()
            end
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
            self:playNoClickSound()
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

        self:playClickSound()
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