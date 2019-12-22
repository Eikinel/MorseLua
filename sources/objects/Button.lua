local Button = {}
Button.__index = Button

-- Initializer
function Button.new(children, x, y, halign, valign)
    local t = require(const.folders.objects .. "GameObject").new(x, y, 0, 0, halign, valign) -- Inherit from GameObject

    t:setType(const.gameobjects.button)
    t.hovered = false
    t.clicked = false
    t.onHover = function() end
    t.onUnhover = function() end
    t.onClick = function() end
    
    for _, child in ipairs(children) do
        local sw, sh = t:getSize()
        local cw, ch = child:getSize()

        if cw > sw then t:setWidth(cw) end
        if ch > sh then t:setHeight(ch) end
    end

    for _, child in ipairs(children) do
        t:addChild(child)
    end


    -- Setters
    function t:setOnHover(callback)
        self.onHover = function () self.hovered = true return callback() end
    end

    function t:setOnUnhover(callback)
        self.onUnhover = function () self.hovered = false return callback() end
    end

    function t:setOnClick(callback)
        self.onClick = function () self.clicked = true return callback() end
    end

    function t:isHovered()
        local x, y = love.mouse.getPosition()

        if x >= self:getGlobalX() and x <= self:getGlobalX() + self:getWidth()
        and y >= self:getGlobalY() and y <= self:getGlobalY() + self:getHeight() then
            return true
        end

        return false
    end


    -- Events
    function t:update(dt)
        -- Call onHover/onUnhover once
        if self:isHovered() then
            if not self.hovered then self.onHover() end

            if love.mouse.isDown(1) then
                if not self.clicked then return self.onClick() end
            else
                if self.clicked then
                    self.clicked = false 
                end
            end
        else
            if self.hovered then 
                self.onUnhover()
            end
        end

        self:updateChildren(dt)
    end

    function t:draw()
        self:drawChildren()
    end

    return setmetatable(t, Button)
end

return Button