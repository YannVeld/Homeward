
InfoScreenManager = Class{
    __includes = {Instance},

    init = function(self, pickupManager, grid)
        Instance.init(self)

        self.position = Vector(172, 96)
        self.valueOffset = 5
        self.pickupManager = pickupManager
        self.grid = grid
        self.textColor = Colors.hexToRGB("#4B3D44")
    end,

    draw = function(self)
        self:drawItemInfo()
    end,

    drawItemInfo = function(self)
        local item = self.pickupManager.pickedupItem
        if not item then
            item = self.pickupManager.pickupableUnderneathMouse
            if not item then
                return self:drawTotalBagValue()
            end
            if not item.itemsprite then
                return self:drawTotalBagValue()
            end
        end
       
        local typeCol = ItemTypeToColor(item.types[1])

        love.graphics.setColor(typeCol)
        love.graphics.print(item.name, self.position.x, self.position.y)
        love.graphics.setColor(self.textColor)
        love.graphics.print("Value: "..item.value, self.position.x, self.position.y + love.graphics.getFont():getLineHeight() * love.graphics.getFont():getHeight())
        love.graphics.setColor(Colors.white)
    end,

    drawTotalBagValue = function(self)
        local totalValue = GetTotalBagValue()
        love.graphics.setColor(self.textColor)

        love.graphics.print("Total value:", self.position.x, self.position.y)
        love.graphics.print(totalValue, self.position.x + self.valueOffset, self.position.y + love.graphics.getFont():getLineHeight() * love.graphics.getFont():getHeight())
        love.graphics.setColor(Colors.white)
    end,

}