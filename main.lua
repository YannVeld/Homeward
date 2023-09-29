require("Packages")
require("Sprites")
require("Fonts")
require("src/GameStates")

initialGameState = gamestates.menu

--local gameWidth, gameHeight = 1080, 720
local gameWidth, gameHeight = 320, 180
local windowToGameScale = 4

function love.load()
    love.math.setRandomSeed(love.timer.getTime())
    math.randomseed(love.timer.getTime())

    local windowWidth, windowHeight = gameWidth * windowToGameScale, gameHeight * windowToGameScale
    Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, pixelperfect = false, resizable=false})
    
    --local windowWidth, windowHeight = love.window.getDesktopDimensions()
    --Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true})

    -- Set default font
    love.graphics.setFont(Fonts.m3x6)

    camera = Camera()
    Gamestate.registerEvents()
    Gamestate.switch(initialGameState)

end

function love.update(dt)
    InstanceManager.update(dt)
    Timer.update(dt)
end

function love.draw()
    Push:start()
    camera:attach()
    InstanceManager.draw()
    camera:detach()
    InstanceManager.drawUI()
    Push:finish()
end

