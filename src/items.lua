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

NewHugeGemItem = function(position, pickupManager, grid, itemStorage)
    local name = "Huge Gem"
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.treasure}
    item = Item(name, position, Sprites["1x1itemsGem"], Sprites["1x1itemsTreasure"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end





-- Food

NewWeirdMushroomItem = function(position, pickupManager, grid, itemStorage)
    local name = "Edible(?) Mushroom"
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.food}
    item = Item(name, position, Sprites["1x1itemsMushroom"], Sprites["1x1itemsFood"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
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