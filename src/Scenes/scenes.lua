require("src.scene")
require("src.conversion")
require("src.itemTypes")
require("src.items")

function GetInitialScene()
    return GetBeginningScene1()
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
                GetPitfallInitialScene, nil)
end

function _afterPitfallScene()
    return GetBanditAttackInitialScene()
end

function _afterBanditAttackScene()
    return GetAbondonnedCastleInitialScene()
end

function _afterAbondonnedCastleScene()
    return GetEndingScene()
end

function GetDeathScene()
    return Scene(nil,
                "",
                "",
                nil,
                "You died",
                nil,
                nil,
                GetEndingScene, nil)
end

--function GetIntroScene1() 
--    return Scene(nil,
--                "Our hero starts their story in the small town of Hazelwood.",
--                "What do they have at their side?",
--                Conversion("A weapon", {}, {NewRandomWeapon}),
--                "And so it begins...\nClick on the weapon and move it to your bag on the right.",
--                Conversion("Gold", {}, {NewGoldItem}),
--                "And so it begins...\nClick on the gold and move it to your bag on the right.",
--                GetIntroScene2, nil)
--end
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


function GetEndingScene()
    return Scene(Sprites.CharacterFrameForest,
                "That is the entire story so far unfortunately.",
                "Continue from beginning?",
                Conversion("Yes", {}, {}),
                "Good luck!",
                nil,
                "",
                GetInitialScene, nil)

end