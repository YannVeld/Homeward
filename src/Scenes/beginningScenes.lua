
function GetBeginningInitialScene()
    return GetBeginningScene1()
end


function GetBeginningScene1()
    return Scene(nil,
                "",
                "",
                nil,
                "Our story begins in the small town of Hazelwood, where you are busy packing the final things for your journey home.\nIt is going to be a long one, so you should be well prepared!",
                nil,
                "",
                GetBeginningScene2, nil,
                nil, nil,
                nil,
                function() ClearTheBag() end)
end

function GetBeginningScene2()
    return Scene(nil,
                "Unfortunately you have to choose what to bring, since you only have limited space in your backpack...",
                "Bring a sword or a knife?",
                Conversion("Sword", {}, {NewSwordItem}),
                "A sword it is!\nClick and drag the sword to your backpack on the right.",
                Conversion("Knife", {}, {NewKnifeItem}),
                "A knife it is!\nClick and drag the knife to your backpack on the right.",
                GetBeginningScene3, nil,
                gainItemSound, gainItemSound)
end

function _putGoldInStorage()
    local gold = NewRandomGold(itemStorage.position, pickupManager, myGrid, itemStorage)
    itemStorage:putInStorage(gold)
end

function GetBeginningScene3()
    return Scene(nil,
                "",
                "",
                nil,
                "You should also bring a bit of money.",
                nil,
                nil,
                GetBeginningScene3_2, nil,
                nil, nil,
                gainItemSound,
                function() _putGoldInStorage() end)
end

function _putFoodInStorage()
    local food = NewRandomHomeFoodItem(itemStorage.position, pickupManager, myGrid, itemStorage)
    itemStorage:putInStorage(food)
end

function GetBeginningScene3_2()
    return Scene(nil,
                "",
                "",
                nil,
                "And a bit of food. That is it. Let's depart on the journey home!",
                nil,
                nil,
                GetBeginningScene4, nil,
                nil, nil,
                gainItemSound,
                function() _putFoodInStorage() end)
end

function GetBeginningScene4()
    return Scene(nil,
                "As you walk through town your nose picks up the smells from the backery. Might be nice to but some bread?\n\nMove an item from your bag onto an option below to use it.",
                "",
                Conversion("Buy bread", {ItemTypes.money}, {NewBreadItem}),
                "Delicious!",
                Conversion("Don't buy\nbread", {}, {}),
                "Better save the money.",
                GetBeginningScene5, nil,
                gainItemSound, nil)
end

NewOldLadyItem = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewRandomWeapon, NewRandomPotion, NewRingItem, NewRandomGold, NewRedGemItem, NewFruitItem})
    return fn(position, pickupManager, grid, itemStorage)
end

function GetBeginningScene5()
    return Scene(nil,
                "An old lady approaches you on the street.\n\"I hear you are going on a journey? Very good, take this.\"",
                "Accept the item?",
                Conversion("Yes", {}, {NewOldLadyItem}),
                "That was weird, but thanks I guess?",
                Conversion("No", {}, {}),
                "She walks off annoyed mumbling to herself.",
                GetBeginningScene6, nil,
                gainItemSound, nil)
end

function GetBeginningScene6()
    return Scene(nil,
                "",
                "",
                nil,
                "At long last you can begin your journey! You set off into the forest.",
                nil,
                "",
                _afterBeginningScene, nil,
                nil, nil)
end