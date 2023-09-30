require("src/Instances/scoreManager")
require("src/Instances/player")
require("src/Instances/ball")

require("src/Instances/Item")
require("src/Instances/itemPickupManager")

gamestates.thegame = {}

function gamestates.thegame:enter()
    InstanceManager.removeAll()

    local pos = Vector(166,19)
    local width = 4
    local height = 4
    local cellWidth = 16
    local cellHeight = 16
    myGrid = Grid(pos, width, height, cellWidth, cellHeight)

    --local playerDistFromEdge = 30

    --local ypos = Push:getHeight() / 2
    --local player1pos = Vector(playerDistFromEdge, ypos)
    --player1 = Player(player1pos, "move_pl1", 1)
    --local player2pos = Vector(Push:getWidth() - playerDistFromEdge, ypos)
    --player2 = Player(player2pos, "move_pl2", 2)

    --ball = Ball(player1, player2)

    --scoreManager = ScoreManager()

    pickupManager = ItemPickupManager()

    local pos = Vector(16, 16)
    local shape = {{0,0},{0,1},{0,2}}
    local basecell = 2
    anItem = Item(pos, Sprites["1x3itemsSword"], Sprites["1x3itemsWeapons"], shape, basecell, pickupManager, myGrid)

    local pos = Vector(16, 64)
    local shape = {{0,0}}
    local basecell = 1
    anItem2 = Item(pos, Sprites["1x1ItemsKnife"], Sprites["1x1ItemsWeapons"], shape, basecell, pickupManager, myGrid)
end

function gamestates.thegame:update(dt)
    --local mousex, mousey = Push:toGame(love.mouse.getPosition())

    --local i,j = myGrid:getGridIndex(mousex, mousey)
    --if myGrid:isGridIndex(i,j) then
    --    myGrid:overwrite(i,j,true)
    --end

end

function gamestates.thegame:keyreleased(key, code)
    if key == 'escape' then
        Gamestate.switch(gamestates.menu)
    end

    if key == 'space' then
        myGrid:clearAll()
    end
end

function gamestates.thegame:draw()
    --myGrid:draw()
end
