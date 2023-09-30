
love.graphics.setDefaultFilter("nearest", "nearest", 1)

Sprites = {}

Sprites.brownBlock = love.graphics.newImage('Sprites/Placeholder/brownBlock.png')
Sprites.greenSquare = love.graphics.newImage('Sprites/Placeholder/greenSquare.png')
Sprites.redSquare = love.graphics.newImage('Sprites/Placeholder/redSquare.png')
Sprites.yellowCircle = love.graphics.newImage('Sprites/Placeholder/yellowCircle.png')


-- Load all sprites in base folder
local spriteDir = "Sprites/Sprites"
local filenames = love.filesystem.getDirectoryItems(spriteDir)

for i,file in ipairs(filenames) do
    local splitted = Lume.split(file, ".")
    local name = splitted[1]
    local extension = splitted[2]

    if (extension == "png") then
        local sprite = love.graphics.newImage(spriteDir .. "/" .. file)
        Sprites[name] = sprite
    end
end