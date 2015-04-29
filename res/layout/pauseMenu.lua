require ("lib.libui")
require ("lib.tween")

pMenu = {}

pmprops = {
    ["plfont"] = "res/fonts/5x5_square.ttf",
    ["pltext"] = "Paused",
    ["pltop"] = 100,
    ["plfontsize"] = 30,
    ["bfont"] = "res/fonts/5x5_square.ttf",
    ["bsize"] = 24,
    ["bmargin"] = 5,
    ["fbtop"] = 240,
    ["cbtext"] = "Continue",
    ["obtext"] = "Options",
    ["qbtext"] = "Quit",
    ["left"] = 120
}

function pMenu.start ()
    -- UI label
    pMenu.plfont = love.graphics.newFont (pmprops.plfont, pmprops.plfontsize)
    pMenu.pl = Label:new (pmprops.pltext, (love.graphics.getWidth () - pMenu.plfont:getWidth (pmprops.pltext)) / 2, pmprops.pltop)
    pMenu.pl.font = pMenu.plfont
    pMenu.pl.color = v.pauseMenuTextColor
    pMenu.lui:addObject (pMenu.pl)
    
    -- Main font
    pMenu.bfont = love.graphics.newFont (pmprops.bfont, pmprops.bsize)
    
    -- Continue Button
    local cbx = (love.graphics.getWidth () - pMenu.bfont:getWidth (pmprops.cbtext)) / 2
    pMenu.cbtn = Button:new (pmprops.cbtext, cbx, pmprops.fbtop, pMenu.bfont, "continueButton")
    pMenu.cbtn.onClick = pMenu.cbtnresp
    pMenu.cbtn.index = 0
    pMenu.lui:addObject (pMenu.cbtn)
    
    -- Options Button
    local obx = (love.graphics.getWidth () - pMenu.bfont:getWidth (pmprops.obtext)) / 2
    local oby = pmprops.fbtop + pMenu.bfont:getHeight () + 2 * pmprops.bmargin
    pMenu.obtn = Button:new (pmprops.obtext, obx, oby, pMenu.bfont, "optionsButton")
    pMenu.obtn.onClick = pMenu.obtnresp
    pMenu.obtn.index = 1
    pMenu.lui:addObject (pMenu.obtn)
    
    -- Quit Button
    local qbx = (love.graphics.getWidth () - pMenu.bfont:getWidth (pmprops.qbtext)) / 2
    local qby = pmprops.fbtop + 2 * pMenu.bfont:getHeight () + 4 * pmprops.bmargin
    pMenu.qbtn = Button:new (pmprops.qbtext, qbx, qby, pMenu.bfont, "quitButton")
    pMenu.qbtn.onClick = pMenu.qbtnresp
    pMenu.qbtn.index = 2
    pMenu.lui:addObject (pMenu.qbtn)

    -- menu arrows 
    pMenu.lui.maxIndex = 2
    pMenu.lui.minIndex = 0

    pMenu.lui.buttonsToKeys = true
end

function pMenu.config ()
    
end

function pMenu.cbtnresp (x, y, button, id)
    pMenu.me.shouldContinue = true
    pMenu.me.canvasTween = tween.new (0.15, pMenu.me, {cY = love.graphics.getHeight ()}, 'outExpo')
end

function pMenu.obtnresp (x, y, button, id)
    -- TODO: pause menu options
    settingState.comesFrom = "pause"
    disableState ("pause")
    enableState ("settings")
end

function pMenu.qbtnresp (x, y, button, id)
    -- disable and stop game
    disableState ("pause")
    gameState.game:terminate ("quit")
end

return pMenu
