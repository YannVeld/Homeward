Player = Class{
    __includes = {Instance},

    height = 80,
    width = 5,
    speed = 300,

    init = function(self, position, upkey, downkey, id)
        Instance.init(self)
        self.position = position
        self.upkey = upkey
        self.downkey = downkey
        self.id = id
    end,

    update = function(self, dt)
        if love.keyboard.isDown(self.downkey) then
            self:movePlayer(Player.speed * dt)
        end

        if love.keyboard.isDown(self.upkey) then
            self:movePlayer(-Player.speed * dt)
        end

    end,

    draw = function(self)
        love.graphics.rectangle("fill", self.position.x, self.position.y, Player.width, Player.height)
    end,

    movePlayer = function(self,spd)
        self.position.y = self.position.y + spd

        if self.position.y < 0 then
            self.position.y = 0
        end
        if self.position.y > love.graphics.getHeight() - Player.height then
            self.position.y = love.graphics.getHeight() - Player.height
        end
    end,
}
