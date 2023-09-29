require("src/Instances/scoreManager")
require("src/Instances/player")
require("src/Instances/ball")

gamestates.thegame = {}

function gamestates.thegame:enter()
    InstanceManager.removeAll()

    local playerDistFromEdge = 30

    local ypos = Push:getHeight() / 2
    local player1pos = Vector(playerDistFromEdge, ypos)
    player1 = Player(player1pos, "move_pl1", 1)
    local player2pos = Vector(Push:getWidth() - playerDistFromEdge, ypos)
    player2 = Player(player2pos, "move_pl2", 2)

    ball = Ball(player1, player2)

    scoreManager = ScoreManager()
end

function gamestates.thegame:update(dt)
    --if love.keyboard.isDown("1") then
    --    player1:destroy()
    --end
    --if love.keyboard.isDown("2") then
    --    player2:destroy()
    --end
end

function gamestates.thegame:keyreleased(key, code)
    if key == 'escape' then
        Gamestate.switch(gamestates.menu)
    end
end

