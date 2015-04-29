--[[
    Class that handles maps
]]

Map = mClass ("Map")

function Map:initialize (mapScript, tileSize, game)
	self.map = love.filesystem.load (mapScript) ()
    
    self.drawTiles = true
    self.drawGrid = true
    
    -- initialize with default values
    self.typeZeroColor = v.typeZeroColor
    self.typeOneColor = v.typeOneColor
    self.typeTwoColor = v.typeTwoColor
    
    self.typeZeroDraw = v.typeZeroDraw
    self.typeOneDraw = v.typeOneDraw
    self.typeTwoDraw = v.typeTwoDraw
    
    self.tileSize = tileSize
    
    self.game = game
    
    self.foods = {}
end

function Map:removeFood (food)
    for i, v in pairs (self.foods) do
        if v == food then
            table.remove (self.foods, i)
            return true
        end    
    end
    return false
end

function Map:addFoodWithCoordinates (food)
    if self.map.map[food.y][food.x] ~= 0 then
        table.insert (self.foods, food)
        return food
    end
    return false
end

function Map:addFood (food)
    -- generate a random location on  the map
    local available = self:availableTiles ()
    local place = love.math.random (1, available)
    
    for i, v in pairs (self.map.map) do
        for j, k in pairs (v) do
            if k == 0 and self.game.snake:bodyContains ({x = j, y = i}) == false and self:tileHasFood ({x = j, y = i}) == false then
                place = place - 1
            end
            if place == 0 then
                food.x = j 
                food.y = i
                
                table.insert (self.foods, food)
                
                -- probably the best approach
                self.game:addFood (food)
                
                food:addToMap (self)
                return food
            end
        end
    end
    
    table.insert (self.foods, {food})
end

function Map:tileHasFood (coordinates)
    for i, v in pairs (self.foods) do
        if coordinates.x == v.x and coordinates.y == v.y then
            return v
        end
    end
    return false
end

function Map:getTile (coordinates)
    local x, y = 0, 0
    
    if coordinates.x == nil then
        x, y = coordinates[1], coordinates[2]
    else
        x, y = coordinates.x, coordinates.y
    end
    
	return self.map.map[y][x]
end

function Map:availableTiles ()
	local count = 0
	for i, v in pairs (self.map.map) do
		for j, k in pairs (v) do
            if k == 0 then
                if not self.game.snake:bodyContains ({x = j, y = i}) and not self:tileHasFood ({x = j, y = i}) then
                    count = count + 1
                end
            end
        end
	end
	return count
end

function Map:update (dt)
    
end

function Map:reloadMap (newMapFile)
    self.map = love.filesystem.load (newMapFile) ()
end

function Map:draw ()
    if self.drawTiles then
        for i, v in pairs (self.map.map) do
            for j, val in pairs (v) do
                if val == 0 and self.drawGrid then
                    love.graphics.setColor (self.typeZeroColor)
                    love.graphics.rectangle (self.typeZeroDraw, (j - 1) * self.tileSize, (i - 1) * self.tileSize, self.tileSize, self.tileSize)
                elseif val == 1 then
                    love.graphics.setColor (self.typeOneColor)
                    love.graphics.rectangle (self.typeOneDraw, (j - 1) * self.tileSize, (i - 1) * self.tileSize, self.tileSize, self.tileSize)
                elseif val == 2 then
                    love.graphics.setColor (self.typeTwoColor)
                    love.graphics.rectangle (self.typeTwoDraw, (j - 1) * self.tileSize, (i - 1) * self.tileSize, self.tileSize, self.tileSize)
                end
            end
        end
    end
end
