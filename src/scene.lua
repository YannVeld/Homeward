
Scene = Class{
    init = function(self, story, question, afterstory, conversion1, conversion2, followupScene1, followupScene2)
        self.story = story
        self.question = question
        self.afterstory = afterstory

        self.conversion1 = conversion1
        self.conversion2 = conversion2

        self.followupScene1 = followupScene1
        self.followupScene2 = followupScene2
    end,
}



function GetInitialScene()
    local scene2 = Scene("Scene1", "What to do?", "Was it a good choice?", WeaponToGoldConversion(), GoldToWeaponConversion(), nil, nil)
    local scene1 = Scene("Welcome!", "Choose one of these ones please.", "Nice!", GainGoldConversion(), GainSwordConversion(), scene2, scene2)
    return scene1
end



