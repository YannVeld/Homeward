Pickupable = Class{
    __includes = {Instance},

    init = function(self, position, width, height, pickupManager)
        Instance.init(self)

        self.position = position
        self.width = width
        self.height = height
        self.pickupManager = pickupManager
        self.canBeDropped = true
        self.canBePickedUp = true
    end,

    update = function(self, dt)
        if self:isPickedUp() then
            local mousex, mousey = Push:toGame(love.mouse.getPosition())
            self.position = Vector(mousex, mousey)
        end
    end,

    posIsOnItem = function(self, x, y)
        --local mousex, mousey = Push:toGame(love.mouse.getPosition())

        local leftedge = self.position.x - self.width/2
        local topedge = self.position.y - self.height/2
        local rightedge = leftedge + self.width
        local bottomedge = topedge + self.height

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
            if not self.canBeDropped then
                return
            end
            pickupManager:dropItem()
            return
        end

        if not self.canBePickedUp then
            return
        end
        pickupManager:pickupItem(self)
    end,

    isPickedUp = function(self)
        return pickupManager:isHolding(self)
    end,
}