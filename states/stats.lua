--[[
    Part of code which handles the stats panel
]]
StatsPanel = mClass ("StatsPanel")

function StatsPanel:load ()
    -- load layout file
    self.sPanel = love.filesystem.load ("res/layout/stats.lua") ()
    
    -- load ui
    self.lui = libui:new ()
    
    -- stats file will be loaded when this is enabled, but...
    self.sFile = {}
    
    -- set layout up
    self.sPanel.me = self
    self.sPanel.ui = self.lui
    self.sPanel.statsMan = statsManager
    
    self.sPanel.start ()
    
    -- canvas for animations
    self.canvas = love.graphics.newCanvas (love.graphics.getWidth (), love.graphics.getHeight ())
    self.cX, self.cY = 0, 0
    
    -- for clearing stats
    self.text = ""
end

function StatsPanel:update (dt)
    -- UI
    self.lui:update (dt)
    
    -- Animations
    self.canvasTween:update (dt)
end

function StatsPanel:draw ()
    love.graphics.setCanvas (self.canvas)
        self.canvas:clear (v.backgroundColor)
        -- UI
        self.lui:draw ()
    love.graphics.setCanvas ()
    
    love.graphics.setColor ({255, 255, 255, 255})
    love.graphics.draw (self.canvas, self.cX, self.cY)
end

function StatsPanel:keypressed (key)
    -- UI 
    self.lui:keypressed (key)
end

function StatsPanel:keyreleased (key)
    -- UI
    self.lui:keyreleased (key)
end

function StatsPanel:mousepressed (x, y, button)
    -- UI
    self.lui:mousepressed (x, y, button)
end

function StatsPanel:mousereleased (x, y, button)
    -- UI
    self.lui:mousereleased (x, y, button)
end

function StatsPanel:textinput (text)
    self.text = self.text .. text
    
    if string.find (self.text, "clearmystats") ~= nil then
        statsManager:clearAll ()
        statsManager:save ()
        
        if self.sPanel.reload ~= nil then
            self.sPanel.reload ()
        end
    end

    if string.find (self.text, "resetmyscores") ~= nil then
        scoreboardSys.sb = {}
        scoreboardSys:reload ()

        if self.sPanel.reload ~= nil then
            self.sPanel.reload ()
        end
    end
end

function StatsPanel:quit ()
    
end

function StatsPanel:enable ()
    -- Reload Stats Manager
    self.allStats = statsManager:getAll ()
    
    self.lui.buttonsToKeys = true
    self.lui.cbIndex = 3

    -- animation
    self.cX = love.graphics.getWidth ()
    self.canvasTween = tween.new (0.15, self, {cX = 0}, 'outExpo')
    
    if self.sPanel.reload ~= nil then
        self.sPanel.reload ()
    end
end

function StatsPanel:disable ()
    self.lui.buttonsToKeys = false
    self.lui:unselect ()
end

function StatsPanel:close ()
    
end
