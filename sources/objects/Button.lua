local Button = {}
Button.__index = Button

local function getAlignFactor(type)
    local align = {
        up = 0, left = 0,
        center = 0.5,
        down = 1, right = 1
    }

    return align[type]
end


-- Initializer
function Button.new(string, font, image, x, y, halign, valign)
    local t = {}

    if not halign then halign = "left" end
    if not valign then valign = "up" end

    t.type = const.widgets.button
    t.string = string
    t.text = love.graphics.newText(font, string)
    t.image = image
    t.halign = halign
    t.valign = valign
    t.localposition = { x = x, y = y } -- Raw position
    t.color = { r or 1, g or 1, b or 1, a or 1}
    
    t.disabled = false
    t.hovered = false
    t.clicked = false
    t.onHover = function() end
    t.onUnhover = function() end
    t.onClick = function() end

    return setmetatable(t, Button)
end


-- Getters
function Button:getString()
    return self.string
end

function Button:getText()
    return self.text
end

function Button:getImage()
    return self.image
end

function Button:getLocalPosition()
    return self.localposition.x, self.localposition.y
end

function Button:getGlobalPosition()
    local x, y = self:getLocalPosition()

    return x - self.text:getWidth() * getAlignFactor(self.halign), y - self.text:getHeight() * getAlignFactor(self.valign)
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


-- Setters
function Button:setOnHover(callback)
    self.onHover = function () self.hovered = true return callback() end
end

function Button:setOnUnhover(callback)
    self.onUnhover = function () self.hovered = false return callback() end
end

function Button:setOnClick(callback)
    self.onClick = function () self.clicked = true return callback() end
end

function Button:setPosition(x, y)
    self.localposition.x = x
    self.localposition.y = y
end


-- Events
function Button:isHovered()
    local x, y = love.mouse.getPosition()
    local tx, ty = self:getGlobalPosition()

    if x >= tx and x <= tx + self:getWidth()
    and y >= ty and y <= ty + self:getHeight() then
        return true
    end

    return false
end

function Button:isClicked()
    return love.mouse.isDown(1)
end

function Button:update(dt)
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

function Button:draw()
    if self:getImage() then love.graphics.draw(self:getImage()) end
    
    love.graphics.setColor(self:getColor())
    love.graphics.draw(self:getText(), self:getGlobalPosition())
end

return Button