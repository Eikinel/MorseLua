local config = {}
config.__index = config

function config.getConfig()
    local const = require("const")
    local file = io.open(const.config, "r")
    local conf = nil
    
    if file then
        local json = require(const.folders.deps .. "json/json")
        conf = json.decode(file:read("*a"))
        file:close()
    end

    return conf
end

return config