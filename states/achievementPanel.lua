--[[
    Part of code which handles classic mode
]]
AchievementPanel = mClass ("Achievements")

function AchievementPanel:load ()
    -- roads
    self.apLayout = love.filesystem.load ("res/layout/achievements.lua") ()    
    self.apLayout.me = self
    
    -- crossings
    self.lui = libui:new ()
    self.apLayout.ui = self.lui

    self.apLayout.start ()
end

function AchievementPanel:update (dt)
    -- taking steps
    self.lui:update (dt)
end

function AchievementPanel:draw ()
    -- standing still
    self.lui:draw ()
end

function AchievementPanel:keypressed (key)
    -- remember
    self.lui:keypressed (key)

    if self.apLayout.keypressed then
        self.apLayout.keypressed (key)
    end
end

function AchievementPanel:keyreleased (key)
    -- remember
    self.lui:keyreleased (key)
end

function AchievementPanel:mousepressed (x, y, button)
    -- you've
    self.lui:mousepressed (x, y, button)
end

function AchievementPanel:mousereleased (x, y, button)
    -- got
    self.lui:mousereleased (x, y, button)
end

function AchievementPanel:quit ()
    
end

function AchievementPanel:enable ()
    -- time
    if self.apLayout.enable then
        self.apLayout.enable ()
    end
end

function AchievementPanel:disable ()
    
end

function AchievementPanel:close ()
    
end
