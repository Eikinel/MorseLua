local UI = {}
UI.__index = UI

function UI.new()
    local t = {}

    t.widgets = {}

    return setmetatable(t, UI)
end


-- Getters
function UI:getWidgets()
    return self.widgets
end

function UI:getWidgetsByType(type)
    for wtype, widget in pairs(self.widgets) do
        if wtype == type then return widget end
    end
end


-- Setters
function UI:addWidget(type, widget)
    if not self.widgets[type] then self.widgets[type] = {} end
    table.insert(self.widgets[type], widget)
end


-- Events
function UI:update(dt)
    for _, widgets in pairs(self.widgets) do
        for _, widget in ipairs(widgets) do
            local ret = widget:update(dt)
            if ret then return ret end
        end
    end
end

function UI:draw()
    for _, widgets in pairs(self.widgets) do
        for _, widget in ipairs(widgets) do
            widget:draw()
        end
    end    
end

function UI:resize(w, h, oldw, oldy)
    for _, widgets in pairs(self.widgets) do
        for _, widget in ipairs(widgets) do
            widget:resize(w, h, oldw, oldy)
        end
    end 
end

return UI