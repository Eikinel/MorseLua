local go = {}
go.__index = go

local function getAlignFactor(mode)
    if type(mode) == "number" then return mode end

    local align = {
        up = 0, left = 0,
        center = 0.5,
        down = 1, right = 1
    }

    return align[mode]
end

function go.new(x, y, w, h, halign, valign)
    local t = {}

    t.parent = nil
    t.type = const.gameobjects.gameobject
    t.children = {}
    t.width = w or 0
    t.height = h or 0
    t.halign = halign or "left"
    t.valign = valign or "left"
    t.iposition = { x = x or 0, y = y or 0 } -- Initial position
    t.lposition = { x = t.iposition.x, y = t.iposition.y } -- Local position, without transform
    t.gposition = { x = t.iposition.x, y = t.iposition.y } -- Global position, computing transforms
    t.disabled = false


    -- Setters
    function t:setParent(object)
        self.parent = object
    end

    function t:setPosition(x, y, w, h)
        self.lposition.x = w * x
        self.lposition.y = h * y
        self.gposition.x = self.lposition.x - self.width * getAlignFactor(self.halign)
        self.gposition.y = self.lposition.y - self.height * getAlignFactor(self.valign)
    end

    function t:setSize(w, h)
        self.width = w
        self.height = h
    end

    function t:disable(bool)
        t.disabled = bool or true
    end


    -- Getters
    function t:getParent()
        return self.parent
    end

    function t:getInitialPosition()
        return self.iposition.x, self.iposition.y
    end

    function t:getLocalPosition()
        return self.lposition.x, self.lposition.y
    end

    function t:getGlobalPosition()
        return self.gposition.x, self.gposition.y
    end

    function t:getSize()
        return self.width, self.height
    end
    
    function t:isDisabled()
        return self.disabled
    end


    -- Getters
    function t:getChildren()
        return self.children
    end

    function t:getChildrenByType(type)
        for wtype, children in pairs(self.children) do
            if wtype == type then return children end
        end
    end


    -- Setters
    function t:addChild(child)
        child:setParent(self)
        
        local x, y = child:getInitialPosition()
        local w, h = child:getParent():getSize()

        child:setPosition(x, y, w, h)

        if not self.children[type] then self.children[type] = {} end
        table.insert(self.children[type], child)
    end

    
    -- Default events
    function t:update(dt)
        if not self:isDisabled() then
            for _, children in pairs(self.children) do
                for _, child in ipairs(children) do
                    local ret = child:update(dt)
                    if ret then return ret end
                end
            end
        end
    end

    function t:draw()
        if not self:isDisabled() then
            for _, children in pairs(self.children) do
                for _, child in ipairs(children) do
                    child:draw()
                end
            end
        end
    end

    function t:resize(w, h, oldw, oldh)
        self.width = self.width * (w / oldw)
        self.height = self.height * (h / oldh)

        for _, children in pairs(self.children) do
            for _, child in ipairs(children) do
                child:resize(w, h, oldw, oldh)
            end
        end 
    end

    return setmetatable(t, go)
end

return go