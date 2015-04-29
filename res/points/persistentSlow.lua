persSlowFood = {}

function persSlowFood.init ()
    
end

function persSlowFood.begin ()
    persSlowFood.me.worth = -45
    persSlowFood.color = {0xAB, 0x47, 0xBC, 255}
    persSlowFood.bcolor = persSlowFood.color
end

function persSlowFood.ate ()
    persSlowFood.game:addPoints (persSlowFood.me.worth)
    persSlowFood.game.map:removeFood (persSlowFood.me)
    persSlowFood.game:removeFood (persSlowFood.me)
end

return persSlowFood