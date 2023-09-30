
Scene = Class{
    init = function(self, conversion1, conversion2, followupScene1, followupScene2)
        self.conversion1 = conversion1
        self.conversion2 = conversion2

        self.followupScene1 = followupScene1
        self.followupScene2 = followupScene2
    end,
}



function GetInitialScene()
    local scene2 = Scene(WeaponToGoldConversion(), GoldToWeaponConversion(), nil, nil)
    local scene1 = Scene(GainGoldConversion(), GainSwordConversion(), scene2, scene2)
    return scene1
end



