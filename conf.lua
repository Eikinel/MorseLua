function love.conf(t)
    t.version = "11.2"
    t.window.icon = nil
    t.window.title = "Morse"

    t.window.width = 1280
    t.window.height = 720
    t.window.borderless = false
    t.window.resizable = true
    t.window.fullscreen = false
    t.window.vsync = true
    t.window.msaa = 0                   -- The number of samples to use with multi-sampled antialiasing (number)
    t.window.highdpi = false            -- Enable high-dpi mode for the window on a Retina display (boolean)

    -- DEBUG
    t.console = true
end