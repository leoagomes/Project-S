song = {}

song.meta = {
    ["name"] = "Heatstroke",
    ["performer"] = "DOCTOR VOX",
    ["composer"] = "DOCTOR VOX",
    ["file"] = "res/music/dubstep/2.ogg",
    ["presentString"] = "Heatstroke, by DOCTOR VOX"
}

song.props = {
    ["yeaMod"] = 45
}

function song.start ()
    --suppose the following has been set by the game:
    -- song.game = {}
    
    song.dtt = 0
    
    song.indx = 1
    song.nt = song.functions[song.indx].time
    
    song.food = {}
    
    song.baseSnakeSpeed = 45
    
    song.game.map:reloadMap ("res/maps/withBox.lua")
end

function song.update (dt)
    song.dtt = song.dtt + dt
    
    if song.dtt > song.nt then
        if (song.indx > #song.functions) then
            return
        end
        
        song.functions[song.indx].func ()
        song.indx = song.indx + 1
        
        if (song.indx > #song.functions) then
            return
        end
        
        song.nt = song.functions[song.indx].time
    end
    
    -- base changing snake speed
    song.game.snake.speed = song.baseSnakeSpeed + song.game.snake.baseSpeedPoints + (song.game.score / 3.5)
end

song.functions = {
    {
        time = 0.0,
        func = function ()
            song.normalFood = Food:new ("normal", song.game)
            song.game.map:addFood (song.normalFood)
        end
    },
    {
        time = 19.227,
        func = function ()
            song.bpmFood = Food:new ("res/points/bpmfood.lua", song.game)
            song.bpmFood.food.songbpm = 100
            song.bpmFood.food.begin ()
            song.game.map:addFood (song.bpmFood)
        end
    },
    {
        time = 48.012,
        func = function ()
            song.game:doHugeText ("yeeeaah :)", 0.7)
            song.game.map:reloadMap ("res/maps/classic.lua")
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + song.props.yeaMod
        end
    },
    {
        time = 57.558,
        func = function ()
            song.game:doWarpPulse (20, 1, 0.67)
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints - 80
        end
    },
    {
        time = 58.230,
        func = function ()
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 70
        end
    },
    {
        time = 62.427,
        func = function ()
            song.game:doWarpPulse (20, 1, 0.47)
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints - 70
        end
    },
    {
        time = 63.0,
        func = function ()
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 70
        end
    },
    {
        time = 67.239,
        func = function ()
            song.game:doWarpPulse (20, 1, 0.58)
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints - 70
        end
    },
    {
        time = 67.800,
        func = function ()
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 70
        end
    },
    {
        time = 77.422,
        func = function ()
            -- save the colors they were before
            song.beforeColor = {
                ["t1c"] = song.game.map.typeOneColor,
                ["t2c"] = song.game.map.typeTwoColor,
                ["t3c"] = song.game.map.typeThreeColor,
                ["snake"] = song.game.snake.snakeColor,
                ["bpmFood"] = song.bpmFood.food.color,
                ["bpmFoodb"] = song.bpmFood.food.bcolor,
                ["scoreTime"] = song.game.scoreTimeColor
            }
            
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 77.970,
        func = function ()
            -- change them
            local currentColor = {0xFF, 0xF1, 0x76, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 78.622,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 79.250,
        func = function ()
            -- change them
            local currentColor = {0xBA, 0x68, 0xC8, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 82.234,
        func = function ()
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 82.853,
        func = function ()
            -- change them
            local currentColor = {0xFF, 0xF1, 0x76, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 83.409,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 84.028,
        func = function ()
            -- change them
            local currentColor = {0xCE, 0x93, 0xD8, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    
    {
        time = 87.048,
        func = function ()
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 87.700,
        func = function ()
            -- change them
            local currentColor = {0xFF, 0xF1, 0x76, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 88.264,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 88.882,
        func = function ()
            -- change them
            local currentColor = {0xBA, 0x68, 0xC8, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    
    {
        time = 91.877,
        func = function ()
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 92.461,
        func = function ()
            -- change them
            local currentColor = {0xFF, 0xF1, 0x76, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 93.046,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 93.640,
        func = function ()
            -- change them
            local currentColor = {0xCE, 0x93, 0xD8, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 94.294,
        func = function ()
            song.game.map.typeOneColor = song.beforeColor.t1c
            song.game.map.typeTwoColor = song.beforeColor.t2c
            song.game.map.typeThreeColor = song.beforeColor.t3c
            song.game.snake.snakeColor = song.beforeColor.snake
            song.game.scoreTimeColor = song.beforeColor.scoreTime
            
            song.normalFood.color = song.beforeColor.normalFood
            song.normalFood.bcolor = song.beforeColor.normalFoodb
            
            song.bpmFood.food.color = song.beforeColor.bpmFood
            song.bpmFood.food.bcolor = song.beforeColor.bpmFoodb
        end
    },
    {
        time = 135.484,
        func = function ()
            song.game.map:reloadMap ("res/maps/classic.portal.lua")
            song.game:doHugeText ("yeeeaah :)", 0.7)
            song.game.snake.snakeColor = {0x4F, 0xC3, 0xF7, 255}
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + song.props.yeaMod
        end
    },
    {
        time = 204.049,
        func = function ()
            song.game:doHugeText ("yeeeaah :)", 0.7)
            song.game.snake.snakeColor = {0xBA, 0x68, 0xC8, 255}
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + song.props.yeaMod
        end
    },
    {
        time = 211.749,
        func = function ()
            song.game:doHugeText ("Honestly", 0.5)
        end
    },
    {
        time = 212.936,
        func = function ()
            song.game:doHugeText ("That's", 0.476)
        end
    },
    {
        time = 213.757,
        func = function ()
            song.game:doHugeText ("Cool", 0.488)
        end
    },
    {
        time = 214.277,
        func = function ()
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 214.887,
        func = function ()
            -- change them
            local currentColor = {0xFF, 0xF1, 0x76, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 215.384,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 216.005,
        func = function ()
            -- change them
            local currentColor = {0xBA, 0x68, 0xC8, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 219.020,
        func = function ()
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 219.564,
        func = function ()
            -- change them
            local currentColor = {0xFF, 0xF1, 0x76, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 220.137,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 220.729,
        func = function ()
            -- change them
            local currentColor = {0xCE, 0x93, 0xD8, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    
    {
        time = 223.838,
        func = function ()
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 224.412,
        func = function ()
            -- change them
            local currentColor = {0xFF, 0xF1, 0x76, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time =  225.105,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 225.629,
        func = function ()
            -- change them
            local currentColor = {0xBA, 0x68, 0xC8, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    
    {
        time = 228.593,
        func = function ()
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 229.294,
        func = function ()
            -- change them
            local currentColor = {0xFF, 0xF1, 0x76, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 229.779,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 230.449,
        func = function ()
            -- change them
            local currentColor = {0xCE, 0x93, 0xD8, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
            
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 7
        end
    },
    {
        time = 231.201,
        func = function ()
            song.game.map.typeOneColor = song.beforeColor.t1c
            song.game.map.typeTwoColor = song.beforeColor.t2c
            song.game.map.typeThreeColor = song.beforeColor.t3c
            song.game.snake.snakeColor = song.beforeColor.snake
            song.game.scoreTimeColor = song.beforeColor.scoreTime
            
            song.normalFood.color = song.beforeColor.normalFood
            song.normalFood.bcolor = song.beforeColor.normalFoodb
            
            song.bpmFood.food.color = song.beforeColor.bpmFood
            song.bpmFood.food.bcolor = song.beforeColor.bpmFoodb
        end
    },
    {
        time = 250,
        func = function ()
            achievementSys:unlock ("heatstroken", true)
        end
    }, 
    {
        time = 255,
        func = function ()
            achievementSys:unlock ("bravePal", true)
        end
    }
}

return song
