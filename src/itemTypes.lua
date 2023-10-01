
ItemTypes = {weapon="Weapon", money="Money", food="Food", treasure="Treasure", mushroom="Mushroom", potion="Potion", gem="Gem"}

AllItemTypes = {ItemTypes.weapon, ItemTypes.money, ItemTypes.food, ItemTypes.treasure}

function ItemTypeToColor(type)
    if not type then
        return Colors.white
    end

    if type == ItemTypes.weapon then
        return Colors.hexToRGB("#79444A")
    end
    if type == ItemTypes.money then
        --return Colors.hexToRGB("#BA9158")
        return Colors.hexToRGB("#6C5226")
    end
    if type == ItemTypes.food then
        --return Colors.hexToRGB("#4D4539")
        return Colors.hexToRGB("#77743B")
    end
    if type == ItemTypes.treasure then
        return Colors.hexToRGB("#4B726E")
    end
    return Colors.hexToRGB("#4B3D44")
end