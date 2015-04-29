stats = {}

sprops = {
    ["sltext"] = "Stats",
    ["slfont"] = "res/fonts/5x5_square.ttf",
    ["sltop"] = 50,
    ["slfsize"] = 30,
    ["stfont"] = "res/fonts/5x5_square.ttf",
    ["stfsize"] = 22,
    ["attext"] = "All Time",
    ["toptext"] = "Top",
    ["stext"] = "Score:",
    ["ttext"] = "Time:",
    ["ftext"] = "Food:",
    ["btnfsize"] = 24,
    ["abtext"] = "Achievements",
    ["sbtext"] = "Scoreboards",
    ["bbtext"] = "Back",
    ["bmargin"] = 10,
    ["blmargin"] = 100,
    ["fltop"] = 180,
    ["lleft"] = 150,
    ["cpleft"] = 150
}

function stats.start ()
    -- UI Stats Label
    stats.lfont = love.graphics.newFont (sprops.slfont, sprops.slfsize)
    
    stats.sl = Label:new (sprops.sltext, (love.graphics.getWidth () - stats.lfont:getWidth (sprops.sltext)) / 2, sprops.sltop)
    stats.sl.font = stats.lfont
    
    stats.ui:addObject (stats.sl)
    
    -- Labels which represent stats
    stats.nlfont = love.graphics.newFont (sprops.stfont, sprops.stfsize)
    
    -- Rows
    -- Score
    stats.srl = Label:new (sprops.stext, sprops.lleft, sprops.fltop + stats.nlfont:getHeight () + sprops.bmargin)
    stats.srl.font = stats.nlfont
    stats.ui:addObject (stats.srl)
    -- Time
    stats.trl = Label:new (sprops.ttext, sprops.lleft, sprops.fltop + 2 * stats.nlfont:getHeight () + 2 * sprops.bmargin)
    stats.trl.font = stats.nlfont
    stats.ui:addObject (stats.trl)
    -- Food
    stats.frl = Label:new (sprops.ftext, sprops.lleft, sprops.fltop + 3 * stats.nlfont:getHeight () + 3 * sprops.bmargin)
    stats.frl.font = stats.nlfont
    stats.ui:addObject (stats.frl)
    
    -- Columns
    -- All Time
    stats.atl = Label:new (sprops.attext, sprops.lleft + sprops.cpleft, sprops.fltop)
    stats.atl.font = stats.nlfont
    stats.ui:addObject (stats.atl)
    -- Top
    stats.atl = Label:new (sprops.toptext, stats.nlfont:getWidth (sprops.attext) + sprops.blmargin + sprops.lleft + sprops.cpleft, sprops.fltop)
    stats.atl.font = stats.nlfont
    stats.ui:addObject (stats.atl)
    
    -- Values
    -- All Time Score
    local score = stats.valOrZero ("allTimeScore")
    stats.ats = Label:new (score, sprops.lleft + sprops.cpleft + (stats.lfont:getWidth (sprops.attext) - stats.lfont:getWidth (score)) / 2 , sprops.fltop + stats.nlfont:getHeight () + sprops.bmargin)
    stats.ats.font = stats.nlfont
    stats.ui:addObject (stats.ats)
    -- Top Score
    local tscore = stats.valOrZero ("topScore")
    stats.ts = Label:new (tscore, sprops.lleft + sprops.cpleft + stats.lfont:getWidth (sprops.attext) + sprops.blmargin - stats.lfont:getWidth (tscore), sprops.fltop + stats.nlfont:getHeight () + sprops.bmargin)
    stats.ts.font = stats.nlfont
    stats.ui:addObject (stats.ts)
    -- All Time Game Time
    local time = stats.valOrZero ("allTimeGameTime")
    stats.att = Label:new (time, sprops.lleft + sprops.cpleft + (stats.lfont:getWidth (sprops.attext) - stats.lfont:getWidth (time)) / 2 , sprops.fltop + 2 * stats.nlfont:getHeight () + 2 * sprops.bmargin)
    stats.att.font = stats.nlfont
    stats.ui:addObject (stats.att)
    -- Top Game Time
    local ttime = stats.valOrZero ("topTime")
    stats.tt = Label:new (ttime, sprops.lleft + sprops.cpleft + stats.lfont:getWidth (sprops.attext) + sprops.blmargin - stats.lfont:getWidth (ttime), sprops.fltop + 2 * stats.nlfont:getHeight () + 2 * sprops.bmargin)
    stats.tt.font = stats.nlfont
    stats.ui:addObject (stats.tt)
    -- All Time Food Eaten
    local food = stats.valOrZero ("allTimeFood")
    stats.atf = Label:new (food, sprops.lleft + sprops.cpleft + (stats.lfont:getWidth (sprops.attext) - stats.lfont:getWidth (food)) / 2 , sprops.fltop + 3 * stats.nlfont:getHeight () + 3 * sprops.bmargin)
    stats.atf.font = stats.nlfont
    stats.ui:addObject (stats.atf)
    -- Top Food Eaten
    local topfood = stats.valOrZero ("topFood")
    stats.tf = Label:new (topfood, sprops.lleft + sprops.cpleft + stats.lfont:getWidth (sprops.attext) + sprops.blmargin - stats.lfont:getWidth (topfood), sprops.fltop + 3 * stats.nlfont:getHeight () + 3 * sprops.bmargin)
    stats.tf.font = stats.nlfont
    stats.ui:addObject (stats.tf)
    
    -- Button Font
    stats.btnfont = love.graphics.newFont (sprops.stfont, sprops.btnfsize)
    
    -- Achievements Button
    stats.abtn = Button:new (sprops.abtext, sprops.lleft, sprops.fltop + 5 * stats.nlfont:getHeight () + 5 * sprops.bmargin, stats.btnfont, "achButton")
    stats.ui:addObject (stats.abtn)
    stats.abtn.onClick = stats.abresp
    stats.abtn.index = 0
    
    -- Scoreboards Button
    stats.sbtn = Button:new (sprops.sbtext, sprops.lleft, sprops.fltop + 5 * stats.nlfont:getHeight () + stats.btnfont:getHeight () + 6 * sprops.bmargin, stats.btnfont, "achButton")
    stats.ui:addObject (stats.sbtn)
    stats.sbtn.onClick = stats.sbresp
    stats.sbtn.index = 1
    
    -- Back Button
    stats.bbtn = Button:new (sprops.bbtext, sprops.lleft, sprops.fltop + 5 * stats.nlfont:getHeight () + 2 * stats.btnfont:getHeight () + 7 * sprops.bmargin, stats.btnfont, "achButton")
    stats.ui:addObject (stats.bbtn)
    stats.bbtn.onClick = stats.bbresp
    stats.bbtn.index = 2

    stats.ui.minIndex = 0
    stats.ui.maxIndex = 2

    stats.ui.buttonsToKeys = true
end

function stats.valOrZero (key)
    return stats.statsMan:getValue (key)
end

function stats.bbresp (x, y, button, id)
    enableState ("menu")
    disableState ("stats")
end

function stats.abresp (x, y, button, id)
    enableState ("achievements")
    disableState ("stats")
end

function stats.sbresp (x, y, button, id)
    scoreboardState.showInsertUI = false
    scoreboardState.currentScore = -1
    scoreboardState.callAfter = "stats"

    enableState ("scoreboard")
    disableState ("stats")
end

function stats.reload ()
    stats.ats.text = stats.valOrZero ("allTimeScore")
    stats.ts.text = stats.valOrZero ("topScore")
    stats.att.text = stats.valOrZero ("allTimeGameTime")
    stats.tt.text = stats.valOrZero ("topTime")
    stats.atf.text = stats.valOrZero ("allTimeFood")
    stats.tf.text = stats.valOrZero ("topFood")
end
    
return stats
