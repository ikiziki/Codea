-- World
-- chris geese @ 2026

World = class("World")

function World:init()
    self.theme = ThemeEngine()
    self.atoms = {}
    self.grid = SpatialGrid(100)
    self.nearby = {}
    self.fps = 60
    
    for i = 1,250 do
        self.atoms[#self.atoms + 1] = Atom()
    end
end

function World:update(dt)
    self.theme:update()
    
    self.fps = self.fps * 0.95 + (1 / dt) * 0.05
    
    local atoms = self.atoms
    local count = #atoms
    
    -- Apply interactions
    self.grid:clear()
    
    for i = 1,count do
        self.grid:insert(atoms[i])
    end
    
    for i = 1,count do
        self:interact(atoms[i],dt)
    end
    
    -- Limit speed and move
    for i = 1,count do
        local atom = atoms[i]
        atom:limitSpeed()
        atom:update(dt)
    end
end

function World:interact(atom,dt)
    local x = atom.pos.x
    local y = atom.pos.y
    local radius = atom.interactionRadius
    local nearby = self.nearby
    local count = self.grid:query(x,y,radius,nearby)
    local matrix = rules.matrix
    local type = atom.type
    
    for i = 1,count do
        local other = nearby[i]
        
        if other ~= atom then
            local dx = other.pos.x - x
            local dy = other.pos.y - y
            local distSq = dx * dx + dy * dy
            
            if distSq > 0 then
                local rule = matrix[type][other.type]
                
                if rule ~= 0 then
                    local dist = math.sqrt(distSq)
                    local force = rule * 100 * dt
                    
                    atom.vel.x = atom.vel.x + dx / dist * force
                    atom.vel.y = atom.vel.y + dy / dist * force
                end
            end
        end
    end
end

function World:touched(touch)
    if touch.state == BEGAN then
        self.atoms[#self.atoms + 1] = Atom(nil,vec2(touch.x,touch.y))
    end
end

function World:draw()
    background(self.theme.bg)
    
    local atoms = self.atoms
    local count = #atoms
    
    for i = 1,count do
        atoms[i]:draw(self.theme)
    end
    
    if rules.showGrid then
        self.grid:draw(self.theme.fg)
    end
    
    fill(self.theme.fg)
    noStroke()
    textAlign(LEFT)
    fontSize(14)
    
    text("FPS: "..math.floor(self.fps),70,HEIGHT - 50)
    text("ATOMS: "..count,100,HEIGHT - 70)
end