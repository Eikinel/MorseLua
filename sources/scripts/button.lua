local script = {}

function script.changeColor(button, color)
    button.text:set({ color, button.string })
end

function script.changeText(button, string)
    button.string = string
    button.text:set({ button.color, button.string })
    button:setPosition(button:getLocalPosition()) -- Readjust button with new text
end

function script.toFrame(frame)
    print("Switching to frame " .. frame)
    return require(const.folders.frames .. frame).new()
end

function script.exit()
    love.event.quit()
end

return script