require "objects.food"

song = {}

song.meta = {
    ["name"] = "Moonlight Sonata",
    ["performer"] = "Paul Pitman",
    ["composer"] = "Beethoven",
    ["file"] = "res/music/classic/1.ogg",
    ["presentString"] = "Moonlight Sonata, by Beethoven, performed by Paul Pitman"
}

function song.start ()
    --suppose the following has been set by the game:
    -- song.game = {}
    
    song.dtt = 0
    
    song.indx = 1
    song.nt = song.functions[song.indx].time
    
    song.game.snake.speed = 45
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
    
    song.game.snake.speed = 45 + song.game.score / 10
end

song.functions = {
   
    { 
        time = 1.0,
        func = function ()
            f = Food:new ("normal", song.game)
            song.game.map:addFood (f)
        end
        
    },
    {
        time = 319.0,
        func = function ()
            achievementSys:unlock ("pBeethoven", true)
        end
    }
}

return song
