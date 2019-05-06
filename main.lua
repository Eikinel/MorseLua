_G.const = require("const")
_G.debug = true
require(const.folders.tools .. "showtable")

function love.load()
    frame = require(const.folders.frames .. const.frames.menu).new()
end

function love.update(dt)
    frame = frame:update(dt) or frame
end

function love.draw()
    frame:draw()

    if debug then
        love.graphics.print("State = " .. frame.state, 20, 20)
    end
end

function love.resize(w, h)
    frame:resize(w, h)
end
