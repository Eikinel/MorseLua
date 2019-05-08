_G.const = require("const")
_G.elapsed = 0 -- Global clock for all frames
require(const.folders.tools .. "showtable") -- Debug purpose

function love.load()
    -- Start with splashscreen
    frame = require(const.folders.frames .. const.frames.splashscreen).new()
    conf = config:get()
end

function love.update(dt)
    frame = frame:update(dt) or frame
end

function love.draw()
    if conf.debug then
        love.graphics.print("State = " .. frame.state, 20, 20)
        love.graphics.print("FPS = " .. tostring(love.timer.getFPS()) .. " / " .. (conf.window.fps or "?"), 20, 40)
        love.graphics.print("Time elapsed = " .. string.format("%.4f", tostring(_G.elapsed)), 20, 60)
    end

    frame:draw()
end

function love.resize(w, h)
    local oldw = conf.window.width
    local oldy = conf.window.height

    frame:resize(w, h, oldw, oldy)
    conf.window.width = w
    conf.window.height = h
    --config:update()
end


-- Default Löve2D run, with FPS handling
function love.run()
    config = require(const.folders.tools .. "config").init() -- Global config info

	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
    local dt = 0
    local wconf = config:get("window")
    local fps = 1 / (wconf and wconf.fps or 1000)
    wconf = nil
 
	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		-- Update dt, as we'll be passing it to update
        if love.timer then
            dt = love.timer.step()
            elapsed = elapsed + dt
        end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
    
        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())
    
            if love.draw then love.draw() end
    
            love.graphics.present()
        end

        -- Cap FPS according to FPS settings, or 1000 by default
        if love.timer then love.timer.sleep(fps) end
	end
end
