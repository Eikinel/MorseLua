_G.const = require("const")

function love.load()
    frame = require(const.folders.frames .. const.frames.menu).new()
end

function love.update(dt)
    frame = frame:update(dt) or frame
end

function love.draw()
    frame:draw()
end