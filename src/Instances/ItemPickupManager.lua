

ItemPickupManager = Class{

    init = function(self)
        self.pickedupItem = nil
        self.itemLocked = false
        self.pickupableUnderneathMouse = nil
    end,

    update = function(self, dt)
        self:checkPickupableUnderMouse()
    end,

    checkPickupableUnderMouse = function(self)
        if not self.pickupableUnderneathMouse then
            self.pickupableUnderneathMouse = nil
            return
        end

        if not self.pickupableUnderneathMouse:isHoveredByMouse() then
            self.pickupableUnderneathMouse = nil
            return
        end
    end,

    setItemLock = function(self, lock)
        self.itemLocked = lock
    end,

    pickupItem = function(self, item)
        if self.itemLocked then
            return false
        end
        if self.pickedupItem then
            return false
        end
        self.pickedupItem = item
        return true
    end,

    swapItem = function(self, item)
        if self.itemLocked then
            return false
        end
        self.pickedupItem = item
    end,

    dropItem = function(self)
        if self.itemLocked then
            return false
        end
        self.pickedupItem = nil
    end,

    isHolding = function(self, item)
        return item == self.pickedupItem
    end,

    isEmpty = function(self)
        return self.pickedupItem == nil
    end,
}