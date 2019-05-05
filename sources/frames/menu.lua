local menu = {}
menu.__index = menu

function menu.new()
    local UI = require(const.folders.objects .. "UI")
    local Button = require(const.folders.objects .. "Button")
    local w, h = love.graphics.getDimensions()

    local fonts = {}
    fonts.title = love.graphics.newFont(const.folders.fonts .. "TovariSans.ttf", 168)
    fonts.default = love.graphics.newFont(const.folders.fonts .. "TovariSans.ttf", 84)

    menu.UI = UI.new()
    menu.UI:addWidget(const.widgets.button, Button.new("Play", fonts.default, nil, w * 0.5, h * 0.33, "center", "center"))
    menu.UI:addWidget(const.widgets.button, Button.new("Options", fonts.default, nil, w * 0.5, h * 0.5, "center", "center"))
    menu.UI:addWidget(const.widgets.button, Button.new("Exit", fonts.default, nil, w * 0.5, h * 0.66, "center", "center"))

    return menu
end

function menu:update(dt)
    self.UI:update(dt)
end

function menu:draw()
    self.UI:draw()  
end

return menu