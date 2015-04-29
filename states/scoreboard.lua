--[[
    Part of code which handles classic mode
]]
Scoreboard = mClass ("Scoreboard")

function Scoreboard:load ()
	-- if comes from a game.
    self.showInsertUI = false

    -- layout
    self.layoutFile = "res/layout/scoreboard.lua"
    self.sbLayout = love.filesystem.load (self.layoutFile) ()
    self.sbLayout.me = self

    -- UI
    self.lui = libui:new ()
    self.sbLayout.ui = self.lui

    -- Canvas
    self.canvas = love.graphics.newCanvas (love.graphics.getWidth (), love.graphics.getHeight ())
    self.cX, self.cY = 0, 0

    -- Layout
    self.sbLayout.start ()

    -- Current Score to register
    self.currentScore = -1
    self.callAfter = "menu"
end

function Scoreboard:update (dt)
	-- UI
    self.lui:update (dt)

    -- Tween
    self.canvasTween:update (dt)
end

function Scoreboard:draw ()
	love.graphics.setCanvas() --(self.canvas)
        self.canvas:clear (v.backgroundColor)
	    self.lui:draw ()
	love.graphics.setCanvas ()

	--love.graphics.setColor ({255, 255, 255, 255})
	--love.graphics.draw (self.canvas, self.cX, self.cY)
end

function Scoreboard:keypressed (key)
    self.lui:keypressed (key)

    if self.sbLayout.keypressed then
        self.sbLayout.keypressed (key)
    end
end

function Scoreboard:keyreleased (key)
    self.lui:keyreleased (key)
end

function Scoreboard:mousepressed (x, y, button)
   	self.lui:mousepressed (x, y, button)
end

function Scoreboard:mousereleased (x, y, button)
    self.lui:mousereleased (x, y, button)
end

function Scoreboard:touchpressed (id, x, y, pressure)
	self.lui:touchpressed (id, x, y, pressure)
end

function Scoreboard:touchreleased (id, x, y, pressure)
	self.lui:touchreleased (id, x, y, pressure)
end

function Scoreboard:textinput (text)
    self.lui:textinput (text)
end

function Scoreboard:quit ()
    
end

function Scoreboard:enable ()
    self.cX = 0
	self.cY = love.graphics.getHeight ()

   	self.canvasTween = tween.new (0.15, self, {cY = 0}, 'outExpo')

    scoreboardSys:reload ()
   	if self.sbLayout.enable then
   		self.sbLayout.enable ()
   	end
end

function Scoreboard:disable ()
    
end

function Scoreboard:close ()
    
end
