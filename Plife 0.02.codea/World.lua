World = class("World")

function World:init()
    self.theme = ThemeEngine()
    self.width = WIDTH * 3
    self.height = HEIGHT * 3
end

function World:update(dt)
end

function World:draw()
    background(self.theme.bg)
end

function World:touched(touch)
end
