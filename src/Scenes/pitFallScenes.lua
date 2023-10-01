
function GetPitfallInitialScene()
    return PitfallScene1()
end


NewPitItem = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewRingItem, NewNecklaceItem})
    return fn(position, pickupManager, grid, itemStorage)
end

function PitfallScene1() 
    return Scene(Sprites.CharacterFrameForest,
                "There seems to be something shiny poking out of the ground.",
                "Will you investigate?",
                Conversion("Yes", {}, {NewPitItem}),
                "Oh nice, very pretty! Wait, what is that sound ...?",
                Conversion("No", {}, {}),
                "I wonder what that was?",
                PitfallScene2, _afterPitfallScene,
                gainItemSound, nil)
end

function PitfallScene2()
    return Scene(Sprites.CharacterFrameCave,
                "The ground collapses! You fall into a pithole!",
                "Lose one of your items",
                Conversion("Any item", AllItemTypes, {}),
                "That was painful. The pit is too high to climb back up. This cave seems to be the only way.",
                Conversion("Nothing\nto lose", {}, {}, function() return not BagHasItems() end),
                "You had nothing to lose.",
                PitfallScene3, nil,
                nil, nil)
end

function PitfallScene3()
    return Scene(Sprites.CharacterFrameCave,
                "After walking for a while in this dark tunnel you start to get very hungry.",
                "Eat something",
                Conversion("Some food", {ItemTypes.food}, {}),
                "Delicious! With renewed energy you continue through the cave.",
                Conversion("Eat nothing", {}, {}),
                "You keep getting more and more hungry, but cannot find a way out...",
                PitfallScene4, GetDeathScene,
                nil, nil)
end

function PitfallScene4()
    return Scene(Sprites.CharacterFrameCave,
                "After walking for a bit more you enter a beautiful carved room, with a huge gem on a pedestal in the middle of it.",
                "",
                Conversion("Take it", {}, {NewGreenGemItem}),
                "It' so pretty!",
                Conversion("Leave it", {}, {}),
                "That seems risky. Let's not.",
                ExitPitfallScene, nil,
                superGainItemSound, nil)
end

function ExitPitfallScene()
    return Scene(Sprites.CharacterFrameForest,
                "You safely make it out of the cave.",
                "Let's continue!",
                Conversion("Go!", {}, {}),
                "Nice to be out in the sun again.",
                nil,
                "",
                _afterPitfallScene, nil,
                nil, nil)
end
