
require("src/GridObject")

Grid = Class{

    init = function(self, position, cellsWide, cellsHigh, cellWidth, cellHeight)
        self.position = position
        self.cellsWide = cellsWide
        self.cellsHigh = cellsHigh
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight

        self.xPadding = 0.0
        --if xPadding then self.xPadding = xPadding end

        self.yPadding = 0.0
        --if yPadding then self.yPadding = yPadding end

        self._grid = {}
        for i=1, self.cellsWide do
            self._grid[i] = {}
            for j=1, self.cellsHigh do
                local xpos = self.position.x + (i - 1) * (self.cellWidth + self.xPadding)
                local ypos = self.position.y + (j - 1) * (self.cellHeight + self.yPadding)
                local realpos = Vector(xpos, ypos)
                self._grid[i][j] = GridObject(self, Vector(i,j), realpos, self.cellWidth, self.cellHeight)
            end
        end
    end,

    draw = function(self)
        for i=1, self.cellsWide do
            for j=1, self.cellsHigh do
                local gridObj = self._grid[i][j]
                local xpos, ypos = Push:toReal(gridObj.realPosition:unpack())
                local xpos, ypos = Push:toReal(gridObj.realPosition:unpack())
                local w, h = Push:toReal(gridObj.width, gridObj.height)

                if gridObj.content then
                    love.graphics.setColor(Colors.red)
                end
                love.graphics.rectangle("line", xpos, ypos, w, h)
                love.graphics.setColor(Colors.white)
            end
        end
    end,

    isGridIndex = function(self, i, j)
        if not i then
            return false
        end
        if not j then 
            return false
        end

        if i <= 0 or i > self.cellsWide then
            return false
        end
        if j <= 0 or j > self.cellsHigh then
            return false
        end
        return true
    end,

    getGridIndex = function(self, x, y)
        local i = (x - self.position.x) / (self.cellWidth + self.xPadding) + 1
        local j = (y - self.position.y) / (self.cellHeight + self.yPadding) + 1

        local gridi = math.floor(i)
        local gridj = math.floor(j)
        if not self:isGridIndex(gridi, gridj) then
            return nil
        end

        return gridi, gridj
    end,

    getGridObject = function(self, i, j)
        if not self:isGridIndex(i,j) then 
            love.errorhandler("Trying to index non-existing grid cell")
        end

        return self._grid[i][j]
    end,

    getContent = function(self, i, j)
        if not self:isGridIndex(i,j) then 
            love.errorhandler("Trying to index non-existing grid cell")
        end
        return self._grid[i][j]:getContent()
    end,

    isEmpty = function(self, i, j)
        if not self:isGridIndex(i,j) then 
            love.errorhandler("Trying to index non-existing grid cell")
        end
        return self._grid[i][j]:isEmpty()
    end,

    fill = function(self, i, j, content)
        if not self:isGridIndex(i,j) then 
            love.errorhandler("Trying to index non-existing grid cell")
        end
        return self._grid[i][j]:fill(content)
    end,

    overwrite = function(self, i, j, content)
        if not self:isGridIndex(i,j) then 
            love.errorhandler("Trying to index non-existing grid cell")
        end
        return self._grid[i][j]:overwrite(content)
    end,

    clear = function(self, i, j)
        if not self:isGridIndex(i,j) then 
            love.errorhandler("Trying to index non-existing grid cell")
        end
        return self._grid[i][j]:clear()
    end,
}