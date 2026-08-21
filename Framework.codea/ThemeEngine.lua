-- a class for handling system themes
-- chris geese @ 2026

-- exposes style 
ThemeEngine = class("ThemeEngine")
function ThemeEngine:init()
    self.style = self:get()
end

-- set current theme
function ThemeEngine:update()
    local style = self:get()
    if style ~= self.style then
        self.style = style
    end
end

-- check current theme
function ThemeEngine:get()
    return objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
end