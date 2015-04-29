--[[
    Represents a snake/player
]]
Snake = mClass ("Snake");

function Snake:initialize (body, map, game)
    self.body = body -- {{x, y}, {x, y}, ...}
    self.direction = "r" -- up, down, left, right
    
    self.totaldt = 0
    self.cycledt = 0
    
    self.speed = v.defSnakeSpeed
    self.spdiv = v.defSnakeDiv
    
    self.stopped = false
    self.shouldDraw = true
    
    self.snakeColor = v.defSnakeColor
    self.tileSize = v.tileSize
    
    self.snakeDraw = v.defSnakeDraw
    self.map = map
    
    self.game = game
    
    self.disabled = false
    
    self.baseSpeedPoints = 0

    -- mercy
    self.maxMercy = 5 -- ticks of wall hit
    self.currMercy = 0

    -- touch
    self.touchId = -2 -- arbitrary
    self.touchIXY = {0, 0}
end

function Snake:setDirection (direction)
    self.direction = direction
end

function Snake:update (dt)
    self.totaldt = self.totaldt + dt
    self.cycledt = self.cycledt + dt
    
    if self.stopped then
        return
    end
    
    if self.cycledt >= (self.spdiv / self.speed) then
        -- move and get back to 0
        local tile = {}
        if self.direction == "u" then
            tile = {x = self.body[1].x, y = self.body[1].y - 1}
        elseif self.direction == "d" then
            tile = {x = self.body[1].x, y = self.body[1].y + 1}
        elseif self.direction == "l" then
            tile = {x = self.body[1].x - 1, y = self.body[1].y}
        elseif self.direction == "r" then
            tile = {x = self.body[1].x + 1, y = self.body[1].y}
        end
        
        
        local bc = self:bodyContains (tile)
        local mt = self.map:getTile (tile)
        
        if mt == 2 and not bc then
            -- teleport to other side of map
            -- if hit floor, go to roof
            if tile.y == self.map.map.height then
                tile.y = 2 -- since 1 will, most likely be another thing
            elseif tile.y == 1 then
                tile.y = self.map.map.height - 1
            elseif tile.x == self.map.map.width then
                tile.x = 2
            elseif tile.x == 1 then
                tile.x = self.map.map.width - 1
            end
            
            table.insert (self.body, 1, tile)
            local ftile = self.map:tileHasFood (tile)
            
            if not ftile then
                table.remove (self.body, #self.body)
            else 
                ftile:ate (self)
            end
            
            -- Unlock "What Goes Around"
            achievementSys:unlock ("whatGoesAround", true)
        end
        
        if mt == 0 and not bc then
            table.insert (self.body, 1, tile)
            local ftile = self.map:tileHasFood (tile)
            
            if not ftile then
                table.remove (self.body, #self.body)
            else 
                ftile:ate (self)
                self.game.foodEaten = self.game.foodEaten + 1
            end

            self.currMercy = 0
        elseif mt == 1 then
            if self.currMercy == self.maxMercy then
                self.game:terminate ("wall")
            else
                self.currMercy = self.currMercy + 1
            end
        end
        
        if bc then
            if self.currMercy == self.maxMercy then
                self.game:terminate ("body")
            else
                self.currMercy = self.currMercy + 1
            end
        end
        
        self.cycledt = 0
    end
end

function Snake:bodyContains (coordinates)
    for i,v in pairs (self.body) do
        if coordinates.x ~= nil then
            if v.x == coordinates.x and v.y == coordinates.y then
                return true
            end
        end
        if v.x == coordinates[1] and v.y == coordinates[2] then
            return true
        end
    end
    return false
end

function Snake:draw ()
    if self.shouldDraw then
        love.graphics.setColor (self.snakeColor)
        for i, v in pairs (self.body) do
            if i == 1 then
                love.graphics.rectangle (self.snakeDraw, (v.x - 1) * self.tileSize, (v.y - 1) * self.tileSize, self.tileSize, self.tileSize)
                love.graphics.setColor (self.snakeColor)
            else
                love.graphics.rectangle (self.snakeDraw, (v.x - 1) * self.tileSize, (v.y - 1) * self.tileSize, self.tileSize, self.tileSize)
            end
        end
    end
end

function Snake:keypressed (key)
    if self.disabled then
        return
    end
    
    if key == v.upKey and not (self.body[1].x == self.body[2].x and self.body[1].y == (self.body[2].y + 1)) then
        self.direction = "u"
    elseif key == v.downKey and not (self.body[1].x == self.body[2].x and self.body[1].y == (self.body[2].y - 1)) then
        self.direction = "d"
    elseif key == v.rightKey and not (self.body[1].x == (self.body[2].x - 1) and self.body[1].y == self.body[2].y) then
        self.direction = "r"
    elseif key == v.leftKey and not (self.body[1].x == (self.body[2].x + 1) and self.body[1].y == self.body[2].y) then
        self.direction = "l"
    end
end

function Snake:touchpressed (id, x, y, pressure)
    if self.touchId ~= -2 then
        return
    end

    self.touchId = id
    self.touchIXY = {x, y}
end

function Snake:touchreleased (id, x, y, pressure)
    if self.touchId ~= id then
        return
    end

    self.touchId = -2

    local delta_x = (x - self.touchIXY[1]) -- * love.graphics.getWidth ()
    local delta_y = (y - self.touchIXY[2])

    if math.abs(delta_y) > math.abs(delta_x) then
        if math.abs (delta_y) == delta_y then
            self:keypressed (v.downKey)
        else
            self:keypressed (v.upKey)
        end
    else
        if math.abs (delta_x) == delta_x then
            self:keypressed (v.rightKey)
        else
            self:keypressed (v.leftKey)
        end
    end
end