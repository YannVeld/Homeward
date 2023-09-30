
SceneManager = Class{
    __includes = {Instance},

    init = function(self, initialScene, pickupManager, grid, itemStorage)
        Instance.init(self)

        self.curScene = initialScene
        self.pickupManager = pickupManager
        self.grid = grid
        self.itemStorage = itemStorage

        self.storyTextPosition = Vector(55, 14)
        self.storyText = love.graphics.newText(love.graphics:getFont(), "")

        self.questionTextPosition = Vector(15, 55)
        self.questionText = love.graphics.newText(love.graphics:getFont(), "")

        self.continueButtonPos = Vector(79 - Sprites.ContinueButton:getWidth()/2, 95)
        self.continueButton = nil

        Signal.register('conversionsDone', function(id) self:afterConversion(id) end)
        self:setupScene()
    end,

    draw = function(self)
        local textColor = Colors.hexToRGB("#4B3D44")

        love.graphics.setColor(textColor)
        love.graphics.draw(self.storyText, self.storyTextPosition.x, self.storyTextPosition.y)
        love.graphics.draw(self.questionText, self.questionTextPosition.x, self.questionTextPosition.y)
        love.graphics.setColor(Colors.white)
    end,

    setupScene = function(self)
        if not self.curScene then
            self.storyText:set("No scene to show")
            self.questionText:set("")
            return
        end

        local conversion1 = self.curScene.conversion1
        local conversion2 = self.curScene.conversion2
        self.conversionHandler = ConversionHandler(self.pickupManager, self.grid, self.itemStorage, conversion1, conversion2)
        self.storyText:set(self.curScene.story)
        self.questionText:set(self.curScene.question)
    end,

    afterConversion = function(self, id)
        local buttonwidth = Sprites.ContinueButton:getWidth()
        local buttonheight = Sprites.ContinueButton:getHeight()

        self.storyText:set(self.curScene.afterstory)
        self.questionText:set("")

        self.continueButton = Button(self.continueButtonPos, buttonwidth, buttonheight)
        self.continueButton:setText("Continue", {color=textColor, ha="center", va="center"})
        self.continueButton:setOnButtonReleased(function() self:continueToNextScene() end)
        self.continueButton:setBackgroundSprites(Sprites.ContinueButton, Sprites.ContinueButtonHover, Sprites.ContinueButton, false)
        self.continueButton:setDrawLayer(DrawLayers.Normal)
    end,

    continueToNextScene = function(self)
        if self.itemStorage.item then
            self.itemStorage.item:destroy()
        end

        if id == 1 then
            self.curScene = self.curScene.followupScene1
        else
            self.curScene = self.curScene.followupScene2
        end
       
        self.continueButton:destroy()
        self.continueButton = nil

        self:setupScene()
    end,
}