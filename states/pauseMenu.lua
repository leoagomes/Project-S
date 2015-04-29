--[[
    Part of code which handles pause staet
]]
require ("lib.libui")

PauseMenu = mClass ("PauseMenu")

function PauseMenu:load ()
    self.pmLayoutFile = "res/layout/pauseMenu.lua"
    self.pmLayout = love.filesystem.load (self.pmLayoutFile) ()
    
    -- UI
    self.lui = libui:new ()
    
    self.pmLayout.me = self
    self.pmLayout.lui = self.lui
    
    self.pmLayout.start ()
    
    -- needed so pause won't instantly disable pause state
    self.pause = false
    
    -- canvas for transitions
    self.canvas = love.graphics.newCanvas(love.graphics.getWidth (), love.graphics.getHeight ())
    self.cx = 0
    self.cy = 0
    
    -- for better transitions
    self.shouldContinue = false
    
    -- useful for options menu.
    self.drawUI = true
end

function PauseMenu:update (dt)
    self.lui:update (dt)
    
    -- tween - for animations
    local s = self.canvasTween:update (dt)
    
    if s and self.shouldContinue then
        achievementSys.currentState = "game"
        self.game.executing = true
        self.game.song:unpause ()
        disableState ("pause")
        
        self.shouldContinue = false
    end
end

function PauseMenu:draw ()
    love.graphics.setCanvas (self.canvas)
        self.canvas:clear (v.pauseMenuClearColor)
        if self.drawUI then
            self.lui:draw ()
        end
    love.graphics.setCanvas ()
    
    love.graphics.setColor ({255, 255, 255, 255})
    love.graphics.draw (self.canvas, self.cX, self.cY)
end

function PauseMenu:keypressed (key)
    -- UI
    self.lui:keypressed (key)
    
    if (key == v.pauseKey or key == "escape") and self.ghost == false then
        pMenu.me.shouldContinue = true
        pMenu.me.canvasTween = tween.new (0.15, pMenu.me, {cY = love.graphics.getHeight ()}, 'outExpo')
    end
end

function PauseMenu:keyreleased (key)
    -- UI
    self.lui:keyreleased (key)
    
    if self.ghost then
        self.ghost = false
    end
end

function PauseMenu:mousepressed (x, y, button)
    -- UI
    self.lui:mousepressed (x, y, button)
end

function PauseMenu:mousereleased (x, y, button)
    -- UI
    self.lui:mousereleased (x, y, button)
end

function PauseMenu:quit ()
    
end

function PauseMenu:enable ()
    -- canvas pos
    self.cX = 0
    self.cY = love.graphics.getWidth ()
    
    self.canvasTween = tween.new (0.15, self, {cY = 0}, 'outExpo')

    love.mouse.setVisible (true)
end

function PauseMenu:disable ()
    
end

function PauseMenu:close ()
    
end
