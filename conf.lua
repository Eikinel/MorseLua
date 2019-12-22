function love.conf(t)
    local const = require("const")

    t.identity = const.name                 -- The name of the save directory (string)
    love.filesystem.setIdentity(t.identity)
    t.appendidentity = false                -- Search files in source directory before save directory (boolean)
    t.version = "11.2"                      -- The LÖVE version this game was made for (string)
    t.console = true                        -- Attach a console (boolean, Windows only)
    t.accelerometerjoystick = true          -- Enable the accelerometer on iOS and Android by exposing it as a Joystick (boolean)
    t.externalstorage = false               -- True to save files (and read from the save directory) in external storage on Android (boolean) 
    t.gammacorrect = false                  -- Enable gamma-correct rendering, when supported by the system (boolean)
 
    t.audio.mixwithsystem = true            -- Keep background music playing when opening LOVE (boolean, iOS and Android only)
    
    -- Use user config file to setup window with local settings
    local settings = require(const.folders.tools .. "settings")
    local conf = settings.load()

    t.window.title = const.name             -- The window title (string)
    t.window.icon = nil                     -- Filepath to an image to use as the window's icon (string)
    t.window.width = conf.window.width                      -- The window width (number), chosen between user config or maximum
    t.window.height = conf.window.height                    -- The window height (number), chosen between user config or maximum
    t.window.borderless = conf.window.borderless            -- Remove all border visuals from the window (boolean)
    t.window.resizable = conf.window.resizable              -- Let the window be user-resizable (boolean)
    t.window.minwidth = conf.window.minwidth                -- Minimum window width if the window is resizable (number), chosen between user config or default
    t.window.minheight = conf.window.minheight              -- Minimum window height if the window is resizable (number), chosen between user config or default
    t.window.fullscreen = conf.window.fullscreen            -- Enable fullscreen (boolean)
    t.window.fullscreentype = conf.window.fullscreentype    -- Choose between "desktop" fullscreen or "exclusive" fullscreen mode (string)
    t.window.vsync = conf.window.vsync                      -- Vertical sync mode (boolean)
    t.window.msaa = 0                       -- The number of samples to use with multi-sampled antialiasing (number)
    t.window.depth = nil                    -- The number of bits per sample in the depth buffer
    t.window.stencil = nil                  -- The number of bits per sample in the stencil buffer
    t.window.display = conf.window.display                  -- Index of the monitor to show the window in (number)
    t.window.highdpi = false                -- Enable high-dpi mode for the window on a Retina display (boolean)
    t.window.x = nil                        -- The x-coordinate of the window's position in the specified display (number)
    t.window.y = nil                        -- The y-coordinate of the window's position in the specified display (number)
 
    t.modules.audio = true                  -- Enable the audio module (boolean)
    t.modules.data = true                   -- Enable the data module (boolean)
    t.modules.event = true                  -- Enable the event module (boolean)
    t.modules.font = true                   -- Enable the font module (boolean)
    t.modules.graphics = true               -- Enable the graphics module (boolean)
    t.modules.image = true                  -- Enable the image module (boolean)
    t.modules.joystick = true               -- Enable the joystick module (boolean)
    t.modules.keyboard = true               -- Enable the keyboard module (boolean)
    t.modules.math = true                   -- Enable the math module (boolean)
    t.modules.mouse = true                  -- Enable the mouse module (boolean)
    t.modules.physics = true                -- Enable the physics module (boolean)
    t.modules.sound = true                  -- Enable the sound module (boolean)
    t.modules.system = true                 -- Enable the system module (boolean)
    t.modules.thread = true                 -- Enable the thread module (boolean)
    t.modules.timer = true                  -- Enable the timer module (boolean), Disabling it will result 0 delta time in love.update
    t.modules.touch = true                  -- Enable the touch module (boolean)
    t.modules.video = true                  -- Enable the video module (boolean)
    t.modules.window = true                 -- Enable the window module (boolean)
end