local Button = {}
Button.__index = Button

-- Initializer
function Button.new(string, font, image, x, y, halign, valign)
    local t = require(const.folders.objects .. "GameObject").new(x, y, 0, 0, halign, valign) -- Inherit from GameObject

    t.type = const.gameobjects.button
    t.string = string or ""
    t.font = font
    t.image = image
    t.color = { r or 1, g or 1, b or 1, a or 1}

    t.hovered = false
    t.clicked = false
    t.onHover = function() end
    t.onUnhover = function() end
    t.onClick = function() end

    function t:setText(font, string)
        self.string = string
        self.text = love.graphics.newText(font, string)
        t:setSize(t.text:getWidth(), t.text:getHeight())
    end

    local w, h = love.graphics.getDimensions()
    w, h = t:getParent() and t:getParent():getSize() or w, h

    t:setText(love.graphics.newFont(font.name, (w * font.sizefactor) / (w / h)), string)
    t:setPosition(x, y, t:getSize())

    -- Getters
    function t:getString()
        return self.string
    end

    function t:getText()
        return self.text
    end

    function t:getImage()
        return self.image
    end

    function t:getColor()
        return self.color
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


    -- Events
    function t:isHovered()
        local x, y = love.mouse.getPosition()
        local tx, ty = self:getGlobalPosition()
        local w, h = self:getSize()

        if x >= tx and x <= tx + w
        and y >= ty and y <= ty + h then
            return true
        end

        return false
    end

    function t:isClicked()
        return love.mouse.isDown(1)
    end

    function t:update(dt)
        -- Call onHover/onUnhover once
        if self:isHovered() then
            if not self.hovered then self.onHover() end

            if self:isClicked() then
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
    end

    function t:draw()
        if self:getImage() then love.graphics.draw(self:getImage()) end
        
        love.graphics.setColor(self:getColor())
        love.graphics.draw(self:getText(), self:getGlobalPosition())
    end

    function t:resize(w, h, oldw, oldh)
        local x, y = self:getLocalPosition()

        if self.string then
            local font = love.graphics.newFont(self.font.name, (w * self.font.sizefactor) / (w / h))

            self:setText(font, self.string)
        end
        
        -- Set position after text font size changed (it is used to center text according to its size)
        self:setPosition(x / oldw, y / oldh, w, h) -- Get position in percentage between 0 to 1, then setPosition compute new position with the window's new size
    end

    return setmetatable(t, Button)
end

return Button