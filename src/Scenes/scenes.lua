require("src/scene")
require("src/conversion")

function GetInitialScene()
    return GetScene1()
end

function GetScene1() 
    return Scene("Out hero starts their story here, in the town of Hazelwood.",
                "What do they have at their side?",
                Conversion("Gain Weapon", {}, {NewSwordItem}),
                Conversion("Gain Gold", {}, {NewGoldItem}),
                "And so it begins...",
                GetScene2, GetScene2)
end

function GetScene2()
    return Scene("He immediately meets a humble merchant",
                "What can I do for ye?",
                Conversion("Weapon\n->\nGold", {ItemTypes.weapon}, {NewGoldItem}),
                Conversion("Gold\n->\nWeapon", {ItemTypes.money}, {NewKnifeItem}),
                "A trade well done",
                GetScene1, GetScene1)
end
