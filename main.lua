require("Packages")
require("Sprites")
require("Fonts")
require("src/GameStates")
require("input")

-- Initialization variables
local initialGameState = gamestates.thegame
local gameWidth, gameHeight = 320, 180 --1280, 720
local windowToGameScale = 4

function love.load()
    SetupRandomSeed()
    SetupScreen()
    Shack:setDimensions(Push:getDimensions())
    love.graphics.setFont(Fonts.m3x6)
    input = GetInputs()
    camera = Camera()
    InitializeGameState()
end

function love.update(dt)
    love.graphics.origin()
    Shack:update(dt)
    input:update()
    InstanceManager.update(dt)
    Timer.update(dt)
end

function love.draw()
    Push:start()
    Shack:apply()
    camera:attach()
    InstanceManager.draw()
    camera:detach()
    InstanceManager.drawUI()
    Push:finish()
end

function love.mousereleased(x, y, button, istouch, presses)
    InstanceManager.mousereleased(x, y, button, istouch, presses)
end

function love.mousepressed(x, y, button, istouch, presses)
    InstanceManager.mousepressed(x, y, button, istouch, presses)
end

function SetupRandomSeed()
    love.math.setRandomSeed(love.timer.getTime())
    math.randomseed(love.timer.getTime())
end

function SetupScreen()
    local windowWidth, windowHeight = gameWidth * windowToGameScale, gameHeight * windowToGameScale
    Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, pixelperfect = false, resizable=false})
    --local windowWidth, windowHeight = love.window.getDesktopDimensions()
    --Push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true})
end

function InitializeGameState()
    Gamestate.registerEvents()
    Gamestate.switch(initialGameState)
end