require("src/scene")
require("src/conversion")
require("src/itemTypes")
require("src/items")

function GetInitialScene()
    return GetScene1()
end

function GetScene1() 
    return Scene(nil,
                "Out hero starts their story here, in the town of Hazelwood.",
                "What do they have at their side?",
                Conversion("Gain Weapon", {}, {NewSwordItem}),
                "And so it begins...",
                Conversion("Gain Gold", {}, {NewGoldItem}),
                nil,
                GetScene2, nil)
end

function GetScene2()
    return Scene(nil,
                "He immediately meets a humble merchant",
                "What can I do for ye?",
                Conversion("Weapon\n->\nGold", {ItemTypes.weapon}, {NewGoldItem}),
                "A trade well done",
                Conversion("Gold\n->\nWeapon", {ItemTypes.money}, {NewKnifeItem}),
                nil,
                GetFlowerScene, nil)
end


function GetFlowerScene()
    return Scene(nil,
                "You find an interesting mushroom in the ground next to a big tree. Perhaps it is edible.",
                "Pick it?",
                Conversion("Yes", {}, {NewWeirdMushroomItem}),
                "Might come in useful.",
                Conversion("No", {}, {}),
                "Probably a wise idea.",
                GetPitfallInitialScene, nil)
end