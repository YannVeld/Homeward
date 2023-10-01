

function GetEndingInitialScene()
    return GetEndingScene1()
end

function GetEndingScene1()
    return Scene(Sprites.CharacterFrameForest,
                "",
                "",
                nil,
                "As you continue everything around you starts to become more familiar. You just need to cross the river and you are basically there!",
                nil,
                "",
                GetEndingScene2, nil,
                nil, nil)
end

function GetEndingScene2()
    return Scene(Sprites.CharacterFrameForest,
                "An imposing guy in heavy armor stops you at the bridge.\n\"Pay the toll please.\"\nWhat toll? There was never any toll.",
                "What to do?",
                Conversion("Refuse", {}, {}),
                "With an evil smile the guy says,\n\"perhaps there was no toll before, but there is one now.\"",
                Conversion("Pay", {ItemTypes.money}, {}),
                "\"Please continue.\"",
                GetEndingScene3_1, ReturnHomeScene,
                nil, nil)
end

function GetEndingScene3_1()
    return Scene(Sprites.CharacterFrameForest,
                "This armored guy is not going to move. You consider your options.",
                "Attack with a weapon?",
                Conversion("Yes", {ItemTypes.weapon}, {}),
                "This guy was not so tough after all. He surrendered as soon as you drew a weapon.",
                Conversion("No", {}, {}),
                "That seems like a bad idea. This guy seems tough.",
                ReturnHomeScene, GetEndingScene3_2,
                nil, nil)
end

function GetEndingScene3_2()
    return Scene(Sprites.CharacterFrameForest,
                "If you have a potion of waterbreathing you could swim across the river.",
                "Drink potion?",
                Conversion("Yes", {ItemTypes.potion}, {}),
                "That seemed to work!",
                Conversion("No", {}, {}),
                "Hmm, what to do.",
                ReturnHomeScene, GetEndingScene3_3,
                nil, nil)
end

function GetEndingScene3_3()
    return Scene(Sprites.CharacterFrameForest,
                "You could pay the toll anyway.",
                "Pay the toll?",
                Conversion("Yes", {ItemTypes.money}, {}),
                "\"Please continue.\", the guy says with a smile.",
                Conversion("No", {}, {}),
                "Hmm, what to do.",
                ReturnHomeScene, GetEndingScene3_4,
                nil, nil)
end

function GetEndingScene3_4()
    return Scene(Sprites.CharacterFrameForest,
                "If all else fails you could distract him and make a run for it.",
                "Make a run for it?",
                Conversion("Yes", {}, {}),
                "You distract the guy and sprint across the bridge. The guy has trouble keeping up in his heavy armor. You make it across without a problem.",
                Conversion("No", {}, {}),
                "That seems like a bad idea as well.",
                ReturnHomeScene, GetEndingScene3_1,
                nil, nil)
end


function ReturnHomeScene()
    return Scene(Sprites.CharacterFrameForest,
                "",
                "",
                nil,
                "You sigh of relief when you finally walk into the town of Woodsmoke. You are home once again.",
                nil,
                "",
                GetLastScene, nil,
                nil, nil)
end


function GetLastScene()
    return Scene(Sprites.CharacterFrameForest,
                "Thank you for playing!\nThe total value of all items in your bag is: \n  "..GetTotalBagValue().."\n\nCan you get more on a second playthrough?",
                "",
                Conversion("Restart", {}, {}),
                "Good luck!",
                Conversion("Quit", {}, {}),
                "Thanks again for playing!",
                GetInitialScene, QuitGameScene,
                nil, nil,
                winSound)
end