-- a class for handling system themes
-- chris geese @ 2026

ThemeEngine = class("ThemeEngine")

function ThemeEngine:init()
    self.style = self:get()
    self.bg = nil
    self.fg = nil
    self.stroke = nil
    self.colors = nil
end

function ThemeEngine:update()
    local style = self:get() 
    if style ~= self.style then
        self.style = style
    end
    if self.style == 1.0 then
        self.bg = color(235)
        self.fg = color(35)
        self.stroke = color(35)
        self.colors = {
            A = color(235,155,165),
            B = color(155,205,235),
            C = color(155,225,175),
            D = color(235,195,155),
            E = color(195,160,230) 
        }
    elseif self.style == 2.0 then
        self.bg = color(35)
        self.fg = color(235)
        self.stroke = color(235)
        self.colors = {
            A = color(255,179,186),
            B = color(186,225,255),
            C = color(186,255,201),
            D = color(255,223,186),
            E = color(218,186,255) 
        }
    end
end

function ThemeEngine:atomColor(type)
    return self.colors[type]
end

function ThemeEngine:get()
    return objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
end