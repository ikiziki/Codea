World = class("World")

function World:init()
    self.theme = ThemeEngine()
    self.width = WIDTH * 3
    self.height = HEIGHT * 3
    self.camera = Camera(self)
    self.grid = Grid(self)
    self.atoms = {}
    
    for i = 1,1000 do
        local atom = Atom(self)
        atom.id = i
        self.atoms[i] = atom
    end
end

function World:update(dt)
    local atoms = self.atoms
    local grid = self.grid
    local count = #atoms
    grid:clear()
    for i = 1,count do
        grid:insert(atoms[i])
    end
    for i = 1,count do
        grid:repel(atoms[i], dt)
    end
    for i = 1,count do
        atoms[i]:update(dt)
    end
end

function World:draw()
    self.theme:update()
    background(self.theme.bg)
    
    self.camera:apply() 
    local atoms = self.atoms
    for i = 1,#atoms do
        atoms[i]:draw()
    end
    if showGrid then
        self.grid:drawGrid(self.theme.fg)
    end
    if showHeatmap then
        self.grid:drawHeatmap()
    end
    self.camera:remove()
end

function World:touched(touch)
end