local splashscreen = {}
splashscreen.state = "splashscreen"
splashscreen.__index = splashscreen

function splashscreen.new(animations)
    print("Creating new splashscreen")

    splashscreen.animations = animations or {}

    splashscreen.opacity = 0
    splashscreen.fadetime = 2 -- Seconds fadeIn/fadeOut
    splashscreen.index = 1

    return splashscreen
end

function splashscreen:update(dt)
    return require(const.folders.frames .. const.frames.menu).new()
end

function splashscreen:draw()
    
end

function splashscreen:resize(w, h)
end

local function fadeIn(dt)
end

local function fadeOut(dt)
end

return splashscreen