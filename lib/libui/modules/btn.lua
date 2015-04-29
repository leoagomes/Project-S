mClass = require "lib.middleclass"

Button = mClass ("Button")

function Button:initialize (text, x, y, font, id)
	self.x = x
	self.y = y
    
	self.text = text
	self.id = id

    self.font = font
    
    self.selectedColor = {154, 205, 50, 255}
	self.clickColor = {154, 205, 50, 255}
	self.textColor = {255, 255, 255, 255}
	self.ctextColor = self.textColor

	self.whenToCall = "press"
    
    self.drawInner = true
    
	self.width = self.font:getWidth (text) * v.scaleFactor
    self.height = self.font:getHeight () * v.scaleFactor

    -- for tab order
    self.index = -100
    self.selected = false

    self.scaleFactor = v.scaleFactor -- this is called being lazy
end

function Button:mousereleased ( x, y, button )
	self.ctextColor = self.textColor

	if self.whenToCall == "release" and self.onClick ~= nil then
		if x >= self.x and x <= (self.x + self.width) then
			if y >= self.y and y <= (self.y + self.height) then
				self.onClick (x, y, button, self)
			end
		end
	end
end

function Button:mousepressed ( x, y, button )
	if x >= self.x and x <= (self.x + self.width) then
		if y >= self.y and y <= (self.y + self.height) then
			self.ctextColor = self.clickColor
			
			if self.onClick ~= nil and self.whenToCall == "press" then
                self.onClick (x, y, button, self)
			end
		end
	end
end

function Button:draw (  )
	-- Draw text
	if self.text ~= "" and self.text ~= nil then
		graphics.setColor (self.ctextColor)
        graphics.setFont (self.font)
		graphics.print (self.text, self.x, self.y, 0, self.scaleFactor)
	end
end

function Button:drawXY ( x, y )
	self.x = x
	self.y = y
	self:draw ()
end

function Button:update ( dt )
	--	find coordinates and if is over the button, call on hover
	local x = love.mouse.getX ()
	local y = love.mouse.getY ()

	if self.selected then
		self.ctextColor = self.selectedColor
	else
		self.ctextColor = self.textColor
	end

	if x >= self.x and x <= (self.x + self.width) then
		if y >= self.y and y <= (self.y + self.height) and self.onHover ~= nil then
			self.onHover (x, y, self)
		end
	end
end

function Button:changeText (text)
    self.text = text
    
    self.width = self.font:getWidth (text)
    self.height = self.font:getHeight ()
end

function Button:changeFont (font)
    self.font = font
    
    self.width = self.font:getWidth (text)
    self.height = self.font:getHeight ()
end

function Button:keypressed ( key )
	if self.selected and (key == "return" or key == "enter" or key == "space") then
		self.onClick (love.mouse.getX (), love.mouse.getY (), "l", self)
	end
end