require("src.itemTypes")


-- Weapons

NewSwordItem = function(position, pickupManager, grid, itemStorage)
    local name = "Sword"
    local shape = {{0,0},{0,1},{0,2}}
    local basecell = 2
    local types = {ItemTypes.weapon}
    item = Item(name, position, Sprites["1x3itemsSword"], Sprites["1x3itemsWeapons"], Sprites["1x3itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewKnifeItem = function(position, pickupManager, grid, itemStorage)
    local name = "Knife"
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.weapon}
    item = Item(name, position, Sprites["1x1itemsKnife"], Sprites["1x1itemsWeapons"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewRandomWeapon = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewSwordItem, NewKnifeItem})
    return fn(position, pickupManager, grid, itemStorage)
end




-- Gold

NewGoldItem = function(position, pickupManager, grid, itemStorage)
    local name = "Gold"
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.money}
    item = Item(name, position, Sprites["1x1itemsGold"], Sprites["1x1itemsMoney"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end



-- Treasure

NewRingItem = function(position, pickupManager, grid, itemStorage)
    local name = "Ring"
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, position, Sprites["1x1itemsRing"], Sprites["1x1itemsTreasure"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end


NewRedGemItem = function(position, pickupManager, grid, itemStorage)
    local name = "Red Gem"
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, position, Sprites["1x1itemsGemRed"], Sprites["1x1itemsTreasure"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewGreenGemItem = function(position, pickupManager, grid, itemStorage)
    local name = "Green Gem"
    local shape = {{0,0}, {0,1}, {1,0}, {1,1}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, position, Sprites["2x2itemsGemGreen"], Sprites["2x2itemsTreasure"], Sprites["2x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewRandomGem = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewRedGemItem, NewGreenGemItem})
    return fn(position, pickupManager, grid, itemStorage)
end




-- Food

NewWeirdMushroomItem = function(position, pickupManager, grid, itemStorage)
    local name = "Mushroom"
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, position, Sprites["1x2itemsMushroom"], Sprites["1x2itemsFood"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewCakeItem = function(position, pickupManager, grid, itemStorage)
    local name = "A cake"
    local shape = {{0,0}, {1,0}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, position, Sprites["2x1itemsCake"], Sprites["2x1itemsFood"], Sprites["2x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewBreadItem = function(position, pickupManager, grid, itemStorage)
    local name = "Bread"
    local shape = {{0,0}, {1,0}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, position, Sprites["2x1itemsBread"], Sprites["2x1itemsFood"], Sprites["2x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewPotionRedItem = function(position, pickupManager, grid, itemStorage)
    local name = "Red Potion"
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, position, Sprites["1x2itemsPotionRed"], Sprites["1x2itemsFood"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewPotionBlueItem = function(position, pickupManager, grid, itemStorage)
    local name = "Blue Potion"
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, position, Sprites["1x2itemsPotionBlue"], Sprites["1x2itemsFood"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewPotionGreenItem = function(position, pickupManager, grid, itemStorage)
    local name = "Green Potion"
    local shape = {{0,0}, {0,1}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, position, Sprites["1x2itemsPotionGreen"], Sprites["1x2itemsFood"], Sprites["1x2itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end

NewRandomPotion = function(position, pickupManager, grid, itemStorage)
    local fn = Lume.randomchoice({NewPotionRedItem, NewPotionBlueItem, NewPotionGreenItem})
    return fn(position, pickupManager, grid, itemStorage)
end
