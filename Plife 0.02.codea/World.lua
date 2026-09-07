World = class("World")

function World:init()
    self.theme = ThemeEngine()
    self.width = WIDTH * 3
    self.height = HEIGHT * 3
    self.camera = Camera(self)
    self.grid = Grid(self)
    self.atoms = {}
end

function World:update(dt)
end

function World:draw()
    background(self.theme.bg)
    self.camera:apply()
    self.camera:remove()
end

function World:touched(touch)
end
