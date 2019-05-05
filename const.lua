local const = {}

const.folders = {
    sources = "sources/",
    assets = "assets/"
}

const.folders.frames = const.folders.sources .. "frames/"
const.folders.objects = const.folders.sources .. "objects/"
const.folders.scripts = const.folders.sources .. "scripts/"
const.folders.tools = const.folders.sources .. "tools/"
const.folders.fonts = const.folders.assets .. "fonts/"

const.frames = {
    splashscreen = "splashscreen",
    menu = "menu",
    game = "game"
}

return const