

NewSwordItem = function(position, pickupManager, grid)
    local shape = {{0,0},{0,1},{0,2}}
    local basecell = 2
    item = Item(position, Sprites["1x3itemsSword"], Sprites["1x3itemsWeapons"], Sprites["1x3itemsHighlight"], shape, basecell, pickupManager, grid)
    return item
end

NewKnifeItem = function(position, pickupManager, grid)
    local shape = {{0,0}}
    local basecell = 1
    item = Item(position, Sprites["1x1itemsKnife"], Sprites["1x1itemsWeapons"], Sprites["1x1itemsHighlight"], shape, basecell, pickupManager, grid)
    return item
end