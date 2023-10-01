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
    winSound:setVolume(SoundsVolume + 1.0)

    loseSound = love.audio.newSource("Sounds/Loss.wav", "static")
    loseSound:setVolume(SoundsVolume + 1.0)

    caveinSound = love.audio.newSource("Sounds/Cavein.wav", "static")
    caveinSound:setVolume(SoundsVolume)
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
    return MeetRichPerson()
end

function MeetRichPerson()
    return Scene(Sprites.CharacterFrameForest,
                "As you walk the forest you meet a woman in a fancy dress in a carriage.\n\"Hey you, give me some food please. We ran out.\"",
                "",
                Conversion("Give her food", {ItemTypes.food}, {NewRedGemItem}),
                "\"Here have this in return.\"",
                Conversion("Ignore her", {}, {}),
                "\"Ugh\"",
                GetAbondonnedCastleInitialScene, nil,
                gainItemSound, nil)
end

function _afterAbondonnedCastleScene()
    return GetCityInitialScene()
end

function _afterCityScene()
    return GetFairyInitialScene()
end

function _afterFairyScene()
    return GetHuntersHutInitialScene()
end

function _afterHuntersHutScene()
    return GetEndingInitialScene()
end



function QuitGameScene()
    return Scene(nil,
                "",
                "",
                nil,
                "",
                nil,
                "",
                nil, nil,
                nil, nil,
                nil,
                function() love.event.quit() end)
end



function GetDeathScene()
    return Scene(Sprites.CharacterFrameDeath,
                "You have perished.\n\nWould you like to retry from the beginning?",
                "",
                Conversion("Yes", {}, {}),
                "You can learn from each death.\n\nGood luck!",
                nil,
                nil,
                GetInitialScene, nil,
                nil, nil,
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

