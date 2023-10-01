
function GetBeginningInitialScene()
    return GetBeginningScene1()
end


function GetBeginningScene1()
    return Scene(nil,
                "",
                "",
                nil,
                "Our story begins in the small town of Hazelwood, where you are busy packing the final things for your journey.\nIt is going to be a long one, so you should be well prepared!",
                nil,
                "",
                GetBeginningScene2, nil,
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
                GetBeginningScene3, nil)
end

function GetBeginningScene3()
    return Scene(nil,
                "Some money could also be useful.",
                "",
                Conversion("Gold!", {}, {NewGoldItem}),
                "I guess that is it. Let's depart on a journey!",
                nil,
                nil,
                GetBeginningScene4, nil)
end

function GetBeginningScene4()
    return Scene(nil,
                "As you walk through town your nose picks up the smells from the backery. Might be nice to but some bread?\nMove an item from your bag onto an option below to use it.",
                "",
                Conversion("Buy bread\nSpend money", {ItemTypes.money}, {NewBreadItem}),
                "Delicious!",
                Conversion("Don't buy\nbread", {}, {}),
                "Better save the money.",
                GetBeginningScene5, nil)
end

NewOldLadyItem = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewSwordItem, NewRandomPotion, NewRingItem, NewGoldItem, NewRedGemItem})
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
                GetBeginningScene6, nil)
end

function GetBeginningScene6()
    return Scene(nil,
                "",
                "",
                nil,
                "At long last you can begin your journey! You set off into the forest.",
                nil,
                "",
                _afterBeginningScene, nil)
end