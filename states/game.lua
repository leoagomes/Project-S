--[[
    Part of code which handles classic mode
]]
require "objects.game"
require "lib.libui"

GameMode = mClass ("GameMode")

function GameMode:load ()
    -- create a game. for now use only classic map
    self.game = Game:new ("res/maps/classic.lua")
    self.game.gameState = self -- useful in doWarpPulse
    
    self.timeFont = love.graphics.newFont ("res/fonts/5x5_square.ttf", v.defScoreTimeFontSize)
    
    self.gameMode = "dubstep"
    
    -- Translate Game so it's always centered
    self.tx = (love.graphics.getWidth () - (self.game.map.map.width * self.game.map.tileSize)) / 2
    self.ty = (love.graphics.getHeight () - (self.game.map.map.height * self.game.map.tileSize)) / 2
    
    -- UI
    self.lui = libui:new ()
    self.bfont = love.graphics.newFont ("res/fonts/5x5_square.ttf", 18)
    
    local pbx = love.graphics.getWidth () - self.bfont:getWidth  ("Pause") - v.defEMW - v.defRightMargin
    local pby = love.graphics.getHeight () - self.bfont:getHeight () - v.defEMH - v.defBottomMargin
    
    self.pb = Button:new ("Pause", pbx, pby, self.bfont, "pauseButton")
    
    self.lui:addObject (self.pb)
    
    local mbx = v.defRightMargin
    local mby = love.graphics.getHeight () - self.bfont:getHeight () - v.defEMH - v.defBottomMargin
    
    self.mb = Button:new ("Mute", mbx, mby, self.bfont, "muteButton")
    
    self.lui:addObject (self.mb)
    
    self.pb.onClick = function (x, y, button)
        
        pausedState.game = self.game
        enableState ("pause")
        achievementSys.currentState = "pause"
        
        self.game.song:pause ()
        
        self.game.executing = false
    end
    
    self.mb.onClick = function (x, y, button)
        self.game.song:mute ()
        if self.game.song.isMuted then
            self.mb:changeText ("Unmute")
        else
            self.mb:changeText ("Mute")
        end
    end
    
    -- Canvas for Game
    self.cnvs = love.graphics.newCanvas (love.graphics.getWidth(), love.graphics.getHeight())
    self.cX = 0
    self.cY = 0
    
    -- Shader Part
    -- Warp Shader
    self.warp_shader = love.graphics.newShader ("res/shaders/warp.lsl")
    
    self.warpEnabled = false
    self.warpTimer = 0
    self.warpDuration = 0

    -- Noise Shader
    self.distortion_shader = love.graphics.newShader ("res/shaders/distortion.lsl")
    self.distortionEnabled = false
    self.distortionTimer = 0
    self.distortionDuration = 0
    self.distortionIntensity = 1

    -- Huge Text Part
    self.hugeTextColor = {255, 255, 255, 255}
    self.hugeText = ""
    self.hugeTextX = 0
    self.hugeTextY = 0
    self.drawHugeText = false
    self.hugeTextFont = love.graphics.getFont ()
    self.hugeTextDuration = 0
    self.hugeTextScale = 1
    self.hugeTextRot = 0

    -- dubstep mode
    self.dmUnlocked = v.defDubstepUnlocked
end

function GameMode:update (dt)
    -- ui
    self.lui:update (dt)

    -- game
    self.game:update (dt)
    
    -- do warp effect
    if self.game.executing then
        if self.warpEnabled and self.warpTimer < self.warpDuration then
            self.warpTimer = self.warpTimer + dt
            self.warp_shader:send('time', self.game.gdt)
        else
            self.warp_shader:send('time', 0)
            self.warpTimer = 0
            self.warpEnabled = false
        end

        if self.distortionEnabled and self.distortionTimer < self.distortionDuration then
            self.distortion_shader:send ('time', self.game.gdt * self.distortionIntensity)
            self.distortionTimer = self.distortionTimer + dt
        elseif self.distortionEnabled then
            self.distortionTimer = 0
            self.distortionEnabled = false
        end
    end
    
    -- do huge text
    if self.drawHugeText and self.hugeTextDuration > 0 then
        self.hugeTextDuration = self.hugeTextDuration - dt
    elseif self.drawHugeText and self.hugeTextDuration <= 0 then
        self.drawHugeText = false
    end
    
    -- set name and fps
    love.window.setTitle ("Project S (FPS: " .. love.timer.getFPS () .. ")")
    
    -- update tween
    self.acTween:update (dt)

    -- hide mouse if is over map
    if self.game.executing and love.mouse.getX () > self.tx and love.mouse.getX () < (self.tx + (self.game.map.map.width * v.tileSize)) then
        if love.mouse.getY () > self.ty and love.mouse.getY () < (self.ty + (self.game.map.map.height * v.tileSize)) then
            love.mouse.setVisible (false)
        else
            love.mouse.setVisible (true)
        end
    else
        love.mouse.setVisible (true)
    end
end

function GameMode:draw ()
    -- draw everything in a canvas so shaders will work correclty.
    love.graphics.setCanvas (self.cnvs)
        self.cnvs:clear (self.game.backgroundColor)
        
        -- draw ui here
        self.lui:draw ()
        
        -- draw time / score
        love.graphics.setColor (self.game.scoreTimeColor)
        
        local beforeTime = love.graphics.getFont ()
        love.graphics.setFont (self.timeFont)
    
        --draw time
        love.graphics.print (string.format ("%02d:%02.0f", math.modf(self.game.gdt / 60), math.fmod((self.game.gdt), 60)), v.defLeftMargin, v.defTopMargin, 0, v.scaleFactor)
        
        -- draw score
        local str = string.format ("Score: %d", self.game.score)
        love.graphics.print (str, love.graphics.getWidth () - v.defRightMargin - self.timeFont:getWidth (str), v.defTopMargin, 0, v.scaleFactor)
    
        love.graphics.setFont (beforeTime)
        
        -- draw the game song
        self.game.song:draw ()
        
        love.graphics.push ()
        love.graphics.translate (self.tx, self.ty)
            self.game:draw ()
            
            -- draw huge text after game
            if self.drawHugeText then
                local beforeFont = love.graphics.getFont()
                
                love.graphics.setColor (self.hugeTextColor)
                love.graphics.setFont (self.hugeTextFont)
                love.graphics.print (self.hugeText, self.hugeTextX, self.hugeTextY, self.hugeTextRot, self.hugeTextScale * v.scaleFactor)
                
                love.graphics.setFont (beforeFont)
            end
            
        love.graphics.pop ()
    
    love.graphics.setCanvas ()
    
    -- activate the shader, if we should
    if self.warpEnabled then
        love.graphics.setShader (self.warp_shader)
    end
    if self.distortionEnabled then
        love.graphics.setShader (self.distortion_shader)
    end
    
    love.graphics.setColor (self.game.canvasDrawColor)
    love.graphics.draw(self.cnvs, self.cX, self.cY)
    
    love.graphics.setShader ()
end

function GameMode:keypressed (key)
    self.lui:keypressed (key)
    
    -- do the state management part here, so objects remain neutral
    if (key == v.pauseKey or key == "escape") and self.game.executing then
        pausedState.game = self.game
        self.game.executing = false
        self.game.song:pause ()
        pausedState.ghost = true
        enableState ("pause")
        achievementSys.currentState = "pause"
        
        self.game.executing = false
    elseif key == v.muteKey then    
        self.game.song:mute ()
        if self.game.song.isMuted then
            self.mb:changeText ("Unmute")
        else
            self.mb:changeText ("Mute")
        end
    end
    
    self.game:keypressed (key)
end

function GameMode:keyreleased (key)
    --self.game:keyreleased (key)
    self.lui:keyreleased (key)
end

function GameMode:mousepressed (x, y, button)
    --self.game:mousepressed (x, y, button)
    self.lui:mousepressed (x, y, button)
end

function GameMode:mousereleased (x, y, button)
    --self.game:mousereleased (x, y, button)
    self.lui:mousereleased (x, y, button)
end

function GameMode:touchpressed (id, x, y, pressure)
    self.game:touchpressed (id, x, y, pressure)
end

function GameMode:touchreleased (id, x, y, pressure)
    self.game:touchreleased (id, x, y, pressure)
end

function GameMode:quit ()
    return self.game:quit ()
end

function GameMode:initialize ()
    
end

function GameMode:enable ()
    -- animation
    self.cX = love.graphics.getWidth ()
    self.acTween = tween.new (0.15, self, {cX = 0}, 'outExpo')
    
    self.game:start (self.gameMode)
    
    self.mb:changeText ("Mute")
end

function GameMode:disable ()
   love.mouse.setVisible (true)
end

function GameMode:close ()
    
end
