

ItemStorage = Class{
    __includes = {Instance},

    init = function(self, pickupManager)
        Instance.init(self)

        self.position = Vector(76, 49)
        self.item = null
    end,

    update = function(self, dt)
        self:emptyStorageWhenItemMoved()
        self:placeItemAtStorage()
    end,

    emptyStorage = function(self)
        self.item = nil
    end,
    
    isEmpty = function(self)
        return self.item == nil
    end,

    emptyStorageWhenItemMoved = function(self)
        if not self.item then
            return
        end

        if self.item:isPickedUp() then
            self:emptyStorage()
            return
        end
        if self.item:isOnGrid() then
            self:emptyStorage()
            return
        end
    end,

    placeItemAtStorage = function(self)
        if not self.item then
            return
        end

        self.item.position = self.position
    end,

    putInStorage = function(self, item)
        if not self:isEmpty() then
            return false
        end
        self.item = item
        return true
    end,
}