speedUp = {}

function speedUp.init ()
    speedUp.speedModifier = 20
    speedUp.me.worth = 50
    speedUp.color = {0x03, 0xA9, 0xF4, 255} -- light blue 500
    speedUp.bcolor = speedUp.color
    
    speedUp.tdt = 0
end

function speedUp.ate (snake)
    snake.baseSpeedPoints = snake.baseSpeedPoints + speedUp.speedModifier
    speedUp.game:addPoints (speedUp.me.worth)
    speedUp.game.map:removeFood (speedUp.me)
    speedUp.game:removeFood (speedUp.me)
end

function speedUp.update (dt)
    speedUp.tdt = speedUp.tdt + dt
    
    speedUp.color[4] = 135 + (120 * math.sin (dt))
end

return speedUp