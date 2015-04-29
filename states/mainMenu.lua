--[[
    Part of code which handles menu
]]
require ("lib.libui")

MainMenu = mClass ("MainMenu")

function MainMenu:load ()
	self.menuFile = "res/layout/mainMenu.lua"
    self.mLayout = love.filesystem.load (self.menuFile) ()
    
    self.ui = libui:new ()
    
    -- mLayout again
    self.mLayout.ui = self.ui
    self.mLayout.me = self
    self.mLayout.start ()
end

function MainMenu:update (dt)
    -- UI
    self.ui:update (dt)
end

function MainMenu:draw ()
    -- UI
    self.ui:draw ()
end

function MainMenu:keypressed (key)
    -- UI
    self.ui:keypressed (key)
end

function MainMenu:keyreleased (key)
    -- UI
    self.ui:keyreleased (key)
end

function MainMenu:mousepressed (x, y, button)
    -- UI
    self.ui:mousepressed (x, y, button)
end

function MainMenu:mousereleased (x, y, button)
    -- UI
    self.ui:mousereleased (x, y, button)
end

function MainMenu:quit ()
    -- UI
end

function MainMenu:enable ()
    
end

function MainMenu:disable ()
    
end

function MainMenu:close ()
    
end
