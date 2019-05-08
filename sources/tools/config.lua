local config = {}
config.__index = config

local function openConfigFile(mode)
    local const = require("const")
    local file = love.filesystem.newFile(const.config)
    local ok, err = file:open(mode)

    if not ok then print (err) return end

    return file
end

function config.init()
    local file = openConfigFile("r")
    if not file then return end

    local const = require("const")
    local json = require(const.folders.deps .. "json/json")
    config.data = json.decode(file:read())
    file:close()

    return config
end

function config:get(key)
    if not self.data then print("Empty conf data") return end
    return key and self.data[key] or self.data
end

function config:update(table)
    for key, value in pairs(table) do

    end
end

return config