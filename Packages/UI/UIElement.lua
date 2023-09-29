
UIElement = Class{
    __includes = {Instance},

    init = function(self, position, width, height)
        Instance.init(self)

        self.position = position
        self.width = width
        self.height = height

        -- Background settings
        self.backgroundcolor = Colors.white
        self.backgroundvisible = true

        -- Text settings
        self.font = love.graphics.getFont()
        self.text = love.graphics.newText(self.font, "")
        self.textcolor = Colors.black
        self.textha = "center"
        self.textva = "center"
    end,

    setBackgroundColor = function(self, color)
        self.backgroundcolor = color
    end,

    setBackgroundVisibility = function(self, visibility)
        self.backgroundvisible = visibility
    end,

    setText = function(self, text, opts)
        if opts and opts.font then
            self.font = font
        end

        self.text = love.graphics.newText(self.font, text)

        if not opts then return end

        if opts.color then
            self.textcolor = opts.color
        end
        if opts.ha then
            self.textha = opts.ha
        end
        if opts.va then
            self.textva = opts.va
        end
    end,

    mouseIsHovering = function(self)
        local mousex, mousey = love.mouse.getPosition()
        if mousex < self.position.x then
            return false
        end
        if mousex > self.position.x + self.width then
            return false
        end
        if mousey < self.position.y then
            return false
        end
        if mousey > self.position.y + self.height then
            return false
        end
        return true
    end,

    _getTextxPos = function(self)
        if self.textha == "left" then
            return self.position.x
        end
        if self.textha == "right" then
            return self.position.x + self.width - self.text:getWidth()
        end
        if self.textha == "center" then
            return self.position.x - self.text:getWidth() / 2 + self.width / 2
        end
    end,
    _getTextyPos = function(self)
        if self.textva == "top" then
            return self.position.y
        end
        if self.textva == "bottom" then
            return self.position.y + self.height - self.text:getHeight()
        end
        if self.textva == "center" then
            return self.position.y - self.text:getHeight() / 2 + self.height / 2
        end
    end,

    drawUI = function(self)
        -- Draw background
        if self.backgroundvisible then
            love.graphics.setColor(self.backgroundcolor)
            love.graphics.rectangle("fill",self.position.x, self.position.y, self.width, self.height)
            love.graphics.setColor(Colors.white)
        end

        -- Draw text
        love.graphics.setColor(self.textcolor)
        local xpos = self:_getTextxPos()
        local ypos = self:_getTextyPos()
        love.graphics.draw(self.text, xpos, ypos)
        love.graphics.setColor(Colors.white)
    end,
}