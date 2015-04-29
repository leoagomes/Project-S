--[[
    One nice thing to note is: you can use __index() to trick the achievementSystem into running functions so achievements can get more complex.
    Also I could just have implemented a "run()" after the achievement is unlocked. :D
]]

return {
    ["keyPresser"] = {
        ["pressedUselessKey"] = {
            ["name"] = "Pressed Useless Key",
            ["description"] = "Pressed a key just to get this achievement? Read the source? I KNEW IT!",
            ["image"] = "none",
            ["availableState"] = "game",
            ["key"] = "a"
        },
        ["readTheSource"] = {
            ["name"] = "Read The Source",
            ["gDescription"] = "Don't do it!",
            ["uDescription"] = "STAWP READING TH3 SOURCEZZZ!",
            ["image"] = "none",
            ["availableState"] = "game",
            ["requiredA"] = "pressedUselessKey",
            ["key"] = "j"
        },
    },
    
    ["textTyper"] = {
        ["readTheSourceMore"] = {
            ["name"] = "Read The Too Much Of The Source",
            ["gDescription"] = "I recommend not to!",
            ["uDescription"] = "If you're still reading this, it means you like spoilers. TED GETS ROBIN, HEISENBERG DIES, UNDERWOOD BECOMES PRESIDENT. Will you stop now?",
            ["image"] = "none",
            ["availableState"] = "achievemets",
            ["requiredA"] = "readTheSource",
            ["text"] = "ireadsource"
        },
        ["snakeParable"] = {
            ["name"] = "The Snake Parable",
            ["description"] = "Snake worked for a company in a big building where it was employee number...",
            ["image"] = "stanley.jpg",
            ["availableState"] = "global",
            ["text"] = "427"
        },
        ["comicSans"] = {
            ["name"] = "NEVER",
            ["description"] = "I WOULD NEVER DO THIS!",
            ["text"] = "comicsans",
            ["image"] = "none"
        }
    },
    
    ["outsiderCalls"] = {
        ["pBeethoven"] = {
            ["name"] = "Beethoven",
            ["description"] = "Finish a song by Beethoven",
            ["image"] = "none"
            -- ["availableState"] is not required since it's an outside function that will call this anyway.
        },
        ["notThatWay"] = {
            ["name"] = "Not THAT Way!",
            ["description"] = "Hit A Wall.",
            ["image"] = "none"
        },
        ["whatGoesAround"] = {
            ["name"] = "What Goes Around...",
            ["description"] = "Go through a portal",
            ["image"] = "none",
            ["availableState"] = "game"
        },
        ["uDubstepMode"] = {
            ["name"] = "Unlocked Dubstep Mode",
            ["description"] = "Got tired of Classic Mode",
            ["image"] = "none"
        },
        ["sankIn"] = {
            ["name"] = "Sank In",
            ["description"] = "Complete Sinking In.",
            ["image"] = "none"
        },
        ["bravePal"] = {
            ["name"] = "Brave Pal",
            ["description"] = "Continue after song has ended.",
            ["image"] = "none"
        },
        ["heatstroken"] = {
            ["name"] = "Heatstroken",
            ["description"] = "Complete Heatstroke",
            ["image"] = "none"
        },
        ["aClockwork"] = {
            ["name"] = "A Clockwork Snake",
            ["descprition"] = "Need one? Seriously?",
            ["image"] = "none"
        },
        ["bounty500"] = {
            ["name"] = "Bounty: 500 G.",
            ["description"] = "You have ended someone's killing spree",
            ["image"] = "none"
        }
    }
}
