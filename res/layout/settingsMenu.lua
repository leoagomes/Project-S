require ("lib.libui")
require ("lib.tween")

sMenu = {}

sep = {
    ["opltext"] = "Options",
    ["oplfont"] = "res/fonts/5x5_square.ttf",
    ["oplfsize"] = 30,
    ["bfsize"] = 24,
    ["voltext"] = "Volume: ",
    ["volw"] = 570,
    ["volh"] = 20,
    ["lleft"] = 115,
    ["ltop"] = 50,
    ["vltop"] = 200,
    ["volb"] = 2,
    ["lbmargin"] = 20,
    ["bbtext"] = "Back",
    ["btnmargin"] = 5,
    ["mvltext"] = "Movement: ",
    ["umbtext"] = "U: ",
    ["dmbtext"] = "D: ",
    ["lmbtext"] = "L: ",
    ["rmbtext"] = "R: ",
}

function sMenu.start ()
    -- PROJECT S label
    sMenu.mlfont = love.graphics.newFont (sep.oplfont, sep.oplfsize)
    local lx = (love.graphics.getWidth() - sMenu.mlfont:getWidth (sep.opltext)) / 2
    local ly = sep.ltop
    sMenu.mlabel = Label:new (sep.opltext, lx, ly)
    sMenu.mlabel.font = sMenu.mlfont
    sMenu.lui:addObject (sMenu.mlabel)
    
    sMenu.lfont = love.graphics.newFont (sep.oplfont, sep.bfsize)
    
    -- Volume Label
    sMenu.vl = Label:new (sep.voltext, sep.lleft, sep.vltop)
    sMenu.vl.font = sMenu.lfont
    sMenu.lui:addObject (sMenu.vl)
    
    -- Volume bar
    sMenu.vb = ProgressBar:new (sep.lleft, sep.vltop + sMenu.lfont:getHeight () + sep.lbmargin, sep.volw, sep.volh, sep.volb, true)
    sMenu.vb.value = optMan:getOpt ("defSongVolume") ~= nil and optMan:getOpt ("defSongVolume") or 1
    sMenu.vb.onRelease = sMenu.orresp
    sMenu.lui:addObject (sMenu.vb)
    
    -- Movement Label
    local mly = sep.vltop + sMenu.lfont:getHeight () + sep.volh + 2 * sep.lbmargin
    sMenu.ml = Label:new (sep.mvltext, sep.lleft, mly)
    sMenu.ml.font = sMenu.lfont
    sMenu.lui:addObject (sMenu.ml)
    
    -- Movement Buttons
    local mby = mly + sMenu.lfont:getHeight () --+ 2 * sep.lbmargin
    -- Up
    sMenu.ub = Button:new (sep.umbtext .. v.upKey, 2 * sep.lbmargin + sep.lleft, mby, sMenu.lfont, "up")
    sMenu.ub.onClick = sMenu.mbresp
    sMenu.lui:addObject (sMenu.ub)
    -- Down
    local dmbx = 2 * sep.lbmargin + sep.lleft + sMenu.lfont:getWidth (sep.umbtext .. v.upKey) + sep.lbmargin
    sMenu.db = Button:new (sep.dmbtext .. v.downKey, dmbx, mby, sMenu.lfont, "down")
    sMenu.db.onClick = sMenu.mbresp
    sMenu.lui:addObject (sMenu.db)
    -- Left
    local lmbx = dmbx + sep.lbmargin + sMenu.lfont:getWidth (sep.dmbtext .. v.downKey)
    sMenu.lb = Button:new (sep.lmbtext .. v.leftKey, lmbx, mby, sMenu.lfont, "left")
    sMenu.lb.onClick = sMenu.mbresp
    sMenu.lui:addObject (sMenu.lb)
    -- Right
    local rmbx = lmbx + sep.lbmargin + sMenu.lfont:getWidth (sep.lmbtext .. v.leftKey)
    sMenu.rb = Button:new (sep.rmbtext .. v.rightKey, rmbx, mby, sMenu.lfont, "right")
    sMenu.rb.onClick = sMenu.mbresp
    sMenu.lui:addObject (sMenu.rb)
    
    -- Back Button
    local ho3 = 5 * sMenu.lfont:getHeight() + 4 * sep.btnmargin + sep.vltop
    
    sMenu.bbtn = Button:new (sep.bbtext, sep.lleft, ho3, sMenu.lfont, "backButton")
    sMenu.lui:addObject (sMenu.bbtn)
    sMenu.bbtn.onClick = sMenu.bbtnresp
    
    -- canvas for key changing
    sMenu.kcnvs = love.graphics.newCanvas (love.graphics.getWidth (), love.graphics.getHeight ())
    sMenu.kcen = false
end

function sMenu.orresp (val)
    optMan:setOpt ("defSongVolume", val)
    optMan:replace ()
end

function sMenu.bbtnresp (x, y, button)
    if button == "l" or button == "r" then
        optMan:save ()
        
        if sMenu.me.comesFrom == "menu" then
            enableState("menu")
        else
            enableState ("pause")
            
            -- also something that probably shouldn't be here
            if not gameState.game.song.isMuted then
                gameState.game.song.song:setVolume (v.defSongVolume)
            end
        end
        disableState ("settings")
    end
end

function sMenu.update (dt)
    
end

function sMenu.draw ()
    if not sMenu.kcen then
        return
    end
    
    love.graphics.setCanvas (sMenu.kcnvs)
        sMenu.kcnvs:clear ({0, 0, 0, 150})
        
        love.graphics.setColor ({255, 255, 255, 255})
        love.graphics.setFont (sMenu.lfont)
        love.graphics.print ("Press the new key or 'esc' to quit.", 100, 50)
    love.graphics.setCanvas ()
    
    love.graphics.setColor ({255, 255, 255, 255})
    love.graphics.draw (sMenu.kcnvs)
end

function sMenu.mbresp (x, y, button, id)
    sMenu.toRead = id.id .. "Key"
    sMenu.kcen = true
end

function sMenu.enable ()
    sMenu.reloadUI ()
end

function sMenu.keypressed (key)
    if not sMenu.kcen and key == "escape" then
        sMenu.bbtnresp (0, 0, "l")
    elseif sMenu.kcen == false then
        return
    end
    
    if key ~= "escape" and key ~= v.upKey and key ~= v.downKey and key ~= v.leftKey and
    key ~= v.rightKey and key ~= v.muteKey and key ~= v.pauseKey then
        optMan:setOpt (sMenu.toRead, key)
        optMan:replace ()
        
        sMenu.reloadUI ()
        
        sMenu.kcen = false
    elseif key == "escape" then
        sMenu.kcen = false
    end
end

function sMenu.reloadUI ()
    -- names
    sMenu.ub.text = sep.umbtext .. v.upKey
    sMenu.db.text = sep.dmbtext .. v.downKey
    sMenu.lb.text = sep.lmbtext .. v.leftKey
    sMenu.rb.text = sep.rmbtext .. v.rightKey
    
    -- positions
    local dmbx = 2 * sep.lbmargin + sep.lleft + sMenu.lfont:getWidth (sep.umbtext .. v.upKey) + sep.lbmargin
    sMenu.db.x = dmbx
    local lmbx = dmbx + sep.lbmargin + sMenu.lfont:getWidth (sep.dmbtext .. v.downKey)
    sMenu.lb.x = lmbx
    local rmbx = lmbx + sep.lbmargin + sMenu.lfont:getWidth (sep.lmbtext .. v.leftKey)
    sMenu.rb.x = rmbx
end

return sMenu