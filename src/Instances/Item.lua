require("src/Instances/Pickupable")

Item = Class{
    __includes = {Pickupable},

    init = function(self, position, sprite, shape, pickupManager, itemGrid)
        Pickupable.init(self, position, sprite:getWidth(), sprite:getHeight(), pickupManager)

        self.sprite = sprite
        self.shape = shape
        self.itemGrid = itemGrid

        self.isPlacedOnGrid = false
        self.gridObjs = {}
        for i = 1, #self.shape do
            self.gridObjs[i] = nil
        end
    end,

    update = function(self, dt)
        if self:isPickedUp() then
            self:moveWithMouse()
        end
    end,

    draw = function(self)
        for i,pos in ipairs(self.shape) do
            local xpos = self.position.x + pos[1] * self.itemGrid.cellWidth - self.sprite:getWidth() / 2
            local ypos = self.position.y + pos[2] * self.itemGrid.cellHeight - self.sprite:getHeight() / 2
            love.graphics.draw(self.sprite, xpos, ypos)
        end
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
            if not Lume.find(self.gridObjs, self.itemGrid:getGridObject(i,j)) then
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

    canPutOnGrid = function(self, i, j)
        for ind, pos in ipairs(self.shape) do
            local gridi = i + pos[1]
            local gridj = j + pos[2]
            if not self.itemGrid:isGridIndex(gridi, gridj) then
                return false
            end
            if not self.itemGrid:isEmpty(gridi, gridj) then
                return false
            end
        end
        return true
    end,

    putOnGrid = function(self, i, j)
        if not self:canPutOnGrid(i,j) then
            return false
        end

        for ind, pos in ipairs(self.shape) do
            local gridi = i + pos[1]
            local gridj = j + pos[2]
            local succes = myGrid:fill(gridi, gridj, self)
            if not succes then
                love.errorhandler("Something went wrong in placing item on grid")
                return false
            end
            self.gridObjs[ind] = myGrid:getGridObject(gridi, gridj)
        end
        
        self.isPlacedOnGrid = true
        self:dropMe()
    end,

    pickupFromGrid = function(self)
        local succes = self:pickupMe()
        if not succes then
            return false
        end
        for i, obj in ipairs(self.gridObjs) do
            obj:clear()
            obj = nil
        end
        self.isPlacedOnGrid = false
    end,

    isOnGrid = function(self)
        return self.isPlacedOnGrid
    end,
}