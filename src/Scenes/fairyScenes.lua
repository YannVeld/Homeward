

function GetFairyInitialScene()
    return GetFairyScene1()
end

function GetFairyScene1()
    return Scene(Sprites.CharacterFrameForest,
                "You hear some pleasant singing in the forest as you are hiking. You feel yourself getting drawn to it.",
                "Clear your mind with a potion?",
                Conversion("Yes", {ItemTypes.potion}, {}),
                "Your mind clears and you stay well clear of the mysterious mind-bending music.",
                Conversion("No", {}, {}),
                "You find yourself walking to a clearing. There, a small fairy stops singing to turn and look at you.\n\"Hihi, hello!\"",
                _afterFairyScene, GetFairyScene2)
end

function GetFairyScene2()
    return Scene(Sprites.CharacterFrameForest,
                "The fairy floats up and looks curiously at your face.\n\"Can you give me a present?\"",
                "Give her something?",
                Conversion("?", {ItemTypes.gem}, {NewFlowerItem}),
                "\"Oh, so pretty! I will keep it, hihi. You can have this!\"\nshe says, before disappearing into the forest.",
                Conversion("No", {}, {}),
                "You see the fairy starting to cry. You feel your mind getting fuzzy. Was this a mistake?",
                _afterFairyScene, GetFairyScene3)
end

function _giveRandomItemToFairy()
    local itemsInBag = GetAllItemsInBag()
    if #itemsInBag <= 0 then
        return
    end

    local item = Lume.randomchoice(itemsInBag)
    item:destroy()
end

function GetFairyScene3()
    return Scene(Sprites.CharacterFrameForest,
                "",
                "",
                nil,
                "In your confused state you stumble for anything to give the fairy. You give her the first thing you find.",
                nil,
                nil,
                _afterFairyScene, nil,
                function() _giveRandomItemToFairy() end)
end