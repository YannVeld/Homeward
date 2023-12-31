require("Packages")
require("Sprites")
require("Fonts")
require("src.GameStates")
require("input")

-- Initialization variables
local initialGameState = gamestates.thegame
local gameWidth, gameHeight = 240, 135 --1280, 720
local windowToGameScale = 4

local musicVolume = 0.5
local soundsVolume = 0.5

function love.load()
    SetupRandomSeed()
    SetupScreen()
    Shack:setDimensions(Push:getDimensions())
    SetupGameFont()
    input = GetInputs()
    camera = Camera()
    SetupGameMusic()
    SoundsVolume = soundsVolume
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
    love.graphics.draw(Sprites.GameView, 0.0, 0.0)
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

function SetupGameFont()
    Fonts.m3x6:setLineHeight(0.7)
    love.graphics.setFont(Fonts.m3x6)
end

function SetupGameMusic()
    MusicSource = love.audio.newSource("Music/LD54Song.mp3", "stream")
    MusicSource:setLooping(true)
    MusicSource:setVolume(musicVolume)
    MusicSource:play()
end


function InitializeGameState()
    Gamestate.registerEvents()
    Gamestate.switch(initialGameState)
end