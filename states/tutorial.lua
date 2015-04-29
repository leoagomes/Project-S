--[[
    Part of code which handles classic mode
]]
Tutorial = mClass ("Settings")

function Tutorial:load ()
    self.tdt = 0
    self.dispTime = v.defTutDisplayTime

    self.image = love.graphics.newImage ("res/images/menu.png")
    self.iX = (love.graphics.getWidth () - self.image:getWidth ()) / 2
    self.iY = (love.graphics.getHeight () - self.image:getHeight ()) / 2

    self.canvasTween = {}

    self.idc = {255, 255, 255, 255}

    self.goAway = false
end

function Tutorial:update (dt)
    local s = self.canvasTween:update (dt)

    self.tdt = self.tdt + dt

    if self.tdt > self.dispTime then
        self:keypressed ("a")
    end

    if self.tdt > self.dispTime - 0.5 then
        self.goAway = true
        self.canvasTween = tween.new (0.3, self.idc, {255, 255, 255, 0})
    end
end

function Tutorial:draw ()
    love.graphics.setColor (self.idc)
    love.graphics.draw (self.image, self.iX, self.iY)
end

function Tutorial:keypressed (key)
    disableState ("tutorial")
    enableState ("menu")
end

function Tutorial:keyreleased (key)
    
end

function Tutorial:mousepressed (x, y, button)
    
end

function Tutorial:mousereleased (x, y, button)
    
end

function Tutorial:quit ()
    
end

function Tutorial:enable ()
    self.idc = {255, 255, 255, 0}
    self.goAway = false
    self.canvasTween = tween.new (0.3, self.idc, {255, 255, 255, 255})
end

function Tutorial:disable ()
    
end

function Tutorial:close ()
    
end
