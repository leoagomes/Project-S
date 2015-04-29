song = {}

song.meta = {
    ["name"] = "Shut Down!",
    ["performer"] = "daPlaque",
    ["composer"] = "daPlaque",
    ["file"] = "res/music/dubstep/3.ogg",
    ["presentString"] = "Shut Down!, by daPlaque"
}

function song.start ()
    --suppose the following has been set by the game:
    -- song.game = {}
    song.dtt = 0
    song.indx = 1
    song.nt = song.functions[song.indx].time
    song.food = {}
    song.baseSnakeSpeed = 45
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
    song.game.snake.speed = song.baseSnakeSpeed + song.game.snake.baseSpeedPoints + (song.game.score / 1.8) + song.dtt / 2
end

song.functions = {
    {
        time = 0.0,
        func = function ()
            song.game.map:reloadMap ("res/maps/cross.lua")

            song.ibpmf = Food:new ("res/points/insanebpm.lua", song.game)
            song.ibpmf.food.songbpm = 170
            song.ibpmf.food.begin ()
            song.game.map:addFood (song.ibpmf)

            song.nF = Food:new ("normal", song.game)
            song.game.map:addFood (song.nF)

            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 25
        end
    },
    {
        time = 38.744,
        func = function ()
            song.game:doWarpPulse (30, 1, 1.055)
        end
    },
    {
        time = 46.720,
        func = function ()
            song.game.foods = {}
            song.game.map.foods = {}

            song.game:doHugeText ("Shut Down!", 1.135)

            song.game.map:reloadMap ("res/maps/classic.portal.lua")
        end
    },
    {
        time = 48.053,
        func = function ()
            song.game:doWarpPulse (320, 4, 0.782)
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 40

            song.game.map:addFood (song.nF)
            song.game.map:addFood (Food:new ("normal", song.game))
        end
    },
    {
        time = 96.915,
        func = function ()
            -- save the colors they were before
            song.beforeColor = {
                ["t1c"] = song.game.map.typeOneColor,
                ["t2c"] = song.game.map.typeTwoColor,
                ["t3c"] = song.game.map.typeThreeColor,
                ["snake"] = song.game.snake.snakeColor,
                ["scoreTime"] = song.game.scoreTimeColor
            }
            
            -- change them
            local currentColor = {0x03, 0xA9, 0xF4, 255} -- blue
            
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
        time = 108.050,
        func = function ()
            -- change them
            local currentColor = {0xF4, 0x43, 0x36, 255} -- red
            
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
    }, -- after legendary: --
    {
        time = 118.611,
        func = function ()
            -- change them
            local currentColor = {0x81, 0xD4, 0xFA, 255} -- blue
            
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
        time = 119.498,
        func = function ()
            -- change them
            local currentColor = {0xEF, 0x9A, 0x9A, 255} -- red
            
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
        time = 120.926,
        func = function ()
            -- change them
            local currentColor = {0x4F, 0xC3, 0xF7, 255} -- blue
            
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
        time = 122.369,
        func = function ()
            -- change them
            local currentColor = {0xE5, 0x73, 0x73, 255} --red
            
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
        time = 123.802,
        func = function ()
            -- change them
            local currentColor = {0x29, 0xB6, 0xF6, 255} -- blue
            
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
        time = 125.192,
        func = function ()
            -- change them
            local currentColor = {0xEF, 0x53, 0x50, 255} -- red
            
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
        time = 126.528,
        func = function ()
            -- change them
            local currentColor = {0x03, 0xA9, 0xF4, 255} -- blue 500
            
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
        time = 128.077,
        func = function ()
            -- change them
            local currentColor = {0xF4, 0x43, 0x36, 255} -- red 500
            
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
        time = 130.793,
        func = function ()
            -- change them
            local currentColor = {0x03, 0xA9, 0xF4, 255} -- blue shark
            
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
        time = 132.169,
        func = function ()
            -- change them
            local currentColor = {0xF4, 0x43, 0x36, 255} -- red ez
            
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
        time = 133.571,
        func = function ()
            -- change them
            local currentColor = {0x03, 0xA9, 0xF4, 255} -- blue annie
            
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
        time = 134.873,
        func = function ()
            -- change them
            local currentColor = {0x03, 0xA9, 0xF4, 255} -- red garen
            
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
        time = 142.680,
        func = function ()
            song.game.map.typeOneColor = song.beforeColor.t1c
            song.game.map.typeTwoColor = song.beforeColor.t2c
            song.game.map.typeThreeColor = song.beforeColor.t3c
            song.game.snake.snakeColor = song.beforeColor.snake
            song.game.scoreTimeColor = song.beforeColor.scoreTime
        end
    },
    {
        time = 167.491,
        func = function ()
            song.game:doWarpPulse (640, 2, 22.145)
            song.game.snake.baseSpeedPoints = song.game.snake.baseSpeedPoints + 100
        end
    },
    {
        time = 250,
        func = function ()

        end
    }
}

return song
