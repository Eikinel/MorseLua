local game = {}
game.state = "game"
game.__index = game

function game.new()
    print("Creating new game")
    
    local UI = require(const.folders.objects .. "UI")
    local Button = require(const.folders.objects .. "Button")

    local fonts = {}
    fonts.default = { name = const.folders.fonts .. "TovariSans.ttf", sizefactor = 0.05 }

    game.UI = UI.new()

    return game
end

function game:update(dt)
    local ret = self.UI:update(dt)
    if ret then return ret end
end

function game:draw()
    self.UI:draw()  
end

function game:resize(w, h)
    self.UI:resize(w, h)
end

return game