Player = Class{
    __includes = {Instance},

    height = 32,
    width = 4,
    speed = 200,
    sprite = Sprites.redSquare,

    init = function(self, position, upkey, downkey, id, inputpair)
        Instance.init(self)
        self.position = position
        self.upkey = upkey
        self.downkey = downkey
        self.id = id
        self.inputpair = inputpair
    end,

    update = function(self, dt)
        --if love.keyboard.isDown(self.downkey) then
        --    self:movePlayer(Player.speed * dt)
        --end

        --if love.keyboard.isDown(self.upkey) then
        --    self:movePlayer(-Player.speed * dt)
        --end

        local ix, iy = input:get(self.inputpair)
        self:movePlayer(Player.speed * ix * dt)

    end,

    draw = function(self)
        love.graphics.draw(self.sprite, self.position.x, self.position.y, 0.0, Player.width / self.sprite:getWidth(), Player.height / self.sprite:getHeight())
    end,

    movePlayer = function(self,spd)
        self.position.y = self.position.y + spd

        if self.position.y < 0 then
            self.position.y = 0
        end
        if self.position.y > Push:getHeight() - Player.height then
            self.position.y = Push:getHeight() - Player.height
        end
    end,
}
