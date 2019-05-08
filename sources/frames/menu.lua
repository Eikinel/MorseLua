local menu = {}
menu.state = "menu"
menu.__index = menu

function menu.new()
    print("Creating new menu")

    local UI = require(const.folders.objects .. "UI")
    local Button = require(const.folders.objects .. "Button")

    local fonts = {}
    fonts.default = { name = const.folders.fonts .. "TovariSans.ttf", sizefactor = 0.1 }
    fonts.title = { name = const.folders.fonts .. "TovariSans.ttf", sizefactor = 0.25 }

    menu.UI = UI.new()

    -- Create buttons
    local buttons = {}
    local script = require(const.folders.scripts .. "button")

    buttons.play = Button.new("Play", fonts.default, nil, 0.5, 0.5, "center", "center")
    buttons.play:setOnClick(function() return script.toFrame(const.frames.game) end)
    buttons.options = Button.new("Options", fonts.default, nil, 0.5, 0.65, "center", "center")
    buttons.exit = Button.new("Exit", fonts.default, nil, 0.5, 0.8, "center", "center")
    buttons.exit:setOnClick(function() script.exit() end)

    -- Override buttons onHover/onUnhover behavior
    for _, button in pairs(buttons) do
        local onHover = function() script.changeColor(button, { 140 / 255, 220 / 255, 1, a }) end
        local onUnhover = function() script.changeColor(button, button:getColor()) end

        button:setOnHover(onHover)
        button:setOnUnhover(onUnhover)
        menu.UI:addWidget(const.widgets.button, button) -- Attach UI elements to actual UI
    end

    menu.UI:addWidget(const.widgets.button, Button.new("Morse", fonts.title, nil, 0.5, 0.2, "center", "center"))

    return menu
end

function menu:update(dt)
    local ret = self.UI:update(dt)
    if ret then return ret end
end

function menu:draw()
    self.UI:draw()  
end

function menu:resize(w, h, oldw, oldy)
    self.UI:resize(w, h, oldw, oldy)
end

return menu