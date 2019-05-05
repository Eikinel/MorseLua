local Button = {}
Button.__index = Button

function Button.new(string, font, image, posx, posy, indent)
    local t = {}

    t.string = string
    t.text = love.graphics.newText(font, string)
    t.image = image
    t.position = { x = posx, y = posy }
    t.indent = indent
    t.color = { r or 1, g or 1, b or 1, a or 1}
    
    t.disabled = false
    t.hovered = false
    t.onHover = function() t.text:set({ { 140 / 255, 220 / 255, 1, a }, t.string }) end
    t.onUnhover = function() t.text:set({ t.color, t.string }) end

    return setmetatable(t, Button)
end


-- Getters
function Button:getText()
    return self.text
end

function Button:getImage()
    return self.image
end

function Button:getPosition()
    return self.position
end

function Button:getX()
    return self.position.x
end

function Button:getY()
    return self.position.y
end

function Button:getColor()
    return self.color
end

function Button:getWidth()
    return self:getText():getWidth()
end

function Button:getHeight()
    return self:getText():getHeight()
end

function Button:isDisabled()
    return self.disabled
end


-- Events
function Button:isHovered()
    local x, y = love.mouse.getPosition()

    if x >= self:getX() and x <= self:getX() + self:getWidth()
    and y >= self:getY() and y <= self:getY() + self:getHeight() then
        return true
    end

    return false
end

function Button:update(dt)
    -- Call onHover/onUnhover once
    if self:isHovered() then
        if not self.hovered then self.onHover() self.hovered = true end
    else
        if self.hovered then self.onUnhover() self.hovered = false end
    end
end

function Button:draw()
    if self:getImage() then love.graphics.draw(self:getImage()) end
    
    love.graphics.setColor(self:getColor())
    love.graphics.draw(self:getText(), self:getX(), self:getY())
end

return Button