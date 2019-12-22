local Text = {}
Text.__index = Text

function Text.new(string, font, x, y, w, h, halign, valign, wraplimit)
    local t = require(const.folders.objects .. "GameObject").new(x, y, w, h, halign, valign) -- Inherit from GameObject

    t:setType(const.gameobjects.text)
    t.string = string or ""
    t.fontname = font[1]
    t.fontsize = font[2]
    t.color = { r or 1, g or 1, b or 1, a or 1 }
    t.wraplimit = wraplimit


    -- Setters
    function t:setText(string)
        local w, h = love.graphics.getDimensions()
        local font = love.graphics.newFont(self.fontname, (w * self.fontsize) / (w / h))

        self.string = string
        self.text = love.graphics.newText(font, string)
        self.text:setf(
            string,
            self.wraplimit or self.text:getWidth(),
            self.halign)
        self:setSize(self.text:getWidth(), self.text:getHeight())
    end

    function t:setColor(color)
        self.color = color
    end
    

    -- Getters
    function t:getString()
        return self.string
    end

    function t:getFont()
        return self.fontname, self.fontsize
    end

    function t:getText()
        return self.text
    end

    function t:getColor()
        return self.color
    end


    -- Events
    function t:draw()
        love.graphics.setColor(self:getColor())
        love.graphics.draw(self:getText(), self:getGlobalPosition())
        self:drawChildren()
    end

    function t:resize(scalex, scaley)
        local parent = self:getParent()

        if self:getString() then self:setText(self:getString()) end
        self:setPosition(self:getLocalX() * scalex, self:getLocalY() * scaley)
        if parent and parent:getType() == const.gameobjects.button then parent:setSize(self:getSize()) end
        
        self:resizeChildren(scalex, scaley)
    end

    t:setText(t:getString())

    return setmetatable(t, Text)
end

return Text