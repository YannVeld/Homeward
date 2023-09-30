
function GetBanditAttackInitialScene()
    return GetBanditAttackScene1()
end

function _afterBanditAttackScene()
    return GetScene1()
end

function GetBanditAttackScene1()
    return Scene(nil,
                "You hear some screaming in the distance.",
                "Go to investigate?",
                Conversion("Yes", {}, {N}),
                "Duty calls",
                Conversion("No", {}, {}),
                "Better be safe than sorry.",
                GetBanditAttackScene2, _afterBanditAttackScene)
end

function GetBanditAttackScene2()
    return Scene(nil,
                "There is a group of bandits attacking a carriage. Now they are coming for you!",
                "You will have to fight.",
                Conversion("With a weapon", {ItemTypes.weapon}, {NewGoldItem}),
                "Take that bandits!",
                Conversion("Bare handed", {}, {}),
                "That did not go so well ...",
                GetBanditAttackScene3_win,
                GetBanditAttackScene3_loss)
end

function GetBanditAttackScene3_win()
    return Scene(nil,
                "The merchants in the carriage are very gratefull.",
                "\"Please take this\"",
                Conversion("Take item", {}, {NewCakeItem}),
                "You both go your own ways.",
                Conversion("Don't take item", {}, {}),
                nil,
                _afterBanditAttackScene, nil)
end

function GetBanditAttackScene3_loss()
    return Scene(nil,
                "Luckily all they take is some gold",
                "Lose gold",
                Conversion("Gold", {ItemTypes.money}, {}),
                "That was scary.",
                Conversion("Nothing", {}, {}, function() return not sceneManager:playerHasType(ItemTypes.money) end),
                "You had nothing of interest.",
                _afterBanditAttackScene, nil)
end