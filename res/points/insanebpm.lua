ibpm = {}

function ibpm.init ()
    ibpm.cdt = 0
    
    ibpm.color = {0xFF, 0xCD, 0xD2, 255} -- RED 100
    ibpm.bcolor = ibpm.color
end

function ibpm.begin ()
    -- food.songbmp exists
    ibpm.bps = ibpm.songbpm / 60
    ibpm.beatsnum = 8
    ibpm.secondsTillBeat = ibpm.beatsnum / ibpm.bps
    
    ibpm.me.worth = 15
end

function ibpm.ate (snake)
end

function ibpm.draw ()
end

function ibpm.update (dt)
    ibpm.cdt = ibpm.cdt + dt
    
    if ibpm.cdt > ibpm.secondsTillBeat then
        local nf = Food:new ("normal", ibpm.game)
        nf.color = ibpm.color
        nf.bcolor = ibpm.color
        nf.worth = ibpm.me.worth
        nf.ate = function (self, snake)
            self.game:addPoints (self.worth)
            self.game.map:removeFood (self)
            self.game:removeFood (self)
        end

        ibpm.game.map:addFood (nf)

        ibpm.cdt = 0
    end
    
    ibpm.secondsTillBeat = ibpm.beatsnum / ibpm.bps
end

function ibpm.kill ()
    if not ibpm.iwaseaten then
        ibpm.game.map:removeFood (ibpm.me)
    end
    
    ibpm.game:removeFood (ibpm.me)
end

return ibpm
