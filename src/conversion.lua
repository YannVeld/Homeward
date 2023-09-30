require("src/itemTypes")
require("src/items")

Conversion = Class{
    init = function(self, description, inTypes, outItems)
        self.description = description
        self.inTypes = inTypes
        self.outItems = outItems
    end,
}
