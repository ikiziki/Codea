World = class("World")

function World:init()
    self.theme = ThemeEngine()
    self.width = WIDTH * 3
    self.height = HEIGHT * 3
    self.camera = Camera(self)
    self.grid = Grid(self)
    self.atoms = {}
    
    for i = 1,500 do
        self.atoms[#self.atoms + 1] = Atom(self)
    end
end

function World:update(dt)
    self.grid:clear()
    
    for i = 1, #self.atoms do
        self.grid:insert(self.atoms[i])
    end
    
    for i = 1, #self.atoms do
        self:repel(self.atoms[i], dt)
    end
    
    for i = 1, #self.atoms do
        self.atoms[i]:update(dt)
    end
end

function World:repel(atom, dt)
    local nearby = self.grid:query(atom.pos, InteractionRange)
    
    for i = 1,#nearby do
        local other = nearby[i]
        
        if other ~= atom then
            local delta = atom.pos - other.pos
            local distance = delta.length
            
            if distance > 0 and distance < InteractionRange then
                local force = RepulsionStrength *
                (1 - distance / InteractionRange)
                
                atom.vel = atom.vel +
                delta:normalize() * force * dt
            end
        end
    end
end

function World:draw()
    self.theme:update()
    background(self.theme.bg)
    self.camera:apply()
    
    for i = 1,#self.atoms do
        self.atoms[i]:draw()
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