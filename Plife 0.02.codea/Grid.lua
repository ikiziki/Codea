Grid = class("Grid")

function Grid:init(world, cellSize)
    self.world = world
    self.cellSize = cellSize or 100
    self.cols = math.ceil(world.width / self.cellSize)
    self.rows = math.ceil(world.height / self.cellSize)
    self.cells = {}
    self.activeCells = {}
    self.activeCount = 0
    for x = 1,self.cols do
        local column = {}
        self.cells[x] = column
        for y = 1,self.rows do
            column[y] = {n = 0}
        end
    end
end

function Grid:clear()
    local activeCells = self.activeCells
    local count = self.activeCount
    for i = 1,count do
        activeCells[i].n = 0
    end
    self.activeCount = 0
end

function Grid:insert(atom)
    local pos = atom.pos
    local x = math.floor(pos.x / self.cellSize) + 1
    local y = math.floor(pos.y / self.cellSize) + 1
    if x < 1 or x > self.cols or y < 1 or y > self.rows then
        return
    end
    local cell = self.cells[x][y]
    local n = cell.n
    if n == 0 then
        self.activeCount = self.activeCount + 1
        self.activeCells[self.activeCount] = cell
    end
    n = n + 1
    cell.n = n
    cell[n] = atom
end

function Grid:repel(atom, dt)
    local pos = atom.pos
    local vel = atom.vel
    local range = InteractionRange
    local range2 = range * range
    local force = RepulsionStrength * dt
    local cellSize = self.cellSize
    local minX = math.max(1, math.floor((pos.x - range) / cellSize) + 1)
    local maxX = math.min(self.cols, math.floor((pos.x + range) / cellSize) + 1)
    local minY = math.max(1, math.floor((pos.y - range) / cellSize) + 1)
    local maxY = math.min(self.rows, math.floor((pos.y + range) / cellSize) + 1)
    
    for x = minX,maxX do
        local column = self.cells[x]
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
                    if distance2 > 0 and distance2 < range2 then
                        local distance = math.sqrt(distance2)
                        local strength = force * (1 - distance / range)
                        local inverseDistance = 1 / distance
                        local fx = dx * inverseDistance * strength
                        local fy = dy * inverseDistance * strength
                        vel.x = vel.x + fx
                        vel.y = vel.y + fy
                        other.vel.x = other.vel.x - fx
                        other.vel.y = other.vel.y - fy
                    end
                end
            end
        end
    end
end

function Grid:drawGrid(strokeColor)
    stroke(strokeColor or 255)
    strokeWidth(2)
    noFill()
    local cellSize = self.cellSize
    local width = self.world.width
    local height = self.world.height
    for x = 0,self.cols do
        local px = x * cellSize
        line(px, 0, px, height)
    end
    for y = 0,self.rows do
        local py = y * cellSize
        line(0, py, width, py)
    end
end

function Grid:drawHeatmap()
    noStroke()
    local cells = self.cells
    local maxCount = 0
    for x = 1,self.cols do
        local column = cells[x]
        for y = 1,self.rows do
            local count = column[y].n
            if count > maxCount then
                maxCount = count
            end
        end
    end
    if maxCount == 0 then
        return
    end
    local cellSize = self.cellSize
    for x = 1,self.cols do
        local column = cells[x]
        for y = 1,self.rows do
            local count = column[y].n
            if count > 0 then
                fill(255, 255, 255, count / maxCount * 180)
                rect((x - 1) * cellSize, (y - 1) * cellSize, cellSize, cellSize)
            end
        end
    end
end