--[[
    Options file manager
]]
require "lib.Tserial"

OptionsManager = mClass ("OptionsManager")

function OptionsManager:initialize (optFile, valTable)
    self.opT = {}
    self.optFile = optFile
    
    if love.filesystem.exists (optFile) then
        self.opT = Tserial.unpack (love.filesystem.read (optFile), function (data) end)
    end
    
    self.valTable = valTable
end

function OptionsManager:save ()
    love.filesystem.write (self.optFile, Tserial.pack (self.opT, function (data) return "" end, false))
end

function OptionsManager:setOpt (key, val)
    self.opT[key] = val
end

function OptionsManager:getAll ()
    return self.opT
end

function OptionsManager:getOpt (key)
    return self.opT[key]
end

function OptionsManager:replace ()
    for i, v in pairs (self.opT) do
        self.valTable[i] = v
    end
end