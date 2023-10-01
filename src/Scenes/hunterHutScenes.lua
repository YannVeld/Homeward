

function GetHuntersHutInitialScene()
    return GetHuntersHutScene1()
end

function GetHuntersHutScene1()
    return Scene(Sprites.CharacterFrameForest,
                "You happen upon a clearing with a small cottage. It seems cozy.",
                "Knock on the door?",
                Conversion("Yes", {}, {}),
                "The door is opened by a big bulky man with an axe on his shoulder. Next to him is a big hound",
                Conversion("No", {}, {}),
                "Could be anyone living there.",
                GetHuntersHutScene2, _afterHuntersHutScene,
                nil, nil)
end

function GetHuntersHutScene2()
    return Scene(Sprites.CharacterFrameForest,
                "\"What do you want?\", he asks. His hound growls menacingly.",
                "",
                Conversion("Uh...", {}, {}),
                "\"Get out then!\"",
                Conversion("Bone for the hound", {ItemTypes.bone}, {NewMeatItem}, function() return BagHasType(ItemTypes.bone) end),
                "The hound happily accepts the bone and starts chewing on it.\n\"Uhm, thanks, I guess. Here have this. It's freshly caught.\"",
                _afterHuntersHutScene, nil,
                superGainItemSound, nil)
end
