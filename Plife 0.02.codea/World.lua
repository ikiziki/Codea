World = class("World")

function World:init()
    self.width = WIDTH * 3
    self.height = HEIGHT * 3
    self.theme = ThemeEngine()
    self.grid = Grid(self, 100)
end

function World:update(dt)
    self.theme:update()
end

function World:draw()
    background(self.theme.bg)
    if showGrid then
        self.grid:drawGrid(self.theme.fg)
    end
    if showHeatmap then
        self.grid:drawHeatmap()
    end
end

function World:touched(touch)
end
