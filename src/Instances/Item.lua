require("src/Instances/Pickupable")

Item = Class{
    __includes = {Pickupable},

    init = function(self, position, sprite, cellsWide, cellsHigh, pickupManager)
        Pickupable.init(self, position, sprite:getWidth(), sprite:getHeight(), pickupManager)

        self.sprite = sprite
        self.cellsWide = cellsWide
        self.cellsHigh = cellsHigh
    end,

    update = function(self, dt)
        if self:isPickedUp() then
            local mousex, mousey = Push:toGame(love.mouse.getPosition())
            self.position = Vector(mousex, mousey)
        end
    end,

    draw = function(self)
        love.graphics.draw(self.sprite, self.position.x - self.sprite:getWidth()/2, self.position.y - self.sprite:getHeight() / 2)
    end,
}