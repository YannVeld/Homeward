Button = Class{
    __includes = {UIElement},

    init = function(self, position, width, height)
        UIElement.init(self, position, width, height)

        self._buttonHeld = false
        self._buttonPressed = false
        self._buttonReleased = false
        self._buttonHovered = false
        self._buttonHoverStarted = false
        self._buttonHoverEnded = false
        self._onButtonHeld = function() end
        self._onButtonPressed = function() end
        self._onButtonReleased = function() end
        self._onButtonHovered = function() end
        self._onButtonHoverStart = function() end
        self._onButtonHoverEnd = function() end

        self._normalColor = Colors.white
        self._hoveredColor = Colors.grey
        self._heldColor = Colors.black

        self._normalSprite = nil
        self._hoveredSprite = nil
        self._heldSprite = nil
    end,

    update = function(self, dt)
        self:_updateButtonPressVars()
        self:_updateButtonHoverVars()
        self:_checkInvokeFunction()
        self:_checkBackgroundColors()
        self:_checkBackgroundSprites()
    end,

    setOnButtonHeld = function(self, onButtonHeld)
        self._onButtonHeld = onButtonHeld
    end,
    setOnButtonPressed = function(self, onButtonPressed)
        self._onButtonPressed = onButtonPressed
    end,
    setOnButtonReleased = function(self, onButtonReleased)
        self._onButtonReleased = onButtonReleased
    end,
    setOnButtonHovered = function(self, onButtonHovered)
        self._onButtonHovered = onButtonHovered
    end,
    setOnButtonHoverStart = function(self, onButtonHoverStart)
        self._onButtonHoverStart = onButtonHoverStart
    end,
    setOnButtonHoverEnd = function(self, onButtonHoverEnd)
        self._onButtonHoverEnd = onButtonHoverEnd
    end,

    setBackgroundColors = function(self, normalColor, hoveredColor, heldColor)
        self._normalColor = normalColor
        self._hoveredColor = hoveredColor
        self._heldColor = heldColor
    end,

    setBackgroundSprites = function(self, normalSprite, hoveredSprite, heldSprite, doscaling)
        self._normalSprite = normalSprite
        self._hoveredSprite = hoveredSprite
        self._heldSprite = heldSprite
        if doscaling then
            self.scalebackgroundsprite = doscaling
        end
        self:setBackgroundVisibility(false)
    end,

    _updateButtonPressVars = function(self)
        self._buttonPressed = false
        self._buttonReleased = false
        local holdingButton = self:_checkButtonHeld()

        -- If the button is being held
        if holdingButton then
            if not self._buttonHeld then
                self._buttonPressed = true
            end
            self._buttonHeld = true
            return
        end

        -- If the button is not being held
        if self._buttonHeld then
            self._buttonReleased = true
        end
        self._buttonHeld = false
    end,

    _updateButtonHoverVars = function(self)
        self._buttonHoverStarted = false
        self._buttonHoverEnded = false
        local hoveringButton = self:mouseIsHovering()

        -- If the button is being hovered
        if hoveringButton then
            if not self._buttonHovered then
                self._buttonHoverStarted = true
            end
            self._buttonHovered = true
            return
        end

        -- If the button is not being hovered
        if self._buttonHovered then
            self._buttonHoverEnded = true
        end
        self._buttonHovered = false
    end,

    _checkButtonHeld = function(self, button)
        local isHovered = self:mouseIsHovering()
        if not isHovered then
            return false
        end

        if not button then
            button = 1
        end
        return love.mouse.isDown(button) 
    end,

    _checkInvokeFunction = function(self)
        if self._buttonPressed then self._onButtonPressed() end
        if self._buttonReleased then self._onButtonReleased() end
        if self._buttonHeld then self._onButtonHeld() end
        if self._buttonHovered then self._onButtonHovered() end
        if self._buttonHoverStarted then self._onButtonHoverStart() end
        if self._buttonHoverEnded then self._onButtonHoverEnd() end
    end,

    _checkBackgroundColors = function(self)
        self:setBackgroundColor(self._normalColor)
        if self._buttonHovered then self:setBackgroundColor(self._hoveredColor) end
        if self._buttonHeld then self:setBackgroundColor(self._heldColor) end
    end,

    _checkBackgroundSprites = function(self)
        local backColorIsVisible = self.backgroundvisible

        self:setBackgroundSprite(self._normalSprite)
        if self._buttonHovered then self:setBackgroundSprite(self._hoveredSprite) end
        if self._buttonHeld then self:setBackgroundSprite(self._heldSprite) end

        self:setBackgroundVisibility(backColorIsVisible)
    end,
}