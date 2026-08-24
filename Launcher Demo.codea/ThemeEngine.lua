-- a class for handling system themes
-- chris geese @ 2026

ThemeEngine = class("ThemeEngine")

function ThemeEngine:init()
    self.style = self:get()
    self.fg = nil
    self.bg = nil
end

function ThemeEngine:update()
    local style = self:get() 
    if style ~= self.style then
        self.style = style
    end
    if self.style == 1.0 then
        self.bg = color(235)
        self.fg = color(35)
    elseif self.style == 2.0 then
        self.bg = color(35)
        self.fg = color(235)
    end
end

function ThemeEngine:get()
    return objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
end