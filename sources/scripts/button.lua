local script = {}

function script.changeColor(button, color)
    button.text:set({ color, button.string })
end

function script.changeText(button, string)
    button:setText(string)
end

function script.toFrame(frame)
    print("Switching to frame " .. frame)
    return require(const.folders.frames .. frame).new()
end

function script.exit()
    love.event.quit()
end

return script