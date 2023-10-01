
function GetPitfallInitialScene()
    return PitfallScene1()
end

function _afterPitfallScene()
    return GetBanditAttackInitialScene()
end

function PitfallScene1() 
    return Scene(Sprites.CharacterFrameForest,
                "There seems to be something shiny poking out of the ground.",
                "Will you investigate?",
                Conversion("Yes", {}, {NewRingItem}),
                "Oh nice, a ring! Wait, what is that sound ...?",
                Conversion("No", {}, {}),
                "I wonder what that was?",
                PitfallScene2, _afterPitfallScene)
end

function PitfallScene2()
    return Scene(Sprites.CharacterFrameCave,
                "The ground collapses! You fall into a pithole!",
                "Lose one of your items",
                Conversion("Any item", AllItemTypes, {}),
                "That was painful. The pit is too high to climb back up. This cave seems to be the only way.",
                nil,
                "",
                PitfallScene3, nil)
end

function PitfallScene3()
    return Scene(Sprites.CharacterFrameCave,
                "After walking for a while in this dark tunnel you start to get very hungry.",
                "Eat something",
                Conversion("Some food", {ItemTypes.food}, {}),
                "Delicious! Let's explore this cave a bit more.",
                Conversion("Eat nothing", {}, {}),
                "Your belly complains loudly as you continue. Luckily there seems to be an exit up ahead.",
                PitfallScene4,
                ExitPitfallScene)
end

function PitfallScene4()
    return Scene(Sprites.CharacterFrameCave,
                "After walking for a bit more you enter a beautiful carved room, with a huge gem on a pedestal in the middle of it.",
                "",
                Conversion("Take it", {}, {NewGreenGemItem}),
                "It' so pretty!",
                Conversion("Leave it", {}, {}),
                "That seems risky. Let's not.",
                ExitPitfallScene, nil)
end

function ExitPitfallScene()
    return Scene(Sprites.CharacterFrameForest,
                "You safely make it out of the cave.",
                "Let's continue!",
                Conversion("Go!", {}, {}),
                "Nice to be out in the sun again.",
                nil,
                "",
                _afterPitfallScene, nil)
end
