local go = {}
go.__index = go

local function getAlignFactor(mode)
    local align = {
        up = 0, left = 0,
        center = 0.5,
        down = 1, right = 1
    }

    return align[mode]
end

function go.new(x, y, w, h, halign, valign)
    local t = {}

    x = x or 0
    y = y or 0
    w = w or 0
    h = h or 0
    halign = halign or "left"
    valign = valign or "up"


    -- Setters
    function t:setParent(object) self.parent = object end
    function t:setType(type) self.type = type end
    function t:setWidth(width) self.width = width end
    function t:setHeight(height) self.height = height end
    function t:disable(bool) t.disabled = bool or true end

    function t:setSize(w, h)
        self.width = w
        self.height = h
    end

    -- Sets local position and compute other positions accordingly, recursively for each child
    function t:setPosition(x, y)
        self.lposition.x = x
        self.lposition.y = y
        self.gposition.x = x - self:getWidth() * self:getHorizontalAlign()
        self.gposition.y = y - self:getHeight() * self:getVerticalAlign()
    end

    function t:addChild(child)
        if not self.children[type] then self.children[type] = {} end
        table.insert(self.children[type], child)

        child:setParent(self)
        child:setPosition(
            self:getGlobalX() + child:getLocalX(),
            self:getGlobalY() + child:getLocalY())

        for _, nchildren in pairs(child:getChildren()) do
            for _, nchild in ipairs(nchildren) do
                nchild:setPosition(nchild:getParent():getGlobalPosition())
            end
        end
    end


    -- Getters
    function t:getParent() return self.parent end
    function t:getChildren() return self.children end
    function t:getType() return self.type end
    function t:getLocalPosition() return self.lposition.x, self.lposition.y end
    function t:getLocalX() return self.lposition.x end
    function t:getLocalY() return self.lposition.y end
    function t:getGlobalPosition() return self.gposition.x, self.gposition.y end
    function t:getGlobalX() return self.gposition.x end
    function t:getGlobalY() return self.gposition.y end
    function t:getSize() return self.width, self.height end
    function t:getWidth() return self.width end
    function t:getHeight() return self.height end
    function t:getHorizontalAlign() return getAlignFactor(self.halign) end
    function t:getVerticalAlign() return getAlignFactor(self.valign) end
    function t:isDisabled() return self.disabled end

    function t:getParentOrWindowSize()
        local w, h = love.graphics.getDimensions()
        if self:getParent() then w, h = self:getParent():getSize() end

        return w, h
    end

    function t:getBoundaries()
        return
        { 
            self:getGlobalX(), self:getGlobalY(),
            self:getGlobalX() + self:getWidth(), self:getGlobalY(),
            self:getGlobalX() + self:getWidth(), self:getGlobalY() + self:getHeight(),
            self:getGlobalX(), self:getGlobalY() + self:getHeight(),
            self:getGlobalX(), self:getGlobalY()
        }
    end

    function t:getChildrenByType(type)
        for wtype, children in pairs(self.children) do
            if wtype == type then return children end
        end
    end

    
    -- Default events
    function t:updateChildren(dt)
        if not self:isDisabled() then
            for _, children in pairs(self.children) do
                for _, child in ipairs(children) do
                    local ret = child:update(dt)
                    if ret then return ret end
                end
            end
        end
    end

    function t:drawChildren()
        if not self:isDisabled() then
            for _, children in pairs(self.children) do
                for _, child in ipairs(children) do
                    child:draw()
                    
                    if conf.debug then
                        local jaj = { gameobject = {0, 0, 1, 1}, button = {1, 0, 0, 1}, text = {0, 1, 0, 1}}
                        local r, g, b, a = love.graphics.getColor()
            
                        love.graphics.setColor(jaj[self:getType()])
                        love.graphics.line(self:getBoundaries())
                        love.graphics.setColor(r, g, b, a)
                    end
                end
            end
        end
    end

    function t:resizeChildren(scalex, scaley)
        for _, children in pairs(self:getChildren()) do
            for _, child in ipairs(children) do
                child:resize(scalex, scaley)
            end
        end
    end

    function t:update(dt)
        local ret = self:updateChildren(dt)
        if ret then return ret end
    end
    
    function t:draw() self:drawChildren() end
    function t:resize(scalex, scaley)
        self:setSize(self:getWidth() * scalex, self:getHeight() * scaley)
        self:setPosition(self:getLocalX() * scalex, self:getLocalY() * scaley)
        self:resizeChildren(scalex, scaley)
    end

    
    t.parent = nil
    t.type = const.gameobjects.gameobject
    t.children = {}
    t.width = w
    t.height = h
    t.lposition = {} -- Local position in pixel, without transform, absolute to window
    t.gposition = {} -- Global position in pixel, computing transforms, absolute to window
    t.halign = halign
    t.valign = valign
    t.disabled = false
    t:setPosition(x, y)

    return setmetatable(t, go)
end

return go