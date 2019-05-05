local game = {}
game.state = "game"
game.__index = game

function game.new()
    print("Creating new game")
    
    local UI = require(const.folders.objects .. "UI")
    local Button = require(const.folders.objects .. "Button")

    local fonts = {}
    fonts.title = love.graphics.newFont(const.folders.fonts .. "TovariSans.ttf", 168)
    fonts.default = love.graphics.newFont(const.folders.fonts .. "TovariSans.ttf", 84)

    game.UI = UI.new()

    return game
end

function game:update(dt)
    self.UI:update(dt)
end

function game:draw()
    self.UI:draw()  
end

return game