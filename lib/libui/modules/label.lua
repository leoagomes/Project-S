mClass = require ("lib.middleclass")
Label = mClass ("Label")

function Label:initialize  (text, x, y)
    self.text = text
    self.x = x
    self.y = y
    
    self.font = love.graphics.getFont ()
    self.color = {255, 255, 255, 255}
    self.shouldDraw = true
    self.rotation = 0
    self.scale = v.scaleFactor -- this is also called being lazy
end

function Label:draw ()
    if self.shouldDraw then
        love.graphics.setColor (self.color)
        love.graphics.setFont (self.font)
        love.graphics.print (self.text, self.x, self.y, self.rotation, self.scale)
    end
end