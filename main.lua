--[[
	Main Class
]]
-- Default Values
v = require "res.values"

-- State Manager
require "lib.lovelyMoon"
require "lib.stateManager"

-- Achievement System
require "lib.achievements"

-- Scoreboard System
require "lib.scoreboards"

-- Options Manager
require "lib.optman"

-- Stats Manager
require "lib.statsman"

-- UI
require "lib.libui"

-- MiddleClass
mClass = require ("lib.middleclass")

-- Tween
tween = require ("lib.tween")

-- States
require ("states.achievementPanel")
require ("states.game")
require ("states.mainMenu")
require ("states.settings")
require ("states.scoreboard")
require ("states.pauseMenu")
require ("states.modeSel")
require ("states.tutorial")
require ("states.stats")

-- Game
require "objects.game"


function love.load ()
    -- reload the values
    optMan = OptionsManager:new ("opts.sav", v)
    optMan:replace ()
    
    v.tileSize = v.tileSize * v.scaleFactor

    -- set random seed
    love.math.setRandomSeed (love.timer.getTime ())
    math.randomseed (love.timer.getTime ())
    
    -- just so libui works... won't hurt
    graphics = love.graphics
    
    -- Load Fonts
    roundFont = love.graphics.newFont ("res/fonts/5x5_rounded.ttf")
    squareFont = love.graphics.newFont ("res/fonts/5x5_square.ttf")
    
    -- Set Font to square
    love.graphics.setFont (squareFont)
    
    -- Set bg color
    love.graphics.setBackgroundColor (v.backgroundColor)
    
    -- load achievement lib
    achievementSys = AchievementSystem:new ("res/achievements/achievements.lua", "achieved.sav", "res/achievements/media/", "inGameEvent", {})

    -- load scoreboards lib
    scoreboardSys = ScoreboardSystem:new ("scores.sav")
    
    -- load stats lib
    statsManager = StatsManager:new ("stats.sav")
    
    -- States
    menuState = addState (MainMenu, "menu")
    gameState = addState (GameMode, "game")
    settingState = addState (Settings, "settings")
    achievementState = addState (AchievementPanel, "achievements")
    scoreboardState = addState (Scoreboard, "scoreboard")
    pausedState = addState (PauseMenu, "pause")
    modeSelState = addState (ModeSelection, "modeSel")
    statsState = addState (StatsPanel, "stats")
    tutState = addState (Tutorial, "tutorial")
    
    -- Set First State
    --enableState ("menu")
    enableState ("tutorial")
end

function love.update (dt)
    lovelyMoon.update (dt)
    
    -- achievement system
    achievementSys:update (dt)
end

function love.draw ()
    lovelyMoon.draw ()
    
    -- achievement system
    achievementSys:draw ()
end

function love.keypressed (key)
    lovelyMoon.keypressed (key)
    
    -- achievement systemdt
    achievementSys:keypressed (key)
end

function love.keyreleased (key)
    lovelyMoon.keyreleased (key)
end

function love.mousepressed (x, y, button)
    lovelyMoon.mousepressed (x, y, button)
end

function love.mousereleased (x, y, button)
    lovelyMoon.mousereleased (x, y, button)
end

function love.quit ()
    return lovelyMoon.quit (x, y, button)
end

function love.textinput (text)
    lovelyMoon.textinput (text)
    
    -- achievement system
    achievementSys:textinput (text)
end

function love.touchpressed (id, x, y, pressure)
    lovelyMoon.touchpressed (id, x, y, pressure)
end

function love.touchreleased (id, x, y, pressure)
    lovelyMoon.touchreleased (id, x, y, pressure)
end
