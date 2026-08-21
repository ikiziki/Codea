-- a class for handling system themes
-- chris geese @ 2026

ThemeEngine = class("ThemeEngine")
function ThemeEngine:init()
    self.style = self:get()
    self:setColors()
end

function ThemeEngine:update()
    local style = self:get()
    if style ~= self.style then
        self.style = style
    end
    self:setColors()
end

function ThemeEngine:get()
    return objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
end

function ThemeEngine:setColors()
    if self.style == 1.0 then
        self.BG = color(235)
        self.FG = color(35)
        self.BTN = color(35,35,35,192)
        self.TXT = color(35)
    elseif self.style == 2.0 then
        self.BG = color(35)
        self.FG = color(235)
        self.BTN = color(235,235,235,192)
        self.TXT = color(235)
    end
end