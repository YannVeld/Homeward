DrawLayers = {Normal=1, UI=2}

UIElement = Class{
    __includes = {Instance},

    init = function(self, position, width, height)
        Instance.init(self)

        self.position = position
        self.width = width
        self.height = height

        self.drawLayer = DrawLayers.UI

        -- Background settings
        self.backgroundcolor = Colors.white
        self.backgroundvisible = true

        self.backgroundsprite = nil
        self.scalebackgroundsprite = false

        -- Text settings
        self.font = love.graphics.getFont()
        self.text = ""
        self.textcolor = Colors.black
        self.textha = "center"
        self.textva = "center"
    end,

    setDrawLayer = function(self, layer)
        self.drawLayer = layer
    end,

    setBackgroundColor = function(self, color)
        self.backgroundcolor = color
    end,

    setBackgroundVisibility = function(self, visibility)
        self.backgroundvisible = visibility
    end,

    setBackgroundSprite = function(self, sprite, doscaling)
        self.backgroundsprite = sprite
        if doscaling then
            self.scalebackgroundsprite = doscaling
        end
        self:setBackgroundVisibility(false)
    end,

    setSizeToSpriteSize = function(self)
        if not self.backgroundsprite then
            print("WARNING: Cannot scale UIElement because background sprite is not set")
            return
        end

        self.width = self.backgroundsprite:getWidth()
        self.height = self.backgroundsprite:getHeight()
    end,

    setText = function(self, text, opts)
        if opts and opts.font then
            self.font = opts.font
        end

        self.text = text

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
        local mousex, mousey = Push:toGame(love.mouse.getPosition())
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

    _getTextxPos = function(self, str)
        local _text = love.graphics.newText(self.font, str)

        if self.textha == "left" then
            return self.position.x
        end
        if self.textha == "right" then
            return self.position.x + self.width - _text:getWidth()
        end
        if self.textha == "center" then
            return self.position.x - _text:getWidth() / 2 + self.width / 2
        end
    end,
    _getTextyPos = function(self, str)
        local _text = love.graphics.newText(self.font, str)

        if self.textva == "top" then
            return self.position.y
        end
        if self.textva == "bottom" then
            return self.position.y + self.height - _text:getHeight()
        end
        if self.textva == "center" then
            return self.position.y - _text:getHeight() / 2 + self.height / 2
        end
    end,

    drawElement = function(self)
        -- Draw background
        if self.backgroundvisible then
            love.graphics.setColor(self.backgroundcolor)
            love.graphics.rectangle("fill",self.position.x, self.position.y, self.width, self.height)
            love.graphics.setColor(Colors.white)
        end

        -- Draw backgroundsprite
        if self.backgroundsprite then

            local sx = 1
            local sy = 1
            if self.scalebackgroundsprite then
                sx = self.width  / self.backgroundsprite:getWidth()
                sy = self.height / self.backgroundsprite:getHeight()
            end

            love.graphics.draw(self.backgroundsprite, self.position.x, self.position.y, 0.0, sx, sy)
        end

        -- Draw text
        love.graphics.setColor(self.textcolor)

        local font = love.graphics.getFont()
        local width, wrapped = font:getWrap(self.text, self.width)
        for i,line in ipairs(wrapped) do
            local xpos = self:_getTextxPos(line)
            local ypos = self:_getTextyPos(line)
            love.graphics.print(line, xpos, ypos + (i-1) * font:getLineHeight() * font:getHeight())
        end

        love.graphics.setColor(Colors.white)
    end,

    drawUI = function(self)
        if self.drawLayer == DrawLayers.UI then
            self:drawElement()
        end
    end,

    draw = function(self)
        if self.drawLayer == DrawLayers.Normal then
            self:drawElement()
        end
    end,
}