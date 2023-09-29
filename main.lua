require("Packages")
require("src/GameStates")

initialGameState = gamestates.menu

function love.load()
    love.math.setRandomSeed(love.timer.getTime())
    math.randomseed(love.timer.getTime())
    camera = Camera()
    Gamestate.registerEvents()
    Gamestate.switch(initialGameState)
end

function love.update(dt)
    InstanceManager.update(dt)
    Timer.update(dt)
end

function love.draw()
    camera:attach()
    InstanceManager.draw()
    camera:detach()
    InstanceManager.drawUI()
end

