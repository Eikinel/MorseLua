local game = {}
game.state = "game"
game.__index = game

function game.new()
    print("Creating new game")
    
    local GO = require(const.folders.objects .. "GameObject")
    local Button = require(const.folders.objects .. "Button")
    local SongLoader = require(const.folders.objects .. "SongLoader")

    local fonts = {}
    fonts.default = { name = const.folders.fonts .. "TovariSans.ttf", sizefactor = 0.05 }

    local w, h = love.graphics.getDimensions()

    game.UI = GO.new(0, 0, w, h)
    game.pauseUI = GO.new(0, 0, w * 0.5, h * 0.5, "center", "center")
    game.pauseUI:disable(true)

    return game
end

function game:update(dt)
    local ret = self.UI:update(dt)
    if ret then return ret end
end

function game:draw()
    self.UI:draw()
    self.pauseUI:draw()
end

function game:resize(w, h)
    self.UI:resize(w, h)
    self.pauseUI:resize(w, h)
end

return game