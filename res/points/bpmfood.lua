bpmFood = {}

function bpmFood.init ()
    bpmFood.cdt = 0
    
    bpmFood.iwaseaten = false
    
    bpmFood.color = {0xFF, 0xCD, 0xD2, 255} -- RED 100
    bpmFood.bcolor = bpmFood.color
end

function bpmFood.begin ()
    -- food.songbmp exists
    bpmFood.bps = bpmFood.songbpm / 60
    bpmFood.beatsnum = 8
    bpmFood.secondsTillBeat = bpmFood.beatsnum / bpmFood.bps
    
    bpmFood.me.worth = 15
end

function bpmFood.ate (snake)
    bpmFood.game:addPoints (bpmFood.me.worth)
    bpmFood.iwaseaten = true
    bpmFood.game.map:removeFood (bpmFood.me)
    
    bpmFood.draw = function ()
        -- do nothing so won't draw for a moment
    end
end

function bpmFood.update (dt)
    bpmFood.cdt = bpmFood.cdt + dt
    
    if bpmFood.cdt > bpmFood.secondsTillBeat then
        if not bpmFood.iwaseaten then
            bpmFood.game.map:removeFood (bpmFood.me)
        end
        
        bpmFood.draw = nil
        
        bpmFood.me.x = -10
        bpmFood.me.y = -10
        bpmFood.game.map:addFood (bpmFood.me)
        
        bpmFood.cdt = 0
    end
    
    bpmFood.secondsTillBeat = bpmFood.beatsnum / bpmFood.bps
end

function bpmFood.kill ()
    if not bpmFood.iwaseaten then
        bpmFood.game.map:removeFood (bpmFood.me)
    end
    
    bpmFood.game:removeFood (bpmFood.me)
end

return bpmFood
