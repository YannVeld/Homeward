
InfoScreenManager = Class{
    __includes = {Instance},

    init = function(self, pickupManager)
        Instance.init(self)

        self.position = Vector(169, 95)
        self.pickupManager = pickupManager
        self.text = love.graphics.newText(love.graphics:getFont(), "")
    end,

    draw = function(self)
        local textColor = Colors.hexToRGB("#4B3D44")

        local item = self.pickupManager.pickedupItem
        if not item then
            item = self.pickupManager.pickupableUnderneathMouse
            if not item then
                return
            end
            if not item.itemsprite then
                return
            end
        end
        --self.text:set(item.name .. " (" .. item.types[1] .. ")")
        self.text:set(item.name)

        love.graphics.setColor(textColor)
        love.graphics.draw(self.text, self.position.x, self.position.y)
        --love.graphics.print(item.name, self.position.x, self.position.y)
        love.graphics.setColor(Colors.white)
    end,
}