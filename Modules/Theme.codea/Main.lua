-- a class for handling system themes
-- chris geese @ 2026

ThemeEngine = class("ThemeEngine")

function ThemeEngine:init()
    self.style = self:get()
end

-- updates the current style
function ThemeEngine:update()
    local style = self:get()
    
    if style ~= self.style then
        self.style = style
    end
end

-- probes the system for current interface style
-- 1.0 = light
-- 2.0 = dark
function ThemeEngine:get()
    return objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
end


-- example
--
-- theme = ThemeEngine()
--
-- function update(dt)
--   theme:update()
--
--   if theme.style == 1.0 then
--     -- light theme
--   elseif theme.style == 2.0 then
--     -- dark theme
--   end
-- end