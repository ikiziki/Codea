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
        self:interact(atoms[i], dt)
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

function World:interact(atom, dt)
    local grid = self.grid
    local pos = atom.pos
    local vel = atom.vel
    
    local interactionRange = InteractionRange
    local interactionRange2 = interactionRange * interactionRange
    
    local repelRange = RepulsionRange
    local repelRange2 = repelRange * repelRange
    
    local searchRange = math.max(interactionRange, repelRange)
    local searchRange2 = searchRange * searchRange
    
    local cellSize = grid.cellSize
    local cells = grid.cells
    
    local minX = math.max(1, math.floor((pos.x - searchRange) / cellSize) + 1)
    local maxX = math.min(grid.cols, math.floor((pos.x + searchRange) / cellSize) + 1)
    local minY = math.max(1, math.floor((pos.y - searchRange) / cellSize) + 1)
    local maxY = math.min(grid.rows, math.floor((pos.y + searchRange) / cellSize) + 1)
    
    for x = minX,maxX do
        local column = cells[x]
        
        for y = minY,maxY do
            local cell = column[y]
            local count = cell.n
            
            for i = 1,count do
                local other = cell[i]
                
                if other.id > atom.id then
                    local otherPos = other.pos
                    local dx = pos.x - otherPos.x
                    local dy = pos.y - otherPos.y
                    local distance2 = dx * dx + dy * dy
                    
                    if distance2 > 0 and distance2 < searchRange2 then
                        local distance = math.sqrt(distance2)
                        local inverseDistance = 1 / distance
                        local nx = dx * inverseDistance
                        local ny = dy * inverseDistance
                        
                        -- Universal repulsion
                        if distance2 < repelRange2 then
                            local strength = RepulsionStrength *
                            (1 - distance / repelRange) * dt
                            
                            local fx = nx * strength
                            local fy = ny * strength
                            
                            vel.x = vel.x + fx
                            vel.y = vel.y + fy
                            
                            other.vel.x = other.vel.x - fx
                            other.vel.y = other.vel.y - fy
                        end
                        
                        -- Species interactions
                        if distance2 < interactionRange2 then
                            local rule = rules.matrix[atom.species][other.species]
                            local otherRule = rules.matrix[other.species][atom.species]
                            
                            if rule ~= 0 then
                                local strength = rule *
                                InteractionStrength *
                                (1 - distance / interactionRange) * dt
                                
                                vel.x = vel.x - nx * strength
                                vel.y = vel.y - ny * strength
                            end
                            
                            if otherRule ~= 0 then
                                local strength = otherRule *
                                InteractionStrength *
                                (1 - distance / interactionRange) * dt
                                
                                other.vel.x = other.vel.x + nx * strength
                                other.vel.y = other.vel.y + ny * strength
                            end
                        end
                    end
                end
            end
        end
    end
end