--[[
    Progress Bar
--]]

ProgressBar = mClass ("ProgressBar")

function ProgressBar:initialize (x, y, width, height, border, clickable)
    self.scaleFactor = v.scaleFactor -- and another lazy moment time :)

    self.x = x
    self.y = y
    
    self.width = width * self.scaleFactor
    self.height = height * self.scaleFactor
    
    self.border = border * self.scaleFactor
    self.clickable = clickable
    
    self.value = 1
    self.btnPressed = false
    
    self.innerWidth = self.width - 2 * self.border
    self.innerHeight = self.height - self.border * 2
    
    self.innerColor = {255, 255, 255, 255}
    self.innerbgColor = {0, 0, 0, 255}
    self.borderColor = {255, 255, 255, 150}
    
    self.onRelease = function (val) end
end

function ProgressBar:update (dt)
    if self.btnPressed then
        self.innerWidth = math.min(math.max (0, love.mouse.getX () - self.x - self.border), self.width - 2 * self.border)
    else
        self.innerWidth = self.value * (self.width - 2 * self.border)
    end
end

function ProgressBar:draw ()
    -- border
    love.graphics.setColor (self.borderColor)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    
    -- inner bg
    love.graphics.setColor (self.innerbgColor)
    love.graphics.rectangle("fill", self.x + self.border, self.y + self.border, self.width - 2 * self.border, self.height - 2 * self.border)
    
    love.graphics.setColor (self.innerColor)
    love.graphics.rectangle("fill", self.x + self.border, self.y + self.border, self.innerWidth, self.height - 2 * self.border)
end

function ProgressBar:mousepressed (x, y, button)
    if not self.clickable then
        return
    end
    
    if x >= self.x and x <= (self.x + self.width) then
		if y >= self.y and y <= (self.y + self.height) then
            self.btnPressed = true
		end
	end
end

function ProgressBar:mousereleased (x, y, button)
    if not self.clickable then
        return
    end
    
    if self.btnPressed then
        self.btnPressed = false
        self.value = self.innerWidth / (self.width - 2 * self.border)
        self.onRelease (self:getValue ())
    end
end

function ProgressBar:getValue ()
    return self.innerWidth / (self.width - 2 * self.border)
end