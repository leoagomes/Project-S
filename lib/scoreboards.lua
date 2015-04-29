--[[
    The (not online atm) scoreboard system
]]
require ("lib.Tserial")

ScoreboardSystem = mClass ("ScoreboardSystem")

function ScoreboardSystem:initialize (sbFile) -- , mode)
    self.sbFile = sbFile
    -- self.mode = mode -- "online"/"offline" -- useful in the future

    self.sb = {}
    self:load ()
end

function ScoreboardSystem:getScores ()
    return self.sb
end

function ScoreboardSystem:setScore (name, score)
    -- basic sb structure:
    -- {{"name", score}, ..} -- hopefully ordered
    
    for i, v in pairs (self.sb) do
        if score > v["score"] then
            print (inspect (i))
            table.insert (self.sb, i, {["name"] = name, ["score"] = score})
            return
        end
    end

    table.insert (self.sb, {["name"] = name, ["score"] = score})
end

function ScoreboardSystem:save ()
    love.filesystem.write(self.sbFile, Tserial.pack (self.sb, function () end, false))
end

function ScoreboardSystem:load ()
    local data = love.filesystem.read (self.sbFile)

    self.sb = data ~= nil and Tserial.unpack (data, true) or {}
end

function ScoreboardSystem:reload ()
    self:save ()
    self:load ()
end
