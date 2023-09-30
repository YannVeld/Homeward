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
            self.position = Vector(mousex - self.width/2, mousey - self.height/2)
        end
    end,

    posIsOnItem = function(self, x, y)
        --local mousex, mousey = Push:toGame(love.mouse.getPosition())

        local leftedge = self.position.x
        local topedge = self.position.y
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
        if not button == 1 then
            return
        end

        if pickupManager:isHolding(self) then
            return self:dropMe()
        end

        local mousex, mousey = Push:toGame(x, y)
        if self:posIsOnItem(mousex, mousey) then
            return self:pickupMe()
        end
    end,

    pickupMe = function(self)
        if not self.canBePickedUp then
            return false
        end
        return pickupManager:pickupItem(self)
    end,

    dropMe = function(self)
        if not self.canBeDropped then
            return false
        end
        return pickupManager:dropItem()
    end,

    isPickedUp = function(self)
        return pickupManager:isHolding(self)
    end,

    checkCanBepickedup = function(self)
        if self.pickupManager.itemLocked then
            return false
        end
        if not self.canBePickedUp then
            return false
        end
        if self:isPickedUp() then
            return true
        end
        if not self.pickupManager:isHolding(nil) then
            return false
        end
        return true
    end,
}