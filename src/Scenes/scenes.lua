require("src/scene")
require("src/conversion")
require("src/itemTypes")
require("src/items")

function GetInitialScene()
    return GetIntroScene1()
end

function GetIntroScene1() 
    return Scene(nil,
                "Our hero starts their story in the small town of Hazelwood.",
                "What do they have at their side?",
                Conversion("A weapon", {}, {NewRandomWeapon}),
                "And so it begins...\nClick on the weapon and move it to your bag on the right.",
                Conversion("Gold", {}, {NewGoldItem}),
                "And so it begins...\nClick on the gold and move it to your bag on the right.",
                GetIntroScene2, nil)
end

function GetIntroScene2()
    return Scene(Sprites.CharacterFrameBob,
                "They immediately meet a humble weapon merchant. Move an item on a button to use it.",
                "What can I do for ye?",
                Conversion("Sell", {ItemTypes.weapon}, {NewGoldItem}),
                "A nice trade!\n(Don\'t forget to move items to your bag.)",
                Conversion("Buy", {ItemTypes.money}, {NewKnifeItem}),
                nil,
                GetFlowerScene, nil)
end


function GetFlowerScene()
    return Scene(Sprites.CharacterFrameForest,
                "You find an interesting mushroom in the ground next to a big tree. Perhaps it is edible.",
                "Pick it?",
                Conversion("Yes", {}, {NewWeirdMushroomItem}),
                "Might come in useful.",
                Conversion("No", {}, {}),
                "Probably a wise idea.",
                GetPitfallInitialScene, nil)
end


