--[[
    Key-Value pair list
]]

KVList = mClass ("KVList")

function KVList:initialize (table, keyK, valK, width, height, x, y, font)
    self.list = table
    self.kK = keyK
    self.vK = valK

    self.margin = 5 * v.scaleFactor--pixels

    self.touching = false
    self.touchid = -2
    self.t0pos = {0, 0}

    self.font = font
    self.color = {255, 255, 255, 255}
    self.cellColor = {0, 0, 0, 70}
    self.borderColor = {0, 0, 0, 255}

    self.maxfipos = {0, 0}
    self.minfipos = {0, 0}

    self.fipos = {0, 0}

    self.scale = v.scaleFactor

    self.wheelWalk = v.wheelWalk

    self.canvas = love.graphics.newCanvas (width, height)

    self.pos = {x, y}

    self.width = width
    self.height = height
end

function KVList:loadLastSize ()
	self.minfipos[2] = math.min(self.pos[2], self.pos[2] - (self.height - #self.list * (self.font:getHeight () + 2 * self.margin)))
end

function KVList:load (table)
	self.list = table
	self:loadLastSize ()
end

function KVList:draw ()
    love.graphics.setCanvas (self.canvas)
        self.canvas:clear (v.backgroundColor)

        love.graphics.setColor ({0, 0, 0, 170})
        love.graphics.rectangle ("line", 0, 0, self.width, self.height)

        love.graphics.setFont (self.font)
        love.graphics.setColor (self.color)

        for i,v in pairs(self.list) do
            -- draw cell i
            local xK = self.fipos[1] + margin
            local yA = (i - 1) * (self.font:getHeight () * self.scale + 2 * self.margin) + self.fipos[2]
            local xV = self.width - self.font:getWidth (v[self.vK]) * self.scale

            -- draw bg
            love.graphics.setColor (self.cellColor)
            love.graphics.rectangle ("fill", self.fipos, yA, self.width, self.font:getHeight () + 2 * self.margin)
            love.graphics.setColor (self.borderColor)
            love.graphics.rectangle ("line", self.fipos, yA, self.width, self.font:getHeight () + 2 * self.margin)
            -- draw key
            love.graphics.print (v[self.kK], xK, yA, 0, self.scale)
            -- draw value
            love.graphics.print (v[self.vK], xV, yA, 0, self.scale)
        end
    love.graphics.setCanvas ()

    love.graphics.setColor ({255, 255, 255, 255})
    love.graphics.draw (self.canvas, self.pos[1], self.pos[2])
end

function KVList:mousepressed (x, y, button)
	if button == "wu" then
        self.fipos[2] = math.min (self.maxfipos[2], self.fipos[2] + self.wheelWalk * (self.font:getHeight () + self.margin))
	elseif button == "wd" then
        self.fipos[2] = math.max (self.minfipos[2], self.fipos[2] - self.wheelWalk * (self.font:getHeight () + self.margin))
	elseif self.touchid == -2 and (button == "l" or button == "right") then
		self.t0pos = {x, y}
	end
end

function KVList:mousereleased (x, y, button)
	if self.touchid == -2 and (button == "l" or button == "r") then
		-- take into account only Y delta
		local ydelta = y - self.t0pos[2]

		if self.fipos[2] < self.minfipos[2] then
			self.fipos[2] = math.min (self.fipos[2] - self.minfipos[2], self.fipos[2] + ydelta)
		end
	end	
end

function KVList:mousemoved (x, y, dx, dy)
	if self.touchid ~= -2 then
		return
	end

	-- take into account only Y delta
	local ydelta = dy

	if self.fipos[2] < self.minfipos[2] then
		self.fipos[2] = math.min (self.fipos[2] - self.minfipos[2], self.fipos[2] + ydelta)
	end
end

function KVList:touchpressed (id, x, y, pressure)
	if self.touchid ~= -2 then
		return
	end

	self.touchid = id
	self.t0pos = {x, y}
end

function KVList:touchmoved (id, x, y, pressure)
	if id ~= self.touchid then
		return
	end

	-- take into account only Y delta
	local ydelta = y - self.t0pos[2]

	if self.fipos[2] < self.minfipos[2] then
		self.fipos[2] = math.min (self.fipos[2] - self.minfipos[2], self.fipos[2] + ydelta)
	end
end

function KVList:touchreleased (id, x, y, pressure)	
	if id ~= self.touchid then
		return
	end

	-- take into account only Y delta
	local ydelta = y - self.t0pos[2]

	if self.fipos[2] < self.minfipos[2] then
		self.fipos[2] = math.min (self.fipos[2] - self.minfipos[2], self.fipos[2] + ydelta)
	end

	self.touchid = -2
end
