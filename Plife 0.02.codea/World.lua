World = class("World")

function World:init()
    self.theme = ThemeEngine()
end

function World:update(dt)
    self.theme:update()
end

function World:draw()
    background(self.theme.bg)
end

function World:touched(touch)
end
