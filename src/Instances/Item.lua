require("src/Instances/Pickupable")

Item = Class{
    __includes = {Pickupable},

    init = function(self, position, sprite, cellsWide, cellsHigh, pickupManager, itemGrid)
        Pickupable.init(self, position, sprite:getWidth(), sprite:getHeight(), pickupManager)

        self.sprite = sprite
        self.cellsWide = cellsWide
        self.cellsHigh = cellsHigh
        self.itemGrid = itemGrid
    end,

    update = function(self, dt)
        if self:isPickedUp() then
            self:moveWithMouse()
        end

    end,

    draw = function(self)
        love.graphics.draw(self.sprite, self.position.x - self.sprite:getWidth()/2, self.position.y - self.sprite:getHeight() / 2)
    end,

    moveWithMouse = function(self)
        local mousex, mousey = Push:toGame(love.mouse.getPosition())
        local i,j = self.itemGrid:getGridIndex(mousex, mousey)
        local mouseIsOnGrid =  self.itemGrid:isGridIndex(i,j)

        if not mouseIsOnGrid then
            self.position = Vector(mousex, mousey)
            self.canBeDropped = true
            return
        end

        local gridx, gridy = self.itemGrid:getCenter(i,j)
        self.position = Vector(gridx, gridy)
        self.canBeDropped = false
    end,
}