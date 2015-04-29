require "objects.food"
require "objects.map"
require "objects.snake"
require "objects.song"

Game = mClass ("Game")

function Game:initialize (mapFile)
    self.executing = false
    
    -- load map
    self.mapFile = mapFile
    self.map = Map:new (mapFile, v.tileSize, self)
    
    -- some useful color things
    self.backgroundColor = v.backgroundColor
    self.canvasDrawColor = {255, 255, 255, 255}
    self.scoreTimeColor = v.defScoreTimeColor
    
    -- for now... no game mode:
    self.gameMode = "none"
    
    self.gameStarted = false
    
    self.score = 0
    self.foods = {}
    
    self.throughPortal = false
    
    self.gdt = 0
    self.gtdt = 0
    
    self.stats = statsManager
    
    self.foodEaten = 0
end

function Game:start (gameMode)
    -- Load Game Mode
    self.executing = true
    self.gameMode = gameMode
    
    local roof = #(love.filesystem.getDirectoryItems("/res/music/" .. self.gameMode .. "/")) / 2
    local value = 3 --math.random (1, roof)
    
    self.song = Song:new ("res/music/" .. self.gameMode .. "/" .. value .. ".lua", self)
    
    self.snake = Snake:new ({{x = 4, y = 4}, {x = 3, y = 4}}, self.map, self)
    
    self.gameStarted = true
    
    self.song:play ()
end

function Game:stop ()
    self.executing = false
    
    self.song:stop ()
end

function Game:update (dt)
    love.graphics.setBackgroundColor (self.backgroundColor)
    
    self.gtdt = self.gtdt + dt
    if not self.executing then
        return
    end
    
    self.gdt = self.gdt + dt
    
    self.map:update (dt)
    self.snake:update (dt)
    
    -- song update goes here
    self.song:update (dt)
    
    for i, v in pairs (self.foods) do
        v:update (dt)
    end
end

function Game:draw ()
    self.map:draw ()
    self.snake:draw ()
    
    -- but song draw doesn't, because after he translations, the text gets... weird
    -- self.song:draw ()
    
    for i, v in pairs (self.foods) do
        v:draw ()
    end
end

function Game:keypressed (key)
    -- self.map:keypressed (key)
    self.snake:keypressed (key)
    self.song:keypressed (key)
    
    for i, v in pairs (self.foods) do
        v:keypressed (key)
    end
end

function Game:quit ()
    -- show "are you sure?"
    self:terminate ("quit")
    return false
end

function Game:addPoints (points)
    self.score = self.score + points
end

function Game:terminate (reason)
    if reason == "wall" and not v.defWallKills then
        return
    elseif reason == "body" and not v.defDumbnessKills then
        return
    end

    self.executing = false
    self.song:stop ()
    
    -- stats
    self.stats:addToValue ("allTimeScore", self.score)
    
    if self.stats:getValue ("topScore") < self.score then
        self.stats:setStat ("topScore", self.score)
    end
    
    self.stats:addToValue ("allTimeGameTime", math.floor (self.gdt))
    
    if self.stats:getValue ("topTime") < self.gdt then
        self.stats:setStat ("topTime", math.floor (self.gdt))
    end
    
    self.stats:addToValue ("allTimeFood", self.foodEaten)
    
    if self.stats:getValue ("topFood") < self.foodEaten then
        self.stats:setStat ("topFood", self.foodEaten)
    end
    
    self.stats:save ()

    -- change to scoreboards with input if not quit
    scoreboardState.callAfter = "menu"
    if reason == "quit" then
        scoreboardState.currentScore = -1
        scoreboardState.showInsertUI = false
    else
        scoreboardState.currentScore = self.score
        scoreboardState.showInsertUI = true
    end
    disableState ("game")
    enableState ("scoreboard")
    
    self:initialize (self.mapFile)
end

function Game:doWarpPulse (size, strength, duration)
    -- this is where, to keep some things a bit simpler, I have to get more love-specific code into objects :(
    self.gameState.warp_shader:send ("size", size)
    self.gameState.warp_shader:send ("strength", strength)
    
    self.gameState.warpDuration = duration
    
    self.gameState.warpEnabled = true
end

function Game:doDistortionPulse (duration, size, intensity)
    self.gameState.distortionDuration = duration
    self.gameState.distortionIntensity = intensity
    self.gameState.distortion_shader:send ('size', size)
    self.gameState.distortionEnabled = true
end

function Game:doHugeText (text, duration)
    self.gameState.hugeText = text
    
    local size = squareFont:getHeight() * self.map.map.width * self.map.tileSize / squareFont:getWidth (text)
    
    self.gameState.hugeTextFont = love.graphics.newFont("res/fonts/5x5_square.ttf", size)
    
    self.gameState.hugeTextScale = (self.map.map.width * self.map.tileSize) / self.gameState.hugeTextFont:getWidth (text)
    
    self.gameState.hugeTextY = ((self.map.map.height * self.map.tileSize) - self.gameState.hugeTextFont:getHeight ()) / 2
    self.gameState.hugeTextX = 0 --((self.map.map.width * self.map.tileSize) - self.gameState.hugeTextFont:getWidth (text)) / 2
    
    self.gameState.hugeTextDuration = duration
    
    self.gameState.drawHugeText = true
end

function Game:addFood (food)
    if not self:containsFood (food) then
        table.insert (self.foods, food)
    end
end

function Game:containsFood (food)
    for i, v in pairs (self.foods) do
        if v == food then
            return true
        end
    end
    return false
end

function Game:removeFood (food)
    for i, v in pairs (self.foods) do
        if v == food then
            table.remove (self.foods, i)
        end
    end
end

function Game:touchpressed (id, x, y, pressure)
    self.snake:touchpressed (id, x, y, pressure)
end

function Game:touchreleased (id, x, y, pressure)
    self.snake:touchreleased (id, x, y, pressure)
end
