--[[
    An approach to easy ui building.
    Creator: Leonardo Gomes
]]

require ("lib.libui.modules.btn")
require ("lib.libui.modules.textbox")
require ("lib.libui.modules.label")
require ("lib.libui.modules.pbar")
require ("lib.libui.modules.hsl")

libui = mClass ("libui")

-- libui definitions --

function libui:initialize (  )
	self.objects = {}
    self.buttonsToKeys = false
    self.cbIndex = -1

    self.minIndex = -1
    self.maxIndex = -1
end

function libui:addObject ( obj )
	table.insert (self.objects, obj)
end

function libui:removeObject ( obj )
	for k,v in pairs(self.objects) do
		if v == obj then
			table.remove (self.objects, k)
			return true
		end
	end
	return false
end

function libui:removeAll ()
    self.objects = {}
end

function libui:unselect ()
	for k,v in pairs(self.objects) do
		if v:isInstanceOf (Button) then
			v.selected = false
		end
	end
end

-- libui love layer --

function libui:update ( dt )
	for k,v in pairs(self.objects) do
		if v.update ~= nil then
			v:update ()
		end
	end
end

function libui:draw (  )
	for k,v in pairs(self.objects) do
		if v.draw ~= nil then
			v:draw ()
		end
	end
end

function libui:mousepressed ( x, y, button )
	for k,v in pairs(self.objects) do
		if v.mousepressed ~= nil then
			v:mousepressed (x, y, button)
		end
	end
end

function libui:mousereleased ( x, y, button )
	for k,v in pairs(self.objects) do
		if v.mousereleased ~= nil then
			v:mousereleased (x, y, button)
		end
	end
end

function libui:keypressed ( key )
	for k,v in pairs(self.objects) do
		if v.keypressed ~= nil then
			v:keypressed (key)
		end
	end

    if self.buttonsToKeys then
        if key == "up" then
        	self.cbIndex = self.cbIndex - 1
        elseif key == "down" then
        	self.cbIndex = self.cbIndex + 1
        end

        if self.cbIndex > self.maxIndex then
        	self.cbIndex = self.minIndex
        elseif self.cbIndex < self.minIndex then
        	self.cbIndex = self.maxIndex
       	end

        for i,v in pairs (self.objects) do
        	if v:isInstanceOf(Button) then
        		v.selected = false
        		if v.index == self.cbIndex then
        			v.selected = true
        		end
        	end
        end
    end
end

function libui:keyreleased ( key )
	for k,v in pairs(self.objects) do
		if v.keyreleased ~= nil then
			v:keyreleased (key)
		end
	end
end

function libui:textinput ( text )
	for k,v in pairs(self.objects) do
		if v.textinput ~= nil then
			v:textinput (text)
		end
	end
end

function libui:touchpressed  (id, x, y, pressure)
	for k,v in pairs (self.objects) do
		if v.touchpressed then
			v:touchpressed (id, x, y, pressure)
		end
	end
end

function libui:touchreleased (id, x, y, pressure)
	for k,v in pairs (self.objects) do
		if v.touchreleased then
			v:touchreleased (id, x, y, pressure)
		end
	end
end

function libui:touchmoved  (id, x, y, pressure)
	for k,v in pairs (self.objects) do
		if v.touchmoved then
			v:touchmoved (id, x, y, pressure)
		end
	end
end
