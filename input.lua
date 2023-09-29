function GetInputs()
    return Baton.new {
        controls = {
            up_pl1 = {'key:w'},
            down_pl1 = {'key:s'},
            up_pl2 = {'key:up'},
            down_pl2 = {'key:down'},
        },
        pairs = {
            move_pl1 = {'up_pl1', 'down_pl1', 'up_pl1', 'down_pl1'},
            move_pl2 = {'up_pl2', 'down_pl2', 'up_pl2', 'down_pl2'},
        },
    }
end