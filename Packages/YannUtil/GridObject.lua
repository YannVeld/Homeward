
GridObject = Class{
    init = function(self, myGrid, gridPosition, realPosition, width, height)
        self.grid = myGrid
        self.position = gridPosition
        self.realPosition = realPosition
        self.width = width
        self.height = height
        self.content = nil
    end,

    getCenter = function(self)
        return self.realPosition.x + self.width / 2, self.realPosition.y + self.height / 2
    end,

    getContent = function(self)
        return self.content
    end,

    isEmpty = function(self)
        return self.content == nil
    end,

    fill = function(self, content)
        if not self:isEmpty() then
            return false
        end
        self.content = content
        return true
    end,

    overwrite = function(self, content)
        self.content = content
    end,

    clear = function(self)
        self.content = nil
    end,
}