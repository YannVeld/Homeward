
function GetAbondonnedCastleInitialScene()
    return GetAbondonnedCastleScene1()
end

function GetAbondonnedCastleScene1()
    return Scene(Sprites.CharacterFrameForest,
                "In front of you lies an abondenned castle. The only way forward is through it. Will you camp inside or outside the castle?",
                "",
                Conversion("Inside", {}, {}),
                "What if it will rain?",
                Conversion("Outside", {}, {}),
                "Who knows what is in there.",
                GetAbondonnedCastleScene2_inside, GetAbondonnedCastleScene2_outside1)
end

function GetAbondonnedCastleScene2_inside()
    return Scene(Sprites.CharacterFrameForest,
                "You go inside to make up camp for the night. There, you find an old weapon storehouse!",
                "Take a look inside?",
                Conversion("Yes", {}, {NewRandomWeapon}),
                "This could come in handy.",
                Conversion("No", {}, {}),
                "I have plenty of weapons already.",
                GetAbondonnedCastleScene3, nil)
end

function GetAbondonnedCastleScene2_outside1()
    return Scene(Sprites.CharacterFrameForest,
                "As you start making up camp you see light from another campfire ahead.",
                "Go take a look?",
                Conversion("Yes", {}, {}),
                "At the campfire is an young travelling merchant.\n\"Good evening, please join my fire if you wish.\"",
                Conversion("No", {}, {}),
                "Let's not bother them.",
                GetAbondonnedCastleScene2_outside2, GetAbondonnedCastleScene3)
end

function GetAbondonnedCastleScene2_outside2()
    return Scene(Sprites.CharacterFrameForest,
                "The merchant warns you of walking dead in the castle. He advises to scare them with mushrooms.",
                "Would you like to sell anything?",
                Conversion("Sell\nany item", {AllItemTypes}, {NewGoldItem}),
                "What a kind person!",
                Conversion("No", {}, {}),
                "What a kind person!",
                GetAbondonnedCastleScene3, nil)
end

function GetAbondonnedCastleScene3()
    return Scene(Sprites.CharacterFrameCave,
                "In the morning you walk through the castle looking for an exit when suddenly a walking skeleton attacks you!",
                "",
                Conversion("Fight him!", {ItemTypes.weapon, ItemTypes.mushroom}, {NewBoneItem}),
                "Phew, that was close.",
                Conversion("Surrender", {}, {}),
                "I hope skeletons have mercy...",
                GetAbondonnedCastleScene4, GetDeathScene)
end

function GetAbondonnedCastleScene4()
    return Scene(Sprites.CharacterFrameCave,
                "You continue through the castle, afraid of sekeletons at every corner. Luckily none appear.",
                "",
                Conversion("Leave", {}, {}),
                "You happily leave the castle behind you.",
                nil,
                "",
                _afterAbondonnedCastleScene, nil)
end