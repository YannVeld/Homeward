require("src.scene")
require("src.conversion")
require("src.itemTypes")
require("src.items")

function SetupSceneSounds()
    gainItemSound = love.audio.newSource("Sounds/gain1.wav", "static")
    gainItemSound:setVolume(SoundsVolume)
    
    superGainItemSound = love.audio.newSource("Sounds/supergain.wav", "static")
    superGainItemSound:setVolume(SoundsVolume)
    
    winSound = love.audio.newSource("Sounds/Win.wav", "static")
    winSound:setVolume(SoundsVolume)
    
    loseSound = love.audio.newSource("Sounds/Loss.wav", "static")
    loseSound:setVolume(SoundsVolume)
end

function GetInitialScene()
    return GetBeginningScene1()
    --return GetTestScene()
end

function _afterBeginningScene()
    return GetFlowerScene()
end

function GetFlowerScene()
    return Scene(Sprites.CharacterFrameForest,
                "You find an interesting mushroom in the ground next to a big tree. Perhaps it is edible.",
                "Pick it?",
                Conversion("Yes", {}, {NewRandomMushroomItem}),
                "Might come in useful.",
                Conversion("No", {}, {}),
                "Probably a wise idea.",
                GetPitfallInitialScene, nil,
                gainItemSound, nil)
end

function _afterPitfallScene()
    return MeetWizardScene()
end

function MeetWizardScene()
    return Scene(Sprites.CharacterFrameForest,
                "\"Hello, you!\", you hear from behind you. You turn to see a woman in robes and a pointy hat walking towards you.",
                "Could I interest you in a potion?",
                Conversion("Buy potion", {ItemTypes.money}, {NewRandomPotion}),
                "\"Thanks for the purchase!\"",
                Conversion("No", {}, {}),
                "\"Well, your loss.\"",
                GetBanditAttackInitialScene, nil,
                gainItemSound, nil)
end

function _afterBanditAttackScene()
    return GetAbondonnedCastleInitialScene()
end

function _afterAbondonnedCastleScene()
    return GetFairyScene1()
end

function _afterFairyScene()
    return GetHuntersHutInitialScene()
end

function _afterHuntersHutScene()
    return GetCityInitialScene()
end

function _afterCityScene()
    return GetEndingScene()
end


function GetEndingScene()
    return Scene(Sprites.CharacterFrameForest,
                "That is the entire story so far unfortunately.",
                "Continue from beginning?",
                Conversion("Yes", {}, {}),
                "Good luck!",
                nil,
                "",
                GetInitialScene, nil,
                nil, nil,
                winSound)

end




function GetDeathScene()
    return Scene(Sprites.CharacterFrameDeath,
                "You have perished.\nWould you like to retry from the beginning?",
                "",
                Conversion("Yes", {}, {}),
                "You can learn from each death.\nGood luck!",
                nil,
                nil,
                GetInitialScene, nil,
                loseSound)
end

function GetTestScene() 
    return Scene(nil,
                "This is a test scene",
                "Choose an option please",
                Conversion("A weapon", {}, {NewRandomWeapon}),
                "Option 1",
                Conversion("Gold", {}, {NewGoldItem}),
                "Option 2",
                GetDeathScene, nil)
end
--
--function GetIntroScene2()
--    return Scene(Sprites.CharacterFrameBob,
--                "They immediately meet a humble weapon merchant. Move an item on a button to use it.",
--                "What can I do for ye?",
--                Conversion("Sell", {ItemTypes.weapon}, {NewGoldItem}),
--                "A nice trade!\n(Don\'t forget to move items to your bag.)",
--                Conversion("Buy", {ItemTypes.money}, {NewKnifeItem}),
--                nil,
--                GetFlowerScene, nil)
--end

