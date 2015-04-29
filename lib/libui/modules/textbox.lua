mClass = require "lib.middleclass"

TextBox = mClass ("TextBox")

function TextBox:initialize (x, y, w, h, htext, pass)
	self.x = x
	self.y = y
	self.width = w * v.scaleFactor
	self.height = h * v.scaleFactor
	
	self.content = ""
	self.hint = htext ~= nil and htext or ""
	
	self.passwordMode = pass ~= nil and pass or false
	
	self.hasFocus = false
	
	self.gotFocus = nil -- set to a function that will be called when got focus.
	self.lostFocus = nil -- same as above, but when lost focus
	
	self.textColor = {255, 255, 255, 255}
	self.hintColor = {120, 120, 120, 255}
	
	self.border = 0 -- pixels
	
	self.trx = 0
	self.try = 0
	self.tallign = "center"
	
	self.tFont = love.graphics.getFont ()
	self.controlDown = false

	self.visible = true

    self.limit = 16
end

function TextBox:update (dt)
	self.trx = self.border
	self.try = (self.height - self.tFont:getHeight ()) / 2
end

function TextBox:draw ()
	if not self.visible then
		return
	end

	-- Draw hint text
	if not self.hasFocus and self.content == "" and self.hint ~= "" then
		love.graphics.setColor (self.hintColor)
		love.graphics.setFont (self.tFont)
		love.graphics.printf (self.hint, self.trx + self.x, self.try + self.y, self.width - (2 * self.border), self.tallign, 0, v.scaleFactor)
	end

	if self.content ~= "" then
		love.graphics.setColor (self.textColor)
		love.graphics.setFont (self.tFont)
		love.graphics.printf (self.content, self.trx + self.x, self.try + self.y, self.width - (2 * self.border), self.tallign, 0, v.scaleFactor)
	end
end

function TextBox:drawXY (x, y)
	self.x = x
	self.y = y
	self:draw ()
end

function TextBox:setSize (w, h)
	self.width = w
	self.height = h
end

function TextBox:textinput (text)
	if not self.visible then
		return
	end

	if self.hasFocus and #self.content < self.limit then
		self.content = self.content .. text
	end
end

function TextBox:keypressed (key)
	if not self.visible then
		return
	end

	if self.hasFocus then 
		if key == "backspace" then
			self.content = self.content:sub (1, self.content:len () - 1)
		elseif key == "enter" or key == "return" then
			if self.onReturn ~= nil then
				self.onReturn (self.content)
			end
		end
	end
end

function TextBox:keyreleased (key)
	if not self.visible then
		return
	end

	if self.hasFocus then
		if key == "control" then
			self.controlDown = false
		end
	end
end

function TextBox:mousepressed (x, y, button)
	if not self.visible then
		return
	end

	if x >= self.x and x <= (self.x + self.width) then
		if y >= self.y and y <= (self.y + self.height) then
			if self.hasFocus == false and self.gotFocus ~= nil then
				self:gotFocus ()
			end
			self.hasFocus = true
		else
			if self.hasFocus == true and self.lostFocus ~= nil then
				self:lostFocus ()
			end
			self.hasFocus = false
		end

		if love.keyboard.setTextInput then
			love.keyboard.setTextInput (true)
		end
	else
		if self.hasFocus == true and self.lostFocus ~= nil then
			self:lostFocus ()
		end
		self.hasFocus = false

		if love.keyboard.setTextInput then
			love.keyboard.setTextInput (false)
		end
	end
end

function TextBox:mousereleased (x, y, button)
	
end
