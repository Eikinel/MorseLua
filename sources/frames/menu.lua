local menu = {}
menu.state = "menu"
menu.__index = menu

function menu.new()
    print("Creating new menu")

    local GO = require(const.folders.objects .. "GameObject")
    local Text = require(const.folders.objects .. "Text")
    local Button = require(const.folders.objects .. "Button")

    local w, h = love.graphics.getDimensions()

    menu.UI = GO.new(0, 0, w, h)
    w, h = menu.UI:getSize()

    local fonts = {}
    fonts.default = {const.folders.fonts .. "TovariSans.ttf", 0.1 }
    fonts.title = { const.folders.fonts .. "TovariSans.ttf", 0.25 }

    -- Create texts for buttons
    local texts = {}

    texts.title = Text.new(const.name, fonts.title, w * 0.5, h * 0.1, 0, 0, "center")
    texts.play = Text.new("Play", fonts.default)
    texts.options = Text.new("Options", fonts.default)
    texts.exit = Text.new("Exit", fonts.default)

    menu.UI:addChild(texts.title)

    -- Create buttons
    local buttons = {}
    local script = require(const.folders.scripts .. "button")

    buttons.play = Button.new({ texts.play }, w * 0.5, h * 0.5, "center")
    buttons.play:setOnClick(function() return script.toFrame(const.frames.game) end)
    buttons.options = Button.new({ texts.options }, w * 0.5, h * 0.65, "center")
    buttons.exit = Button.new({ texts.exit }, w * 0.5, h * 0.8, "center")
    buttons.exit:setOnClick(function() script.exit() end)

    -- Override buttons onHover/onUnhover behavior
    for _, button in pairs(buttons) do
        local onHover = function() script.changeTextColor(button, { 140 / 255, 220 / 255, 1, 1 }) end
        local onUnhover = function() script.changeTextColor(button, {1, 1, 1, 1}) end

        button:setOnHover(onHover)
        button:setOnUnhover(onUnhover)
        menu.UI:addChild(button) -- Attach UI elements to actual UI
    end

    return menu
end

function menu:update(dt)
    local ret = self.UI:update(dt)
    if ret then return ret end
end

function menu:draw()
    self.UI:draw()
end

return menu