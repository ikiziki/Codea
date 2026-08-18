-- handles theme changes
-- chris geese @ 2026

ThemeEngine = class("ThemeEngine")

function ThemeEngine:init()
    self.style = self:get()
end

function ThemeEngine:update()
    local style = self:get()
    if style ~= self.style then
        self.style = style
    end
end

function ThemeEngine:get()
    return objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
end