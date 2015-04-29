require "objects.food"
song = {}

song.meta = {
    ["name"] = "Sinking In",
    ["performer"] = "synx & ParanorMeow",
    ["composer"] = "synx & ParanorMeow",
    ["file"] = "res/music/dubstep/1.ogg",
    ["presentString"] = "Sinking In, by synx & ParanorMeow"
}

function song.start ()
    --suppose the following has been set by the game:
    -- song.game = {}
    
    song.dtt = 0
    
    song.indx = 1
    song.nt = song.functions[song.indx].time
    
    song.food = {}
    
    song.baseSnakeSpeed = 46
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
    song.game.snake.speed = song.baseSnakeSpeed + song.game.snake.baseSpeedPoints + (song.game.score / 1.8)
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
        time = 13.859,
        func = function ()
            song.food = Food:new ("res/points/bpmfood.lua", song.game)
            song.food.food.songbpm = 140
            song.food.food.begin ()
            song.game.map:addFood (song.food)
        end
    },
    {
        time = 28.328,
        func = function ()
            song.food.worth = 20
            song.food.food.color = {0xEF, 0x9A, 0x9A, 255}
            song.food.food.beatsnum = 2
            --song.food.food.cdt = song.food.food.secondsTillBeat
            song.food.food.update (0.01)
        end
    },
    {
        time = 34.40,
        func = function ()
            song.food.worth = 40
            song.food.food.color = {0xE5, 0x73, 0x73, 255}
            song.food.food.beatsnum = 1
            --song.food.food.cdt = song.food.food.secondsTillBeat
            song.food.food.update (0.01)
        end
    },
    {
        time = 37.785,
        func = function ()
            song.food.worth = 60
            song.food.food.color = {0xEF, 0x53, 0x50, 255}
            song.food.food.beatsnum = 0.5
            --song.food.food.cdt = song.food.food.secondsTillBeat
            song.food.food.update (0.01)
        end
    },
    {
        time = 40.320,
        func = function ()
            song.food.worth = 100
            song.food.food.color = {0xF4, 0x43, 0x36, 255}
            song.food.food.beatsnum = 8
            --song.food.food.cdt = song.food.food.secondsTillBeat
            song.food.food.update (0.01)
        end
    },
    {
        time = 41.178,
        func = function ()
            song.food:kill ()
            song.game.foods = {}
            song.game.map.foods = {}
            song.food.food = nil
            song.food = nil
            song.normalFood = nil
            
            song.game.map.drawTiles = false
            song.game.snake.stopped = true
            song.game.snake.disabled = true
        end
    },
    {
        time = 44.666,
        func = function ()
            song.game.map.drawTiles = true
            song.game.snake.stopped = false
            song.game.snake.disabled = false
            
            song.game:doWarpPulse (10, 6, 0.8)
            
            song.nF = Food:new ("normal", song.game)
            song.game.map:addFood (song.nF)
            
            song.bpmf = Food:new ("res/points/bpmfood.lua", song.game)
            song.bpmf.food.songbpm = 140
            song.bpmf.food.begin ()
            song.game.map:addFood (song.bpmf)
        end
    },
    {
        time = 48.100,
        func = function ()
            song.game:doWarpPulse (10, 6, 0.8)
        end
    },
    {
        time = 51.490,
        func = function ()
            song.game:doWarpPulse (10, 6, 0.8)
        end
    },
    {
        time = 55.023,
        func = function ()
            song.game:doWarpPulse (10, 6, 0.8)
        end
    },
    {
        time = 58.382,
        func = function ()
            song.game:doWarpPulse (10, 6, 0.8)
        end
    },
    {
        time = 61.880,
        func = function ()
            song.game:doWarpPulse (10, 6, 0.8)
        end
    },
    {
        time = 65.245,
        func = function ()
            song.game:doWarpPulse (10, 6, 0.8)
        end
    },
    {
        time = 68.666,
        func = function ()
            song.game:doWarpPulse (10, 6, 0.8)
        end
    },
    {
        time = 72.1,
        func = function ()
            song.bpmf.draw = function () end
            song.game.map:removeFood (song.bpmf)
        end
    },
    {
        time = 85.68,
        func = function ()
            song.bpmf.draw = nil
            -- song.game.map:addFood (song.bpmf)
        end
    },
    {
        time = 101.188,
        func = function ()
            song.game:doWarpPulse (64, 3, 3.45)
        end
    },
    {
        time = 106.342,
        func = function ()
            -- save the colors they were before
            song.beforeColor = {
                ["t1c"] = song.game.map.typeOneColor,
                ["t2c"] = song.game.map.typeTwoColor,
                ["t3c"] = song.game.map.typeThreeColor,
                ["snake"] = song.game.snake.snakeColor,
                ["bpmFood"] = song.bpmf.food.color,
                ["bpmFoodb"] = song.bpmf.food.bcolor,
                ["normalFood"] = song.nF.color,
                ["normalFoodb"] = song.nF.bcolor,
                ["scoreTime"] = song.game.scoreTimeColor
            }
            
            -- change them
            local currentColor = {0xFF, 0xEB, 0x3B, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
        end
    },
    {
        time = 107.011,
        func = function ()
            -- change them
            local currentColor = {0xF4, 0x43, 0x36, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
        end
    },
    {
        time = 107.659,
        func = function ()
            -- change them
            local currentColor = {0x03, 0xA9, 0xF4, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
        end
    },
    {
        time = 108.283,
        func = function ()
            -- change them
            local currentColor = {0x9C, 0x27, 0xB0, 255}
            
            song.game.map.typeOneColor = currentColor
            song.game.map.typeTwoColor = currentColor
            song.game.map.typeThreeColor = currentColor
            song.game.snake.snakeColor = currentColor
            song.game.scoreTimeColor = currentColor
            
            -- "tacar o piru" is how the following is known
            for i, v in pairs (song.game.foods) do
                v.food.color, v.food.bcolor = currentColor, currentColor
            end
        end
    },
    {
        time = 108.991,
        func = function ()
            song.game.map.typeOneColor = song.beforeColor.t1c
            song.game.map.typeTwoColor = song.beforeColor.t2c
            song.game.map.typeThreeColor = song.beforeColor.t3c
            song.game.snake.snakeColor = song.beforeColor.snake
            song.game.scoreTimeColor = song.beforeColor.scoreTime
            
            song.nF.color = song.beforeColor.normalFood
            song.nF.bcolor = song.beforeColor.normalFoodb
            
            song.bpmf.food.color = song.beforeColor.bpmFood
            song.bpmf.food.bcolor = song.beforeColor.bpmFoodb
        end
    },
    {
        time = 109.810,
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
        end
    },
    {
        time = 110.419,
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
        end
    },
    {
        time = 111.058,
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
        end
    },
    {
        time = 111.522,
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
        end
    },
    {
        time = 112.333,
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
        end
    },
    {
        time = 112.812,
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
        end
    },
    {
        time = 113.234,
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
        end
    },
    {
        time = 113.887,
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
        end
    },
    {
        time = 114.395,
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
        end
    },
    {
        time = 115.063,
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
        end
    },
    {
        time = 116.161,
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
        end
    },
    {
        time = 116.224,
        func = function ()
            song.game.map.typeOneColor = song.beforeColor.t1c
            song.game.map.typeTwoColor = song.beforeColor.t2c
            song.game.map.typeThreeColor = song.beforeColor.t3c
            song.game.snake.snakeColor = song.beforeColor.snake
            song.game.scoreTimeColor = song.beforeColor.scoreTime
            
            song.nF.color = song.beforeColor.normalFood
            song.nF.bcolor = song.beforeColor.normalFoodb
            
            song.bpmf.food.color = song.beforeColor.bpmFood
            song.bpmf.food.bcolor = song.beforeColor.bpmFoodb
        end
    },
    {
        time = 152.639,
        func = function ()
            song.game:doHugeText ("END", 0.3)
        end
    },
    {
        time = 156.064,
        func = function ()
            song.game:doHugeText ("IS", 0.3)
        end
    },
    {
        time = 157.762,
        func = function ()
            song.game:doHugeText ("NEAR", 0.3)
        end
    },
    {
        time = 173.221,
        func = function ()
            song.spdf = Food:new ("res/points/speed.lua", song.game)
            song.spdf.food.speedModifier = 50
            song.spdf.worth = 100
            song.game.map:addFood (song.spdf)
            song.game:doWarpPulse (640, 4, 30.0)
        end
    },
    {
        time = 177.555,
        func = function ()
            --song.game:doWarpPulse (640, 4, 10.0)
        end
    },
    {
        time = 186.248,
        func = function ()
            --song.game:doWarpPulse (640, 4, 0.6)
        end
    },
    {
        time = 187.086,
        func = function ()
            
        end
    },
    {
        time = 215.00,
        func = function ()
            -- unlock sank in achievement
            achievementSys:unlock ("sankIn", true)
        end
    },
    {
        time = 500,
        func = function ()
            
        end
    }
    
}

return song
