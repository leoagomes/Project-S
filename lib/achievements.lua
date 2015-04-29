--[[
    The Achievement System
]]
require "lib.Tserial"
inspect = require "lib.inspect"

mClass = require "lib.middleclass"

AchievementSystem = mClass ("AchievementSystem")

function AchievementSystem:initialize (achList, achSave, achMediaFolder, testUpdateArgName, paramHolder)
    -- load the list containing achievements
    self.achievements = love.filesystem.load (achList) ()
    
    -- load the saved achievements
    self.savedAchFile = achSave -- achSave, btw, is a file
    self.savedAch = {} 
    
    self:load ()
    
    self.achMediaFolder = achMediaFolder
    self.uArgName = testUpdateArgName
    self.currentState = ""
    self.paramHolder = paramHolder
    
    -- Achievement cell
    self.animate = false
    self.dtt = 0
    self.delay = v.achCellDelay
    self.achAnimationTime = v.achAnimationTime
    self.step = 1 -- 1: fade in, 2: delay, 3: fade out
    
    -- Achievement cell data
    self.cellColor = v.cellColor
    self.cellDrawMode = v.cellDrawMode
    self.cellFontTwoColor = v.cellFontTwoColor
    self.cellFontOneColor = v.cellFontOneColor
    
    self.cellMargin = v.cellMargin * v.scaleFactor
    self.cellMarginFromTop = v.cellMarginFromTop * v.scaleFactor
    self.cellPicSide = v.cellPicSide * v.scaleFactor
    self.cellFontOneSize = v.cellFontOneSize
    self.cellFontTwoSize = v.cellFontTwoSize
    self.cellTTMargin = v.cellTTMargin * v.scaleFactor
    
    self.cellFont = love.graphics.getFont()
    
    -- To be used later
    -- self.cellW/H
    -- self.cellPicX/Y
    -- self.cellT1X/Y
    -- self.cellX/Y
    
    self.alltext = ""
    
    self.savedAch = self.savedAch == nil and {} or self.savedAch
    
    self.canReadInput = true
end

function AchievementSystem:unlock (achievementID, showAnimation)
    self.currentAch = self:getAchievementByID (achievementID)
    
    if self:isUnlocked (achievementID) then
        return
    end
    
    if self.currentAch["requiredA"] ~= nil and self:isUnlocked (self.currentAch["requiredA"]) == false then
        return false
    end
    
    self.savedAch[achievementID] = true
    self:save ()
    self:load ()
    
    if showAnimation then
        self.animate = true
        self.dtt = 0
        
        if self.currentAch["image"] ~= "none" then
            self.ach_image = love.graphics.newImage (self.achMediaFolder .. self.currentAch["image"])
            self.cellPicX = self.cellMargin
            self.cellPicY = self.cellMargin
            
            if self.currentAch["picSide"] == nil then
                self.cellPicSide = 0
            else
                self.cellPicSide = self.currentAch ["picSide"] * v.scaleFactor
            end
            
            if self.cellPicSide == 0 then
                self.cellPicSide = self.cellFont:getHeight () * v.scaleFactor * 2 + self.cellTTMargin
            end
            
            self.cellPicScale = self.cellPicSide / self.ach_image:getWidth () -- assuming image is 1:1
        else
            self.cellPicX = 0
            self.cellPicY = 0
            self.cellPicSide = 0
        end
        
        
        -- TODO: change this line so it fits different needs
        local textWidth = math.max (self.cellFont:getWidth (v.achLineOne), self.cellFont:getWidth (self.currentAch["name"]))
        
        self.cellWidth = 3 * self.cellMargin + textWidth * v.scaleFactor + self.cellPicSide
        self.cellHeight = 2 * self.cellMargin + math.max (self.cellPicSide, self.cellFont:getHeight () * 2 + self.cellTTMargin) * v.scaleFactor

        self.F1X = 2 * self.cellMargin + self.cellPicSide
        self.F1Y = self.cellMargin
        
        self.F2X = 2 * self.cellMargin + self.cellPicSide
        self.F2Y = self.cellMargin + self.cellFont:getHeight () + self.cellTTMargin
    end
end

function AchievementSystem:isUnlocked (achievementId)
    if self.savedAch[achievementId] == nil then
        return false
    else
        return true
    end
end

function AchievementSystem:getAchievementByID (achid)
    for i, v in pairs (self.achievements) do
        for ind, val in pairs (v) do
            if achid == ind then
                return val
            end
        end
    end
    return nil
end

function AchievementSystem:getUnlocked ()
    local list = {}

    for i, v in pairs (self.savedAch) do
        if v == true then
            list [i] = self:getAchievementByID (i)
        end
    end

    return list
end

function AchievementSystem:update (dt)
    
    if not self.animate then
        return
    end
    
    self.dtt = self.dtt + dt
    
    self.cellY = self.cellMarginFromTop
    if self.step == 1 then
        self.cellX = love.graphics.getWidth () - (self.dtt / self.achAnimationTime) * self.cellWidth
        
        if self.dtt >= self.achAnimationTime then
            self.step = 2
            self.dtt = 0
        end
    elseif self.step == 2 then
        self.cellX = love.graphics.getWidth () - self.cellWidth
        
        if self.dtt >= self.delay then
            self.step = 3
            self.dtt = 0
        end
    elseif self.step == 3 then
        self.cellX = love.graphics.getWidth () - (1 - (self.dtt / self.achAnimationTime)) * self.cellWidth
        
        if self.dtt >= self.achAnimationTime then
            self.step = 1
            self.dtt = 0
            self.animate = false
        end
    end
end

function AchievementSystem:draw ()
    if self.animate then
        love.graphics.setColor (self.cellColor)
        love.graphics.rectangle (self.cellDrawMode, self.cellX, self.cellY, self.cellWidth, self.cellHeight)
        
        love.graphics.setColor (self.cellFontOneColor)
        love.graphics.setFont (self.cellFont)
        love.graphics.print (v.achLineOne, self.cellX + self.F1X, self.cellY + self.F1Y, 0, v.scaleFactor) -- change to suit needs
        
        love.graphics.setColor (self.cellFontTwoColor)
        love.graphics.setFont (self.cellFont)
        love.graphics.print (self.currentAch["name"], self.cellX + self.F2X, self.cellY + self.F2Y, 0, v.scaleFactor) -- change to suit needs
        
        if self.currentAch["image"] ~= "none" and self.ach_image ~= nil then
            love.graphics.setColor ({255, 255, 255, 255})
            love.graphics.draw(self.ach_image, self.cellX + self.cellPicX, self.cellY + self.cellPicY, 0, self.cellPicScale)
        end
    end
end

function AchievementSystem:keypressed (key)
    for i, v in pairs (self.achievements["keyPresser"]) do
        if key == v["key"] then
            self:unlock (i, true)
        end
    end
end

function AchievementSystem:keyreleased (key)
    
end

function AchievementSystem:mousepressed (x, y, button)
    
end

function AchievementSystem:mousereleased (x, y, button)
    
end

function AchievementSystem:textinput (text)
    if not self.canReadInput then
        return
    end
    
    self.alltext = self.alltext .. text
    for i, v in pairs (self.achievements["textTyper"]) do
        if string.find (self.alltext, v["text"]) ~= nil then
            self.alltext = ""
            --print ("unlocking " .. i)
            self:unlock (i, true)
        end
    end
end

function AchievementSystem:save ()
    local r = love.filesystem.write (self.savedAchFile, Tserial.pack (self.savedAch, function (data) end, false))
    
    print ("r " .. inspect (r))
end

function AchievementSystem:load ()
    if love.filesystem.exists(self.savedAchFile) then
        self.savedAch = Tserial.unpack(love.filesystem.read(self.savedAchFile), false)
    else
        --print ("FAILED: " .. self.savedAchFile)
    end
end
