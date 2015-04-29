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
    ["pbfont"] = "res/fonts/5x5_square.ttf",
    ["pbtext"] = "Play",
    ["pbfontsize"] = 24,
    ["btnmargin"] = 5,
    ["btnleft"] = 110, -- not what i would like, but...
    ["btnfirsttop"] = 260, -- I mean, this could use more math an less constants
    ["sbtext"] = "Stats",
    ["obtext"] = "Options",
    ["tbtext"] = "Tutorial"
}


menu = {}

menu.objects = {}

function menu.start ()
    -- assume the following is set by our friend menu
    -- menu.ui, menu.me
    menu.ui.buttonsToKeys = true

    -- PROJECT S label
    menu.mlfont = love.graphics.newFont (props.mlfont, props.mlfontsize)
    local lx = (love.graphics.getWidth() - menu.mlfont:getWidth (props.mltext)) / 2
    local ly = props.mlmargintop
    menu.mlabel = Label:new (props.mltext, lx, ly)
    menu.mlabel.font = menu.mlfont
    menu.ui:addObject (menu.mlabel)
    
    -- Play Button
    menu.pbFont = love.graphics.newFont (props.pbfont, props.pbfontsize)
    menu.pbtn = Button:new (props.pbtext, props.btnleft, props.btnfirsttop, menu.pbFont, "playButton")
    menu.ui:addObject (menu.pbtn)
    menu.pbtn.whenToCall = "release"
    menu.pbtn.index = 0
    menu.pbtn.onClick = menu.pbtnresp
    
    -- Stats Button
    local ho2 = menu.pbFont:getHeight() + 2 * props.btnmargin + props.btnfirsttop
    
    menu.sbtn = Button:new (props.sbtext, props.btnleft, ho2, menu.pbFont, "statsButton")
    menu.ui:addObject (menu.sbtn)
    menu.sbtn.index = 1
    menu.sbtn.onClick = menu.statsbtnresp
    
    -- Options Button
    local ho3 = 2 * menu.pbFont:getHeight() + 4 * props.btnmargin + props.btnfirsttop
    
    menu.obtn = Button:new (props.obtext, props.btnleft, ho3, menu.pbFont, "optionsButton")
    menu.ui:addObject (menu.obtn)
    menu.obtn.index = 2
    menu.obtn.onClick = menu.optbtnresp

    menu.ui.minIndex = 0
    menu.ui.maxIndex = 2
    
    --[[ Tutorial Button
    local ho4 = 3 * menu.pbFont:getHeight() + 6 * props.btnmargin + props.btnfirsttop
    
    menu.tbtn = Button:new (props.tbtext, props.btnleft, ho4, menu.pbFont, "tutorialButton")
    menu.ui:addObject (menu.tbtn)
    -- menu.tbtn.onClick = menu.tutbtnresp]]
    
end

function menu.config ()
    
end

function menu.pbtnresp (x, y, button)
    if button == "l" or button == "r" then
        disableState ("menu")    
        enableState("modeSel")
    end
end

function menu.statsbtnresp (x, y, button)
    if button == "l" or button == "r" then
        enableState("stats")
        disableState ("menu")
    end
end

function menu.optbtnresp (x, y, button)
    if button == "l" or button == "r" then
        settingState.comesFrom = "menu"
        enableState("settings")
        disableState ("menu")
    end
end

function menu.tutbtnresp (x, y, button)
    if button == "l" or button == "r" then
        enableState("tutorial")
        disableState ("menu")
    end
end

return menu
