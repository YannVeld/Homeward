
SceneManager = Class{
    __includes = {Instance},

    init = function(self, initialScene, pickupManager, grid, itemStorage)
        Instance.init(self)

        self.curScene = initialScene

        self.pickupManager = pickupManager
        self.grid = grid
        self.itemStorage = itemStorage

        Signal.register('conversionsDone', function(id) self:afterConversion(id) end)
        self:setupScene()
    end,

    setupScene = function(self)
        if not self.curScene then
            print("No scene to show")
            return
        end

        local conversion1 = self.curScene.conversion1
        local conversion2 = self.curScene.conversion2
        self.conversionHandler = ConversionHandler(self.pickupManager, self.grid, self.itemStorage, conversion1, conversion2)
    end,

    afterConversion = function(self, id)
        if id == 1 then
            self.curScene = self.curScene.followupScene1
        else
            self.curScene = self.curScene.followupScene2
        end
        self:setupScene()
    end,
}