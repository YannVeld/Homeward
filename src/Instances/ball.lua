require("Packages")

Ball = Class{
    __includes = {Instance},

    radius = 8,
    initspeed = 100,
    maxspeed = 1000,
    minspeed = 50,
    speedIncreaseOnBat = 20,
    angleRandomChangeOnBat = 0.01*math.pi,
    initAngle = 0.15*math.pi,
    extraPlayerHeight = 10,
    sprite = Sprites.yellowCircle,
    pointShakeIntensity = 5,

    init = function(self, player1, player2)
        Instance.init(self)
        
        self.player1 = player1
        self.player2 = player2

        self:resetPositionAndVelocity()
    end,

    update = function(self, dt)
        self:moveBall(dt)
    end,

    draw = function(self)
        love.graphics.draw(self.sprite, self.position.x - self.sprite:getWidth()/2, self.position.y - self.sprite:getHeight() / 2)
    end,

    resetPositionAndVelocity = function(self)
        self.position = Vector(Push:getWidth() / 2, Push:getHeight() / 2)
        local angle = love.math.random(-Ball.initAngle, Ball.initAngle)
        self.velocity = Vector.fromPolar(angle, Ball.initspeed)
    end,

    moveBall = function(self, dt)
        self:collideWithPlayer(dt, self.player1)
        self:collideWithPlayer(dt, self.player2)
        self:collideWithWall(dt)

        self.position = self.position + dt * self.velocity
    end,

    collideWithWall = function(self, dt)
        local newposition = self.position + dt * self.velocity

        local edgeleft = 0.0
        local edgeright = Push:getWidth()
        local edgedown = Push:getHeight()
        local edgeup = 0.0

        if newposition.y > edgedown then
            self.velocity.y = -self.velocity.y
        end
        if newposition.y < edgeup then
            self.velocity.y = -self.velocity.y
        end
        if newposition.x > edgeright then
            self:hitSideWalls()
        end
        if newposition.x < edgeleft then
            self:hitSideWalls()
        end
    end,

    collideWithPlayer = function(self, dt, player)
        local newposition = self.position + dt * self.velocity

        if player.id == 1 then
            if newposition.x > player.position.x then
                return
            end
            if self.velocity.x > 0 then
                return
            end
        end
        if player.id == 2 then
            if newposition.x < player.position.x then
                return
            end
            if self.velocity.x < 0 then
                return
            end
        end

        if newposition.y < player.position.y - Ball.extraPlayerHeight/2 then
            return
        end
        if newposition.y > player.position.y + Player.height + Ball.extraPlayerHeight/2 then
            return
        end

        self.velocity.x = -self.velocity.x
        self:increaseBatSpeed(Ball.speedIncreaseOnBat)
    end,

    increaseBatSpeed = function(self, increase)

        local speed = self.velocity:len()
        speed = speed + increase
        self.velocity = self.velocity:normalized() * speed
        local angleChange = love.math.random(-Ball.angleRandomChangeOnBat, Ball.angleRandomChangeOnBat)
        self.velocity:rotateInplace(angleChange)
    end,

    hitSideWalls = function(self)
        local playerid = 1
        if self.position.x < love.graphics.getWidth() / 2 then
            playerid = 2
        end

        Signal.emit("score", playerid)
        Shack:setShake(Ball.pointShakeIntensity)
        self:resetPositionAndVelocity()
    end,
}
