
function GetBanditAttackInitialScene()
    return GetBanditAttackScene1()
end


function GetBanditAttackScene1()
    return Scene(Sprites.CharacterFrameForest,
                "You hear some screaming in the distance.",
                "Go to investigate?",
                Conversion("Yes", {}, {N}),
                "Duty calls",
                Conversion("No", {}, {}),
                "Better be safe than sorry.",
                GetBanditAttackScene2, _afterBanditAttackScene,
                nil, nil)
end

function GetBanditAttackScene2()
    return Scene(Sprites.CharacterFrameForest,
                "There is a group of bandits attacking a carriage. Now they are coming for you!",
                "You will have to fight.",
                Conversion("Draw a weapon", {ItemTypes.weapon}, {NewRandomGold}),
                "Take that bandits!",
                Conversion("Bare handed", {}, {}),
                "That did not go so well ...",
                GetBanditAttackScene3_win,
                GetBanditAttackScene3_loss,
                gainItemSound, nil)
end

function GetBanditAttackScene3_win()
    return Scene(Sprites.CharacterFrameForest,
                "The merchants in the carriage are very gratefull.",
                "\"Please take this\"",
                Conversion("Take item", {}, {NewCakeItem}),
                "You both go your own ways.",
                Conversion("Don't take item", {}, {}),
                nil,
                _afterBanditAttackScene, nil,
                gainItemSound, nil)
end

function GetBanditAttackScene3_loss()
    return Scene(Sprites.CharacterFrameForest,
                "Luckily all they take is valuables. No lives.",
                "Lose some valueable item:",
                Conversion("Lose item", {ItemTypes.money, ItemTypes.treasure}, {}),
                "That was scary.",
                Conversion("Nothing", {}, {}, function() return not BagHasType(ItemTypes.money) end),
                "You had nothing of interest to give them.",
                _afterBanditAttackScene, nil,
                nil, nil)
end