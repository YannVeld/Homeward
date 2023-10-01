require("Packages.UI")

gamestates.menu = {}

function gamestates.menu:draw()
end

function gamestates.menu:keyreleased(key, code)
    if key == 'escape' then
        love.event.quit()
    end
end

function gamestates.menu:enter()
    InstanceManager.removeAll()

    local centerx = Push:getWidth() / 2
    local centery = Push:getHeight() / 2
    local buttonwidth = 32
    local buttonheight = 16

    myButton = Button(Vector(centerx-buttonwidth/2,centery-buttonheight/2), buttonwidth, buttonheight)
    myButton:setText("Start", {color=Colors.black, ha="center", va="center"})
    myButton:setOnButtonReleased(function() Gamestate.switch(gamestates.thegame) end)
    myButton:setBackgroundColors(Colors.white, Colors.gray, Colors.snow)
    --myButton:setBackgroundSprites(Sprites.brownBlock, Sprites.greenSquare, Sprites.redSquare, true)

    myButton = Button(Vector(centerx-buttonwidth/2,centery+buttonheight*1.5-buttonheight/2), buttonwidth, buttonheight)
    myButton:setText("Quit", {color=Colors.black, ha="center", va="center"})
    myButton:setOnButtonReleased(function() love.event.quit() end)
    myButton:setBackgroundColors(Colors.white, Colors.gray, Colors.snow)
end


