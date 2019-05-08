local settings = {}
settings.__index = settings

local const = require("const")
local serpent = require(const.folders.deps .. "serpent/serpent")
require(const.folders.tools .. "showtable")

function settings.open(mode)
    local file = love.filesystem.newFile(const.saves.settings.filename)
    local ok, err = file:open(mode)

    if not ok then print(err) return end

    return file
end

function settings.write(file, conf)
    file:write("local settings = ")
    file:write(serpent.block(conf))
    file:write("\nreturn settings")
end

function settings.load()
    local exec, err = love.filesystem.load(const.saves.settings.filename)
    local conf = {}

    -- Create file if doesn't exist or file is empty with default settings
    if not exec or not exec() then
        local file = settings.open("w")
        if not file then return end

        -- Create settings from zero
        conf.debug = false
        conf.window = {
            width = 0, height = 0,
            minwidth = 640, minheight = 480,
            fullscreen = false, fullscreentype = "exclusive",
            borderless = false, resizable = false,
            vsync = false, display = 1,
            fps = 60
        }

        settings.write(file, conf)
        file:close()
    else
        -- Use user's settings
        conf = exec()
    end

    return conf
end

return settings