

ItemPickupManager = Class{

    init = function(self)
        self.pickedupItem = nil
    end,

    update = function(self, dt)
    end,

    pickupItem = function(self, item)
        if self.pickedupItem then
            return false
        end
        self.pickedupItem = item
        return true
    end,

    swapItem = function(self, item)
        self.pickedupItem = item
    end,

    dropItem = function(self)
        self.pickedupItem = nil
    end,

    isHolding = function(self, item)
        return item == self.pickedupItem
    end,
}