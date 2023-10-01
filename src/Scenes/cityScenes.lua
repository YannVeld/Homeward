

function GetCityInitialScene()
    return GetCityScene1()
end

function GetCityScene1()
    return Scene(nil,
                "You arrived at the trading city of Goldstream. This is about halfway through your journey! Would you like to walk through the market before finding a place to stay the night?",
                "Go to the market?",
                Conversion("Yes", {}, {}),
                "You make your way to the commercial district.",
                Conversion("No", {}, {}),
                "You start looking for a place to stay.",
                GetCityScene_market1, GetCityScene_tavern1)
end

function GetCityScene_market1()
    return Scene(nil,
                "The first stop is a smithy.",
                "\"What can I do for you?\"",
                Conversion("Buy weapon", {ItemTypes.money}, {NewRandomWeapon}),
                "\"Thank you your purchase!\"",
                Conversion("Nothing", {}, {}),
                "You continue to the next shop.",
                GetCityScene_market2, nil)
end

function GetCityScene_market2()
    return Scene(nil,
                "Next you find a jeweller.\n\"Good day to you! If you give me a gem I can make jewellery for you?\"",
                "Do you want to make jewellery?",
                Conversion("Give a gem", {ItemTypes.gem}, {NewNecklaceItem}),
                "\"Happy doing business with you!\"",
                Conversion("No", {}, {}),
                "\"Very well.\"",
                GetCityScene_market3, nil)
end

function GetCityScene_market3()
    return Scene(nil,
                "\"Do you have something else you want ask me about?\"",
                "Do you?",
                Conversion("No", {}, {}),
                "\"Have a nice day!\"\nYou walk to the next shop.",
                Conversion("Big gem?", {}, {}, function() return BagHasType(ItemTypes.bigGem) end),
                "\"Oh, what a beautiful gem! This is!\"",
                GetCityScene_tavern1, GetCityScene_market4)
end

function GetCityScene_market4()
    return Scene(nil,
                "\"Are you interested in selling this gem? I will pay you handsomly.\"",
                "Sell the gem?",
                Conversion("Yes", {ItemTypes.bigGem}, {NewGoldItem}),
                "\"Oh, marvellous! Here is one gold pouch.\"",
                Conversion("No", {}, {}),
                "The jeweller\'s eyes follow the gem longingly as you walk out of the shop.",
                GetCityScene_market5, GetCityScene_tavern1)
end

function _putGoldInStorage()
    local gold = NewGoldItem(itemStorage.position, pickupManager, myGrid, itemStorage)
    itemStorage:putInStorage(gold)
end

function GetCityScene_market5()
    return Scene(nil,
                "",
                "",
                nil,
                "\"And the second one.\"",
                nil,
                nil,
                GetCityScene_market6, nil,
                function() _putGoldInStorage() end)
end

function GetCityScene_market6()
    return Scene(nil,
                "",
                "",
                nil,
                "\"And the final one. Happy doing business with you!\"\nYou walk out of the store.",
                nil,
                nil,
                GetCityScene_tavern1, nil,
                function() _putGoldInStorage() end)
end

function GetCityScene_tavern1()
    return Scene(nil,
                "You find a tavern that looks nice. Apparently they have rooms for 1 gold a night. You could stay at the tavern or sleep outside.",
                "Where will you stay?",
                Conversion("In the tavern", {ItemTypes.money}, {}),
                "You have a calm night at the tavern.",
                Conversion("Outside", {}, {}),
                "You find a nice sheltered corner and fall asleep under the stars.",
                GetCityScene_leaving, GetCityScene_outside1)
end

function GetCityScene_outside1()
    return Scene(nil,
                "You are rudely awoken by a figure holding a knife to your throat.\n\"Give me your gold\", they hiss.",
                "Give them gold?",
                Conversion("Yes", {ItemTypes.money, ItemTypes.treasure}, {}),
                "\"Wise choice friend\", they say as they slip away into the night. You have an uncomfortable rest of the night.",
                Conversion("No", {}, {}),
                "You refuse and try to break free from the knife at your throat.",
                GetCityScene_leaving, GetCityScene_outside2)
end
function GetCityScene_outside2()
    return Scene(nil,
                "You break away and a fight breaks out.",
                "Fight the thief.",
                Conversion("With a weapon", {ItemTypes.weapon}, {}),
                "In the struggle you cut down the thief. Now that you have a better look they seem very poor. They also have nothing of value.",
                Conversion("Empty handed", {}, {}),
                "There is a struggle and you feel the knife cut you in your chest. Slowly your consciousness starts to fade...",
                GetCityScene_leaving, GetDeathScene)
end

function GetCityScene_leaving()
    return Scene(nil,
                "",            
                "",            
                nil,
                "Early in the morning you head out again, into the second leg of your journey.",
                nil,
                nil,
                _afterCityScene, nil)
end
