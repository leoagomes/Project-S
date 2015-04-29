vals = {
-- Colors
-- Background
    backgroundColor = {0x42, 0x42, 0x42, 255},
    blockedButtonColor = {0x9E, 0x9E, 0x9E, 255},

-- Tiles
    typeZeroColor = {0xBD, 0xBD, 0xBD, 255},
    typeOneColor = {0xEE, 0xEE, 0xEE, 255},
    typeTwoColor = {0x81, 0xD4, 0xFA, 255},

    typeZeroDraw = "line",
    typeOneDraw = "fill",
    typeTwoDraw = "fill",

-- Time showing tutorial
    defTutDisplayTime = 5,

-- Scale Factor
    scaleFactor = 1,

-- Cell Size
    tileSize = 15, -- pixels
    wheelWalk = 3,

-- Snake
    defSnakeSpeed = 25,
    defSnakeDiv = 10,

    defSnakeColor = {0xFF, 0xF1, 0x76, 255},
    defHeadDarkness = 30,
    defSnakeDraw = "fill",

-- default keys
    upKey = "up",
    downKey = "down",
    leftKey = "left",
    rightKey = "right",
    muteKey = "m",
    pauseKey = "p",

-- Scores
    defFoodValue = 5,
    defFoodColor = {255, 255, 255, 255},
    defFoodBorderColor = {255, 255, 255, 255},
    defFoodDrawMode = "fill",

-- Song data
    defSongVolume = 1.0, -- 100%
    shouldDrawSongName = true,
    displayNameTime = 40, -- seconds
    defSongNameMargin = 25, -- pixels
    defSongNameColor = {255, 255, 255, 255},

-- Achievement cell data
    cellColor = {83, 86, 90, 250}, -- for now, about pantone cool gray 11
    cellFontOneColor = {255, 255, 255, 200},
    cellFontTwoColor = {255, 255, 255, 255},

    cellDrawMode = "fill" ,

    cellMargin = 20, -- pixels
    cellMarginFromTop = 50, -- pixels
    cellPicSide = 0, -- pixels / 0 for auto
    cellFontOneSize = 10, -- pixels i think
    cellFontTwoSize = 12, -- pixels i think
    cellTTMargin = 5, -- pixels

    achCellDelay = 2.5, -- seconds
    achAnimationTime = 0.5, -- seconds

    achLineOne = "Unlocked:",

-- in game ui
    defTopMargin = 30,
    defLeftMargin = 30,
    defRightMargin = 30,
    defBottomMargin = 30,

-- extra btn margin
    defEMW = 20,
    defEMH = 10,

-- score/time
    defScoreTimeColor = {255, 255, 255, 255},
    defScoreTimeFontSize = 20,

-- pause menu
    pauseMenuClearColor = {0, 0, 0, 120},
    pauseMenuTextColor = {255, 255, 255, 255},

-- if dubstep mode should come unlocked
    defDubstepUnlocked = true,

-- if hitting wall/body kills you:
    defWallKills = true,
    defDumbnessKills = true
}

return vals
