ThemeEngine = class("ThemeEngine")

function ThemeEngine:init()
    self:update()
end

function ThemeEngine:update()
    self.style = self:get()
    
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