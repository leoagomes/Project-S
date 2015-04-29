require ("lib.libui")
require ("lib.tween")

scorePanel = {}

spprops = {
    ["plfont"] = "res/fonts/5x5_square.ttf",
    ["pltext"] = "Scoreboard",
    ["pltop"] = 50,
    ["plfontsize"] = 30,
    ["mfont"] = "res/fonts/5x5_square.ttf",
    ["mfontsize"] = 24,
    ["bmargin"] = 5,
    ["yltext"] = "You:",
    ["ntbhint"] = "Click to change",
    ["sltext"] = "Score: ",
    ["fileft"] = 120,
    ["fitop"] = 150,
    ["margin"] = 5,
    ["bottomMargin"] = 100
}

function scorePanel.enable ()
    -- remove ui objects
    scorePanel.ui:removeAll ()

    -- UI label
    scorePanel.plfont = love.graphics.newFont (spprops.plfont, spprops.plfontsize)
    scorePanel.pl = Label:new (spprops.pltext, (love.graphics.getWidth () - scorePanel.plfont:getWidth (spprops.pltext)) / 2, spprops.pltop)
    scorePanel.pl.font = scorePanel.plfont
    scorePanel.pl.color = v.pauseMenuTextColor
    scorePanel.ui:addObject (scorePanel.pl)

    -- define main font
    scorePanel.mfont = love.graphics.newFont (spprops.mfont, spprops.mfontsize)

    local x, y = spprops.fileft, spprops.fitop
    if scorePanel.me.showInsertUI then
        -- You label
        scorePanel.yl = Label:new (spprops.yltext, x, y)
        scorePanel.yl.font = scorePanel.mfont
        scorePanel.ui:addObject (scorePanel.yl)
        -- Name TextBox
        spprops.ntbh, spprops.ntbw = scorePanel.mfont:getHeight (), scorePanel.mfont:getWidth (spprops.ntbhint)
        scorePanel.ntb = TextBox:new (x + scorePanel.mfont:getWidth (spprops.yltext) + spprops.margin, y, spprops.ntbw, spprops.ntbh, spprops.ntbhint, scorePanel.mfont)
        scorePanel.ntb.onReturn = scorePanel.retResp
        scorePanel.ntb.tFont = scorePanel.mfont
        scorePanel.ui:addObject (scorePanel.ntb)

        -- Score
        local sclX = love.graphics.getWidth() - spprops.fileft - scorePanel.mfont:getWidth (scorePanel.me.currentScore)
        scorePanel.scl = Label:new ("" .. scorePanel.me.currentScore, sclX, y)
        scorePanel.scl.font = scorePanel.mfont
        scorePanel.ui:addObject (scorePanel.scl)

        -- 'Score' Label
        scorePanel.sl = Label:new (spprops.sltext, sclX - scorePanel.mfont:getWidth (spprops.sltext), y)
        scorePanel.sl.font = scorePanel.mfont
        scorePanel.ui:addObject (scorePanel.sl)

        -- change X and Y
        y = y + spprops.ntbh + 4 * spprops.margin
    end

    -- Scores HSList
    scorePanel.hsl = HSList:new (scoreboardSys:getScores (), "name", "score", love.graphics.getWidth () - 2 * spprops.fileft, love.graphics.getHeight () - y - spprops.bottomMargin, x, y, scorePanel.mfont)
    scorePanel.ui:addObject (scorePanel.hsl)

    -- back/continue button
    local text = scorePanel.me.showInsertUI == true and "Continue" or "Back"
    scorePanel.cbbtn = Button:new (text, love.graphics.getWidth () - spprops.fileft - scorePanel.mfont:getWidth (text), love.graphics.getHeight () - spprops.bottomMargin + spprops.margin, scorePanel.mfont, "backButton")
    scorePanel.cbbtn.onClick = scorePanel.bcbtnresp
    scorePanel.ui:addObject (scorePanel.cbbtn)
end

function scorePanel.bcbtnresp (x, y, button, id)
    if button ~= "l" and button ~= "r" then
        return
    end

    if scorePanel.me.showInsertUI then
        scorePanel.retResp (scorePanel.ntb.conten)
    else
        disableState ("scoreboard")
        enableState (scorePanel.me.callAfter)
    end
end

function scorePanel.keypressed (key)
    if scorePanel.ntb == nil or not scorePanel.ntb.hasFocus then
        if key == "enter" or key == "return" or key == "escape" then
            scorePanel.bcbtnresp (0,0,"l","")
        end
    end
end

function scorePanel.retResp (text)
    if text and text ~= "" then
        scoreboardSys:setScore (text, scorePanel.me.currentScore)
        scoreboardSys:save ()
    end

    disableState ("scoreboard")
    enableState ("menu")
end

scorePanel.start = scorePanel.enable

return scorePanel
