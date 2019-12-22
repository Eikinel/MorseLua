local script = {}

function script.changeTextColor(button, color)
    for _, children in pairs(button:getChildren()) do
        for _, child in pairs(children) do
            if child:getType() == const.gameobjects.text then
                child:setColor(color)
                break
            end
        end
    end
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