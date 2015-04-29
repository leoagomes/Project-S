debug = false
savedata_dir = love.filesystem.getSaveDirectory ()
scale = 1

require ("lib/libsave")

-- Default settings
set = {}
set.winW = 800
set.winH = 600
set.winRes = false
set.winBorderless = false
set.winFullscreen = false
set.scale = 1

function love.conf ( conf )
	conf.identity = "ProjectS"
	conf.window.title = "Project S"
	-- conf.window.icon = "path/to/icon"

	-- Load saved data
	if love.filesystem.exists (savedata_dir .. "set.psdat") then
		set = table.load (savedata_dir .. "set.psdat")
	else
		table.save (set, savedata_dir .. "set.psdat") -- if save doesn't exist, create it.
	end

	-- set window properties accordingly
	conf.window.height = set.winH
	conf.window.width = set.winW
	conf.window.resizable = set.winRes
	conf.window.borderless = set.winBorderless
	conf.window.fullscreen = set.winFullscreen
	
	--conf.console = true -- TODO: remove this

	-- Set game properties
	scale = set.scale
	
	conf.modules.audio = true             -- Enable the audio module (boolean)
	conf.modules.event = true             -- Enable the event module (boolean)
	conf.modules.graphics = true          -- Enable the graphics module (boolean)
	conf.modules.image = true             -- Enable the image module (boolean)
	conf.modules.joystick = false         -- Enable the joystick module (boolean)
	conf.modules.keyboard = true          -- Enable the keyboard module (boolean)
	conf.modules.math = true              -- Enable the math module (boolean)
	conf.modules.mouse = true             -- Enable the mouse module (boolean)
	conf.modules.physics = true           -- Enable the physics module (boolean)
	conf.modules.sound = true             -- Enable the sound module (boolean)
	conf.modules.system = true            -- Enable the system module (boolean)
	conf.modules.timer = true             -- Enable the timer module (boolean)
	conf.modules.window = true            -- Enable the window module (boolean)
	conf.modules.thread = false
end
