--[[
    Part of code which handles mode selection menu
]]
require ("lib.libui")

ModeSelection = mClass ("ModeSelection")

function ModeSelection:load ()
	self.menuFile = "res/layout/modeSel.lua"
    self.mLayout = love.filesystem.load (self.menuFile) ()
    
    self.ui = libui:new ()
    
    -- mLayout again
    self.mLayout.ui = self.ui
    self.mLayout.me = self
    self.mLayout.start ()
    
    -- canvas for animations
    self.cX = 0
    self.cY = 0
    
    self.canvas = love.graphics.newCanvas (love.graphics.getWidth (), love.graphics.getHeight ())
end

function ModeSelection:update (dt)
    -- UI
    self.ui:update (dt)
    
    -- Canvas Animation
    self.canvasTween:update (dt)
end

function ModeSelection:draw ()
    love.graphics.setCanvas (self.canvas)
        self.canvas:clear (v.backgroundColor)
        -- UI
        self.ui:draw ()
    love.graphics.setCanvas ()
    
    love.graphics.setColor ({255, 255, 255, 255})
    love.graphics.draw (self.canvas, self.cX, self.cY)
end

function ModeSelection:keypressed (key)
    -- UI
    self.ui:keypressed (key)
end

function ModeSelection:keyreleased (key)
    self.ui.buttonsToKeys = true

    -- UI
    self.ui:keyreleased (key)
end

function ModeSelection:mousepressed (x, y, button)
    -- UI
    self.ui:mousepressed (x, y, button)
end

function ModeSelection:mousereleased (x, y, button)
    -- UI
    self.ui:mousereleased (x, y, button)
end

function ModeSelection:quit ()
    -- UI
end

function ModeSelection:enable ()
    if self.mLayout.enable ~= nil then
        self.mLayout.enable ()
    end

    self.ui.buttonsToKeys = true
    self.ui.cbIndex = 3

    self.cX = love.graphics.getWidth ()
    self.canvasTween = tween.new (0.15, self, {cX = 0}, 'outExpo')
end

function ModeSelection:disable ()
    self.ui.buttonsToKeys = false
    self.ui:unselect ()

    if self.mLayout.disable then
        self.mLayout.disable ()
    end
end

function ModeSelection:close ()
    
end
