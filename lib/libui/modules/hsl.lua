--[[

]]

HSList = mClass ("HSList")

function HSList:initialize (tbl, kk, vk, width, height, x, y, font)
    self.width = width
    self.height = height

    self.x = x
    self.y = y

    self.kt = "Name:"
    self.vt = "Score:"

    self.kk = kk
    self.vk = vk

    self.currSI = 1
    self.amount = 0
    self.maxAmount = #tbl

    self.table = tbl

    self.font = font

    self.margin = 5

    self.color = {255, 255, 255, 255}

    self.scaleFactor = v.scaleFactor
    self.wheelWalk = v.wheelWalk

    self:reload ()
end

function HSList:reload ()
    self.amount = math.floor (self.height / (self.scaleFactor * (self.font:getHeight() + 2 * self.margin)))
end

function HSList:draw ()
    love.graphics.setColor (self.color)
    love.graphics.setFont (self.font)

    -- draw "score" and "name"
    love.graphics.print (self.kt, self.x, self.y + 0 * self.scaleFactor * self.font:getHeight () + self.scaleFactor * (0 + 1) * self.margin, 0, self.scaleFactor)
    love.graphics.print (self.vt, self.width - self.font:getWidth (self.vt) + self.x, self.y + 0 * self.scaleFactor * self.font:getHeight () + self.scaleFactor * (0 + 1) * self.margin, 0, self.scaleFactor)

    local i = self.currSI
    local a = 1
    while i <= #self.table and a <= self.amount do 
        local xS = self.width - self.font:getWidth (self.table[i][self.vk]) + self.x

        love.graphics.print (self.table[i][self.kk], self.x, self.y + a * self.scaleFactor * self.font:getHeight () + self.scaleFactor * (a + 1) * self.margin, 0, self.scaleFactor)
        love.graphics.print (self.table[i][self.vk], xS, self.y + a * self.scaleFactor * self.font:getHeight () + self.scaleFactor * (a + 1) * self.margin, 0, self.scaleFactor)
        i = i + 1
        a = a + 1
    end
end

function HSList:mousepressed (x, y, button)
    if x >= self.x and x <= (self.x + self.width) then
        if y >= self.y and y <= (self.y + self.height) then
            if button == "wu" then
                self.currSI = self.currSI == 1 and self.currSI or math.max (self.currSI - self.wheelWalk, 1)
            elseif button == "wd" then
                self.currSI = #self.table - self.amount <= 0 and self.currSI or math.min (self.currSI + self.wheelWalk, #self.table - self.amount)
            end
        end
    end
end

function HSList:keypressed (key)
    if key == "up" then
        self:mousepressed (self.x + 2, self.y + 2, "wu")
    elseif key == "down" then
        self:mousepressed (self.x + 2, self.y + 2, "wd")
    end
end
