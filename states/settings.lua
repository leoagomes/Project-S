--[[
    Part of code which handles classic mode
]]
Settings = mClass ("Settings")

function Settings:load ()
    self.omLayoutFile = "res/layout/settingsMenu.lua"
    self.omLayout = love.filesystem.load (self.omLayoutFile) ()
    
    self.opts = optMan:getAll ()
    
    -- UI
    self.lui = libui:new ()
    
    self.omLayout.me = self
    self.omLayout.lui = self.lui
    
    self.omLayout.start ()
    
    -- needed so pause won't instantly disable pause state
    self.pause = false
    
    -- canvas for transitions
    self.canvas = love.graphics.newCanvas(love.graphics.getWidth (), love.graphics.getHeight ())
    self.cX = 0
    self.cY = 0
    
    -- for accessing from pause menu
    self.comesFrom = "menu"
end

function Settings:update (dt)
    -- tween
    self.canvasTween:update (dt)
    
    -- UI
    self.lui:update (dt)
    
    if self.omLayout.update ~= nil then
        self.omLayout.update (dt)
    end
end

function Settings:draw ()
    love.graphics.setCanvas (self.canvas)
        self.canvas:clear (v.backgroundColor)
        -- UI
        self.lui:draw ()
    love.graphics.setCanvas ()
    
    love.graphics.setColor ({255, 255, 255, 255})
    love.graphics.draw (self.canvas, self.cX, self.cY)
    
    
    if self.omLayout.draw ~= nil then
        self.omLayout.draw ()
    end
end

function Settings:keypressed (key)
    -- UI
    self.lui:keypressed (key)
    
    if self.omLayout.keypressed ~= nil then
        self.omLayout.keypressed (key)
    end
end

function Settings:keyreleased (key)
    -- UI
    self.lui:keyreleased (key)
    
    if self.omLayout.keyreleased ~= nil then
        self.omLayout.keyreleased (key)
    end
end

function Settings:mousepressed (x, y, button)
    -- UI
    self.lui:mousepressed (x, y, button)
    
    if self.omLayout.mousepressed ~= nil then
        self.omLayout.mousepressed (x, y, button)
    end
end

function Settings:mousereleased (x, y, button)
    -- UI
    self.lui:mousereleased (x, y, button)
    
    if self.omLayout.mousereleased ~= nil then
        self.omLayout.mousereleased (x, y, button)
    end
end

function Settings:quit ()
    
end

function Settings:enable ()
    self.cX = love.graphics.getWidth ()
    
    self.canvasTween = tween.new (0.15, self, {cX = 0}, 'outExpo')
    
    if self.omLayout.enable ~=nil then
        self.omLayout.enable ()
    end
end

function Settings:disable ()
    
end

function Settings:close ()
    
end