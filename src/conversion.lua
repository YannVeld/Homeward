require("src/itemTypes")
require("src/items")

Conversion = Class{
    init = function(self, description, inTypes, outItems, condition)
        self.description = description
        self.inTypes = inTypes
        self.outItems = outItems
        self.condition = condition or (function() return true end)
    end,
}
