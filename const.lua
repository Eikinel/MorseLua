local const = {}

const.folders = {
    sources = "sources/",
    assets = "assets/"
}

const.folders.objects = const.folders.sources .. "objects/"
const.folders.tools = const.folders.sources .. "tools/"
const.folders.scripts = const.folders.sources .. "scripts/"
const.folders.fonts = const.folders.assets .. "fonts/"

return const