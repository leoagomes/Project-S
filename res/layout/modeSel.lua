--[[
    This is the script file that controls menus and layouts
    The idea here is to only have to change this file for different devices
]]
require ("lib.libui")
require ("lib.libui.modules.label")

props = {
    ["mlmargintop"] = 50,
    ["mlfont"] = "res/fonts/5x5_square.ttf",
    ["mlfontsize"] = 30,
    ["mltext"] = "Project S",
    ["font"] = "res/fonts/5x5_square.ttf",
    ["pbtext"] = "Classic",
    ["fontsize"] = 24,
    ["btnmargin"] = 5,
    ["btnleft"] = 110, -- not what i would like, but...
    ["btnfirsttop"] = 260, -- I mean, this could use more math an less constants
    ["sbtext"] = "Dubstep",
    ["bbtext"] = "Back"
}


modeSel = {}

modeSel.objects = {}

function modeSel.start ()
    -- assume the following is set by our friend menu
    -- menu.ui, menu.me
    modeSel.ui.buttonsToKeys = true

    -- PROJECT S label
    modeSel.mlfont = love.graphics.newFont (props.mlfont, props.mlfontsize)
    local lx = (love.graphics.getWidth() - modeSel.mlfont:getWidth (props.mltext)) / 2
    local ly = props.mlmargintop
    modeSel.mlabel = Label:new (props.mltext, lx, ly)
    modeSel.mlabel.font = modeSel.mlfont
    modeSel.ui:addObject (modeSel.mlabel)
    
    -- Main button font
    modeSel.font = love.graphics.newFont (props.font, props.fontsize)
    
    -- Classic button
    modeSel.cbtn = Button:new (props.pbtext, props.btnleft, props.btnfirsttop, modeSel.font, "classicButton")
    modeSel.ui:addObject (modeSel.cbtn)
    modeSel.cbtn.onClick = modeSel.cbtnresp
    modeSel.cbtn.index = 0
    
    -- Dubstep Button
    local ho2 = modeSel.font:getHeight() + 2 * props.btnmargin + props.btnfirsttop
    
    modeSel.dbtn = Button:new (props.sbtext, props.btnleft, ho2, modeSel.font, "statsButton")
    modeSel.dbtn.index = 1
    modeSel.ui:addObject (modeSel.dbtn)
  
    -- Back Button
    local ho3 = 2 * modeSel.font:getHeight() + 4 * props.btnmargin + props.btnfirsttop
    
    modeSel.bbtn = Button:new (props.bbtext, props.btnleft, ho3, modeSel.font, "backButton")
    modeSel.ui:addObject (modeSel.bbtn)
    modeSel.bbtn.index = 2
    modeSel.bbtn.onClick = modeSel.optbtnresp
    

    modeSel.ui.minIndex = 0
    modeSel.ui.maxIndex = 2
end

function modeSel.config ()
    
end

function modeSel.enable ()
    if gameState.dmUnlocked then
        modeSel.dbtn.onClick = modeSel.dbtnresp
    else
        local color = v.blockedButtonColor
        modeSel.dbtn.ctextColor = color 
        modeSel.dbtn.textColor = color 
        modeSel.dbtn.clickColor = color 
    end
end

function modeSel.cbtnresp (x, y, button)
    if button == "l" or button == "r" then
        gameState.gameMode = "classic"
        enableState("game")
        disableState ("modeSel")
    end
end

function modeSel.dbtnresp (x, y, button)
    if button == "l" or button == "r" then
        gameState.gameMode = "dubstep"
        enableState("game")
        disableState ("modeSel")
    end
end

function modeSel.optbtnresp (x, y, button)
    if button == "l" or button == "r" then
        enableState("menu")
        disableState ("modeSel")
    end
end

function modeSel.disable ()
end

return modeSel
