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

    destroy = function(self)
        InstanceManager.remove(self)
        self=nil
    end,
}
