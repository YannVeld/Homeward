require("src/Instances/Pickupable")

Item = Class{
    __includes = {Pickupable},

    init = function(self, position, sprite, cellsWide, cellsHigh, pickupManager, itemGrid)
        Pickupable.init(self, position, sprite:getWidth(), sprite:getHeight(), pickupManager)

        self.sprite = sprite
        self.cellsWide = cellsWide
        self.cellsHigh = cellsHigh
        self.itemGrid = itemGrid

        self.gridObj = nil
    end,

    update = function(self, dt)
        if self:isPickedUp() then
            self:moveWithMouse()
        end

    end,

    draw = function(self)
        love.graphics.draw(self.sprite, self.position.x - self.sprite:getWidth()/2, self.position.y - self.sprite:getHeight() / 2)
    end,

    mousereleased = function(self, x, y, button, istouch, presses)
        if not button == 1 then
            return
        end

        local mousex, mousey = Push:toGame(x, y)
        local i,j = self.itemGrid:getGridIndex(mousex, mousey)
        local mouseIsOnGrid =  self.itemGrid:isGridIndex(i,j)

        if not mouseIsOnGrid then
            return Pickupable.mousereleased(self, x, y, button, istouch, presses)
        end

        if self:isOnGrid() then
            if self.itemGrid:getGridObject(i,j) ~= self.gridObj then
                return
            end

            self:pickupFromGrid()
            return
        end
        self:putOnGrid(i,j)
    end,

    moveWithMouse = function(self)
        local mousex, mousey = Push:toGame(love.mouse.getPosition())
        local i,j = self.itemGrid:getGridIndex(mousex, mousey)
        local mouseIsOnGrid =  self.itemGrid:isGridIndex(i,j)

        if not mouseIsOnGrid then
            self.position = Vector(mousex, mousey)
            return
        end

        local gridx, gridy = self.itemGrid:getCenter(i,j)
        self.position = Vector(gridx, gridy)
    end,

    putOnGrid = function(self, i, j)
        local succes = myGrid:fill(i, j, self)
        if not succes then
            return false
        end
        self:dropMe()
        self.gridObj = myGrid:getGridObject(i, j)
    end,

    pickupFromGrid = function(self)
        local succes = self:pickupMe()
        if not succes then
            return false
        end
        self.gridObj:clear()
        self.gridObj = nil
    end,

    isOnGrid = function(self)
        if self.gridObj then
            return true
        end
        return false
    end,
}