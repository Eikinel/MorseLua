function love.load()
    local const = require("const")
    local Button = require(const.folders.objects .. "Button")
    require(const.folders.tools .. "showtable") -- Debug

    -- Assets loader
    fonts = {}
    fonts.title = love.graphics.newFont(const.folders.fonts .. "TovariSans.ttf", 84)
    fonts.default = love.graphics.newFont(const.folders.fonts .. "TovariSans.ttf", 42)

    buttons = {}
    table.insert(buttons, Button:new("Play", fonts.default, nil, 300, 300))
    table.insert(buttons, Button:new("Options", fonts.default , nil, 400, 400))
    table.insert(buttons, Button:new("Exit", fonts.default , nil, 500, 500))
end

function love.update(dt)
    local mousex, mousey = love.mouse.getPosition()

    for _, button in ipairs(buttons) do
        if not button:isDisabled() then
            button:update(dt, mousex, mousey)
        end
    end
end

function love.draw()
    for _, button in ipairs(buttons) do
        button:draw()
    end
end