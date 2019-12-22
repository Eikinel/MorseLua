local const = {}

const.name = "Morse"

-- Folder management
const.folders = {
    sources = "sources/",
    assets = "assets/",
    deps = "deps/"
}

const.folders.frames = const.folders.sources .. "frames/"
const.folders.objects = const.folders.sources .. "objects/"
const.folders.scripts = const.folders.sources .. "scripts/"
const.folders.tools = const.folders.sources .. "tools/"
const.folders.fonts = const.folders.assets .. "fonts/"

-- Frames names
const.frames = {
    splashscreen = "splashscreen",
    menu = "menu",
    game = "game"
}

-- GO types
const.gameobjects = {
    gameobject = "gameobject",
    text = "text",
    image = "image",
    button = "button"
}

-- Save files
const.saves = {}
const.saves.settings = {
    filename = "settings.lua",
    path = love.filesystem.getSaveDirectory() .. "/settings.lua"
}

return const