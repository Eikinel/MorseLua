local menu = {}
menu.__index = menu

function menu.new()
    local Button = require(const.folders.objects .. "Button")
    local UI = require(const.folders.objects .. "UI")

    local fonts = {}
    fonts.title = love.graphics.newFont(const.folders.fonts .. "TovariSans.ttf", 168)
    fonts.default = love.graphics.newFont(const.folders.fonts .. "TovariSans.ttf", 84)

    local buttons = {}
    table.insert(buttons, Button.new("Play", fonts.default, nil, 300, 300))
    table.insert(buttons, Button.new("Options", fonts.default , nil, 400, 400))
    table.insert(buttons, Button.new("Exit", fonts.default , nil, 500, 500))

    menu.UI = UI.new()
    menu.UI:addButtons(buttons)

    return menu
end

function menu:update(dt)
    local mousex, mousey = love.mouse.getPosition()

    for _, button in ipairs(self.UI:getButtons()) do
        if not button:isDisabled() then
            button:update(dt, mousex, mousey)
        end
    end
end

function menu:draw()
    for _, button in ipairs(self.UI.buttons) do
        button:draw()
    end
end

return menu