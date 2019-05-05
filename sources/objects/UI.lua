local UI = {}
UI.__index = UI

function UI.new(buttons)
    local t = {}

    t.buttons = buttons or {}

    return setmetatable(t, UI)
end


-- Getters
function UI:getButtons()
    return self.buttons
end


-- Setters
function UI:addButtons(buttons)
    for _, button in ipairs(buttons) do
        self.buttons[#self.buttons + 1] = button
    end
end


return UI