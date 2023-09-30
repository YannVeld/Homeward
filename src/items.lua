require("src/itemTypes")

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

NewGoldItem = function(position, pickupManager, grid, itemStorage)
    local name = "Gold"
    local shape = {{0,0}}
    local basecell = 1
    local types = {ItemTypes.money}
    item = Item(name, position, Sprites["1x1itemsGold"], Sprites["1x1itemsMoney"], Sprites["1x1itemsHighlight"], shape, basecell, types, pickupManager, grid, itemStorage)
    return item
end