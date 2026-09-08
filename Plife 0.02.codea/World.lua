World = class("World")

function World:init()
    self.theme = ThemeEngine()
    
    self.width = WIDTH * 3
    self.height = HEIGHT * 3
    
    self.camera = Camera(self)
    self.grid = Grid(self)
    
    self.atoms = {}
    
    for i = 1,250 do
        self.atoms[#self.atoms + 1] = Atom(self)
    end
end

function World:update(dt)
    self.grid:clear()
    
    for i = 1,#self.atoms do
        self.grid:insert(self.atoms[i])
    end
end

function World:draw()
    background(self.theme.bg)
    
    self.camera:apply()
    
    if showGrid then
        self.grid:drawGrid(self.theme.fg)
    end
    
    if showHeatmap then
        self.grid:drawHeatmap()
    end
    
    for i = 1,#self.atoms do
        self.atoms[i]:draw()
    end
    
    self.camera:remove()
end

function World:touched(touch)
end