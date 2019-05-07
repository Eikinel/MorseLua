_G.const = require("const")
_G.debug = true
_G.elapsed = 0 -- Global elapsed time
require(const.folders.tools .. "showtable")

-- Default Löve2D run, with FPS handling
function love.run()
	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
    local dt = 0
 
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
            _G.elapsed = _G.elapsed + dt
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
        if love.timer then love.timer.sleep(const.fps and 1 / const.fps or 1 / 1000) end
	end
end

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
        love.graphics.print("FPS = " .. tostring(love.timer.getFPS()) .. " / " .. (const.fps or "?"), 20, 40)
        love.graphics.print("Time elapsed = " .. string.format("%.4f", tostring(_G.elapsed)), 20, 60)
    end
end

function love.resize(w, h)
    frame:resize(w, h)
end
