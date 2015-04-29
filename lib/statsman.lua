--[[
    The Stats manager
]]

StatsManager = mClass ("StatsManager")

function StatsManager:initialize (statsFile)
    self.sFileName = statsFile
    
    if love.filesystem.read (statsFile) == nil then
        self.sFile = {}
    else
        self.sFile = Tserial.unpack (love.filesystem.read (statsFile))
    end
end

function StatsManager:setStat (key, value)
    self.sFile[key] = value
end

function StatsManager:addValue (key, value)
    if type(self.sFile[key]) == "table" then
        table.insert (self.sFile[key], value)
    else
        self.sFile[key] = {self.sFile[key], value}
    end
end

function StatsManager:getAll ()
    return self.sFile
end

function StatsManager:clearAll ()
    for i, v in pairs (self.sFile) do
        self.sFile[i] = nil
    end
end

function StatsManager:getValue (key)
    local val = self.sFile[key]
    if val == nil then
        return 0
    else
        return val
    end
end

function StatsManager:addToValue (key, addVal)
    if type(self.sFile [key]) == "number" then
        self.sFile[key] = self.sFile [key] + addVal
    elseif type (self.sFile [key]) == "string" then
        self.sFile[key] = self.sFile[key] .. addVal
    elseif type (self.sFile [key]) == "table" then
        table.insert (self.sFile[key], addVal)
    elseif type (self.sFile[key] == "nil") then
        self.sFile[key] = addVal
    end
end

function StatsManager:save ()
    love.filesystem.write (self.sFileName, Tserial.pack (self.sFile))
end