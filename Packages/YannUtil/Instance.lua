Instance = Class{
    init = function(self)
        InstanceManager.declare(self)
    end,

    update = function(self, dt)
    end,

    draw = function(self)
    end,

    drawUI = function(self)
    end,

    mousereleased = function(self, x, y, button, istouch, presses)
    end,

    mousepressed = function(self, x, y, button, istouch, presses)
    end,

    destroy = function(self)
        InstanceManager.remove(self)
        self=nil
    end,
}
