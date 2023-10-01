require("src.itemTypes")


-- Weapons

NewSwordItem = function(position, pickupManager, grid, itemStorage)
    local name = "Sword"
    local value = 2
    local shape = {{0,0},{0,1},{0,2}}
    local basecell = 2
    local types = {ItemTypes.weapon}
    item = Item(name, value, position, Sprites["1x3itemsSword"], Sprites["1x3itemsWeapons"], Sprites["1x3itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewSmallKnifeItem = function(position, pickupManager, grid, itemStorage)
    local name = "Small knife"
    local value = 1
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.weapon}
    item = Item(name, value, position, Sprites["1x1itemsKnife"], Sprites["1x1itemsWeapons"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewKnifeItem = function(position, pickupManager, grid, itemStorage)
    local name = "Knife"
    local value = 1
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.weapon}
    item = Item(name, value, position, Sprites["1x2itemsKnife"], Sprites["1x2itemsWeapons"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewShieldItem = function(position, pickupManager, grid, itemStorage)
    local name = "Shield"
    local value = 3
    local shape = {{0,0},{0,1},{1,0},{1,1}}
    local basecell = 1
    local types = {ItemTypes.weapon}
    item = Item(name, value, position, Sprites["2x2itemsShield"], Sprites["2x2itemsWeapons"], Sprites["2x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewRandomWeapon = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewSwordItem, NewKnifeItem, NewShieldItem, NewSmallKnifeItem})
    return fn(position, pickupManager, grid, itemStorage)
end




-- Gold

NewGoldItem = function(position, pickupManager, grid, itemStorage)
    local name = "Gold"
    local value = 5
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.money}
    item = Item(name, value, position, Sprites["1x1itemsPouch"], Sprites["1x1itemsMoney"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end



-- Treasure

NewRingItem = function(position, pickupManager, grid, itemStorage)
    local name = "Ring"
    local value = 8
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, value, position, Sprites["1x1itemsRing"], Sprites["1x1itemsTreasure"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewNecklaceItem = function(position, pickupManager, grid, itemStorage)
    local name = "Necklace"
    local value = 20
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, value, position, Sprites["1x2itemsNecklace"], Sprites["1x2itemsTreasure"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewRedGemItem = function(position, pickupManager, grid, itemStorage)
    local name = "Red Gem"
    local value = 15
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, value, position, Sprites["1x1itemsGemRed"], Sprites["1x1itemsTreasure"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewGreenGemItem = function(position, pickupManager, grid, itemStorage)
    local name = "Green Gem"
    local value = 40
    local shape = {{0,0}, {0,1}, {1,0}, {1,1}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, value, position, Sprites["2x2itemsGemGreen"], Sprites["2x2itemsTreasure"], Sprites["2x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewRandomGem = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewRedGemItem, NewGreenGemItem})
    return fn(position, pickupManager, grid, itemStorage)
end

NewBoneItem = function(position, pickupManager, grid, itemStorage)
    local name = "Bone"
    local value = 5
    local shape = {{0,0}, {1,0}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, value, position, Sprites["2x1itemsBone"], Sprites["2x1itemsTreasure"], Sprites["2x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end


-- Food

NewSmallMushroomItem = function(position, pickupManager, grid, itemStorage)
    local name = "Mushroom"
    local value = 1
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.food, ItemTypes.mushroom}
    item = Item(name, value, position, Sprites["1x1itemsMushroom"], Sprites["1x1itemsFood"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewMushroomItem = function(position, pickupManager, grid, itemStorage)
    local name = "Mushroom"
    local value = 2
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.food, ItemTypes.mushroom}
    item = Item(name, value, position, Sprites["1x2itemsMushroom"], Sprites["1x2itemsFood"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewRandomMushroomItem = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewMushroomItem, NewMushroomItem, NewSmallMushroomItem})
    return fn(position, pickupManager, grid, itemStorage)
end

NewFruitItem = function(position, pickupManager, grid, itemStorage)
    local name = "Fruit"
    local value = 1
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, value, position, Sprites["1x1itemsFruit"], Sprites["1x1itemsFood"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewCakeItem = function(position, pickupManager, grid, itemStorage)
    local name = "A cake"
    local value = 15
    local shape = {{0,0}, {1,0}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, value, position, Sprites["2x1itemsCake"], Sprites["2x1itemsFood"], Sprites["2x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewBreadItem = function(position, pickupManager, grid, itemStorage)
    local name = "Bread"
    local value = 10
    local shape = {{0,0}, {1,0}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, value, position, Sprites["2x1itemsBread"], Sprites["2x1itemsFood"], Sprites["2x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewPotionRedItem = function(position, pickupManager, grid, itemStorage)
    local name = "Red Potion"
    local value = 25
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, value, position, Sprites["1x2itemsPotionRed"], Sprites["1x2itemsFood"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewPotionBlueItem = function(position, pickupManager, grid, itemStorage)
    local name = "Blue Potion"
    local value = 25
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, value, position, Sprites["1x2itemsPotionBlue"], Sprites["1x2itemsFood"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewPotionGreenItem = function(position, pickupManager, grid, itemStorage)
    local name = "Green Potion"
    local value = 25
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, value, position, Sprites["1x2itemsPotionGreen"], Sprites["1x2itemsFood"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewRandomPotion = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewPotionRedItem, NewPotionBlueItem, NewPotionGreenItem})
    return fn(position, pickupManager, grid, itemStorage)
end
