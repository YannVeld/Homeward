ScoreManager = Class{
    __includes = {Instance},

    init = function(self)
        Instance.init(self)
        self.scores = {}
        self.scores[1] = 0
        self.scores[2] = 0

        Signal.register('score', function(playerid) self:gainscore(playerid) end)
    end,

    update = function(self, dt)

    end,

    draw = function(self)
        local dist = 100
        local centery = love.graphics.getHeight() / 2
        love.graphics.print(self.scores[1], dist, centery)
        love.graphics.print(self.scores[2], love.graphics.getWidth() - dist, centery)
    end,

    gainscore = function(self, playerid)
        self.scores[playerid] = self.scores[playerid] + 1
    end
}
