--[[
    Holds logic for songs.
]]

Song = mClass ("Song")

function Song:initialize (songPath, game)
    print (songPath)
    self.songScript = love.filesystem.load (songPath) ()
    self.game = game
    
    -- something so the script has more autonomy
    self.songScript.game = game
    self.songScript.love = love
    self.songScript.graphics = love.graphics
    
    self.song = love.audio.newSource (self.songScript.meta.file, "stream")
    self.song:setVolume (v.defSongVolume)
    
    self.drawName = v.shouldDrawSongName
    self.displayNameTime = v.displayNameTime
    
    self.songFont = love.graphics.newFont ("res/fonts/5x5_square.ttf", 14)
    
    self.dtt = 0
    self.playing = false
    
    self.drawPosX = "center" -- center, left, right
    self.drawPosY = "bottom" -- bottom, top, center
    
    self.x = 0
    self.y = 0
    
    self.textMargin = v.defSongNameMargin
    self.textColor = v.defSongNameColor
    
    self.isMuted = false
end

function Song:update (dt)
    if not self.playing then
        return
    end
    
    self.dtt = self.dtt + dt
    
    if self.drawName and self.dtt > self.displayNameTime then
        self.drawName = false
    elseif self.drawName then
        local pSw = love.graphics.getFont():getWidth (self.songScript.meta.presentString)
        local pSh = love.graphics.getFont():getLineHeight ()
        
        local ww = love.graphics.getWidth ()
        local wh = love.graphics.getHeight ()
        
        if self.drawPosX == "center" then
            self.x = (ww - pSw) / 2
        elseif self.drawPosX == "left" then
            self.x = self.textMargin
        else
            self.x = ww - pSw - self.textMargin
        end
        
        if self.drawPosY == "center" then
            self.y = (wh - pSh) / 2
        elseif self.drawPosY == "top" then
            self.y = self.textMargin
        else
            self.y = wh - pSh - self.textMargin
        end
    end
    
    if self.songScript.update ~= nil then
        self.songScript.update (dt)
    end
end

function Song:keypressed (key)
    if self.songScript.keypressed ~= nil then
        self.songScript.keypressed (key)
    end
end

function Song:draw ()
    if not self.playing then
        return
    end
    
    if self.drawName then
        love.graphics.setFont (self.songFont)
        
        love.graphics.setColor (self.textColor)
        love.graphics.print (self.songScript.meta.presentString, self.x, self.y)
    end
    
    if self.songScript.draw ~= nil then
        self.songScript.draw (dt)
    end
end

function Song:play ()
    love.audio.play (self.song)
    self.playing = true
    
    if self.songScript.start ~= nil then
        self.songScript.start ()
    end
end

function Song:pause ()
    love.audio.pause (self.song)
    self.playing = false
    
    if self.songScript.pause ~= nil then
        self.songScript.pause ()
    end
end

function Song:unpause ()
    love.audio.resume (self.song)
    self.playing = true
    
    if self.songScript.unpause ~= nil then
        self.songScript.unpause ()
    end
end

function Song:stop ()
    love.audio.stop (self.song)
    self.playing = false
    
    if self.songScript.stop ~= nil then
        self.songScript.stop ()
    end
end

function Song:mute ()
    if self.song:getVolume () ~= 0 then
        self.song:setVolume (0)
        self.isMuted = true
    else
        self.song:setVolume (1)
        self.isMuted = false
    end
end
