--[[
	Base framework for working with boosts or just basic points
]]

Food = mClass ("Food")

function Food:initialize (fScript, game)
    self.x = -10
    self.y = -10
    
	self.game = game
    
    if fScript == "normal" then
        self.food = {}
    else
        self.food = love.filesystem.load (fScript) ()
        self.food.game = game
        self.food.me = self
        
        self.food.init ()
    end
    
	self.worth = v.defFoodValue
    
    self.shouldDraw = true
    
    self.color = v.defFoodColor
    self.bcolor = v.defFoodBorderColor
    self.drawMode = v.defFoodDrawMode
end

function Food:ate (snake)
	if self.food.ate ~= nil then
		self.food.ate (snake)
	else
		self.game:addPoints (self.worth)
        self.game.map:removeFood (self)
        self.game:removeFood (self)
        
        local nf = Food:new ("normal", self.game)
        self.game.map:addFood (nf)
        
        self = nf
	end
end

function Food:addToMap (map)
    if self.food.addToMap ~= nil then
        self.food.addToMap (map)
    end
end

function Food:update (dt)
    if self.food.update ~= nil then
        self.food.update (dt)
    end
end

function Food:draw ()
    if not self.shouldDraw then
            return
    end
    
    if self.food.draw ~= nil then
        self.food.draw ()
    else
        local color = (self.food.color ~= nil) and self.food.color or self.color
        local bcolor = (self.food.bcolor ~= nil) and self.food.bcolor or self.bcolor
        local drawMode = (self.food.drawMode ~= nil) and self.food.drawMode or self.drawMode
        
        local ts = self.game.map.tileSize
        
        love.graphics.setColor (color)
        love.graphics.rectangle (drawMode, (self.x - 1) * ts, (self.y - 1) * ts, ts, ts)
        
        love.graphics.setColor (bcolor)
        love.graphics.rectangle ("line", (self.x - 1) * ts, (self.y - 1) * ts, ts, ts)
    end
end

function Food:keypressed (key)
    
end

function Food:kill ()
    if self.food.kill ~= nil then
        self.food.kill ()
    else
        self.game.map:removeFood (self)
        self.game:removeFood (self)
    end
end
