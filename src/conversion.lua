require("src/itemTypes")
require("src/items")

Conversion = Class{
    init = function(self, description, inTypes, outItems)
        self.description = description
        self.inTypes = inTypes
        self.outItems = outItems
    end,
}

NewWeaponToGoldConversion = function(self)
    return Conversion("Weapon\n->\nGold", {ItemTypes.weapon}, {NewGoldItem})
end

NewGoldToWeaponConversion = function(self)
    return Conversion("Gold\n->\nWeapon", {ItemTypes.money}, {NewKnifeItem})
end

GainSwordConversion = function(self)
    return Conversion("Gain Weapon", {}, {NewSwordItem})
end
GainGoldConversion = function(self)
    return Conversion("Gain Gold", {}, {NewGoldItem})
end