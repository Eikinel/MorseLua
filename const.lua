local const = {}

-- Folder management
const.folders = {
    sources = "sources/",
    assets = "assets/"
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

-- Widget types
const.widgets = {
    button = "button"
}

-- TO PUT IN OPTIONS CONFIG FILE AFTER
-- FPS management
const.fps = 60

return const