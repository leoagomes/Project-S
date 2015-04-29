aPanel = {}

approps = {
    ["atop"] = 50,
    ["atext"] = "Achievements",
    ["font"] = "res/fonts/5x5_square.ttf",
    ["tfsize"] = 30,
    ["nfsize"] = 18,
    ["ftop"] = 100,
    ["bbtext"] = "Back",
    ["fleft"] = 100,
    ["btmmargin"] = 100,
    ["margin"] = 5
}

function aPanel.start ()
    -- Label
    aPanel.topfont = love.graphics.newFont (approps.font, approps.tfsize)
    aPanel.lbl = Label:new (approps.atext, (love.graphics.getWidth () - aPanel.topfont:getWidth (approps.atext)) / 2, approps.atop)
    aPanel.lbl.font = aPanel.topfont
    aPanel.ui:addObject (aPanel.lbl)

    -- List
    aPanel.mfont = love.graphics.newFont (approps.font, approps.nfsize)
    aPanel.al = HSList (aPanel.buildReadableList (), "name", "status", love.graphics.getWidth () - 2 * approps.fleft, love.graphics.getHeight () - approps.atop - approps.btmmargin, approps.fleft, approps.ftop, aPanel.mfont)
    aPanel.al.kt = "Name:"; aPanel.al.vt = "Status:"
    aPanel.ui:addObject (aPanel.al)

    -- back button
    aPanel.bbtn = Button:new (approps.bbtext, love.graphics.getWidth () - approps.fleft - aPanel.mfont:getWidth (approps.bbtext), love.graphics.getHeight () - approps.btmmargin + approps.margin, aPanel.mfont, "backButton")
    aPanel.ui:addObject (aPanel.bbtn)
    aPanel.bbtn.onClick = aPanel.bbtnresp
end

function aPanel.buildReadableList ()
    local list = {}

    for i, v in pairs (achievementSys.achievements) do
        for k, j in pairs (v) do
            if achievementSys:isUnlocked (k) then
                table.insert (list, 1, {["name"] = j.name, ["status"] = "unlocked", ["id"] = k})
            else
                table.insert (list, {["name"] = j.name, ["status"] = "locked", ["id"] = k})
            end
        end
    end

    return list
end

function aPanel.enable ()
    aPanel.ui:removeAll ()
    aPanel.start ()
end

function aPanel.bbtnresp (x, y, button, id)
    if button == "l" or button == "r" then
        enableState ("stats")
        disableState ("achievements")
    end
end

function aPanel.keypressed (key)
    if key == "escape" or key == "enter" or key == "return" then
        aPanel.bbtnresp (0, 0, "l", "backButton")
    end
end

return aPanel
