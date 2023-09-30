
Item = Class{
    __includes = {Instance},

    init = function(self, position, sprite, cellsWide, cellsHig, pickupManager)
        Instance.init(self)

        self.position = position
        self.sprite = sprite
        self.cellsWide = cellsWide
        self.cellsHigh = cellsHigh
        self.pickupManager = pickupManager
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

    posIsOnItem = function(self, x, y)
        --local mousex, mousey = Push:toGame(love.mouse.getPosition())

        local leftedge = self.position.x - self.sprite:getWidth()/2
        local topedge = self.position.y - self.sprite:getHeight() / 2
        local rightedge = leftedge + self.sprite:getWidth()
        local bottomedge = topedge + self.sprite:getHeight()

        if x < leftedge or x > rightedge then
            return false
        end
        if y < topedge or y > bottomedge then
            return false
        end
        return true
    end,

    mousereleased = function(self, x, y, button, istouch, presses)
        local mousex, mousey = Push:toGame(x, y)

        if not self:posIsOnItem(mousex, mousey) then
            return
        end

        if button == 1 then
            self:pickupOrDropMe()
        end

    end,

    pickupOrDropMe = function(self)
        if pickupManager:isHolding(self) then
            pickupManager:dropItem()
            return
        end

        pickupManager:pickupItem(self)
    end,

    isPickedUp = function(self)
        return pickupManager:isHolding(self)
    end,
}