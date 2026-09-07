Grid = class("Grid")

function Grid:init(world, cellSize)
    self.world = world
    self.cellSize = cellSize or 100
    
    self.cols = math.ceil(world.width / self.cellSize)
    self.rows = math.ceil(world.height / self.cellSize)
    
    self.cells = {}
    
    for x = 1,self.cols do
        self.cells[x] = {}
        
        for y = 1,self.rows do
            self.cells[x][y] = {}
        end
    end
end

function Grid:clear()
    for x = 1,self.cols do
        for y = 1,self.rows do
            self.cells[x][y] = {}
        end
    end
end

function Grid:insert(atom)
    local x = math.floor(atom.pos.x / self.cellSize) + 1
    local y = math.floor(atom.pos.y / self.cellSize) + 1
    
    if x < 1 or x > self.cols or
    y < 1 or y > self.rows then
        return
    end
    
    local cell = self.cells[x][y]
    cell[#cell + 1] = atom
end

function Grid:query(pos, radius)
    local results = {}
    
    local minX = math.max(
    1,
    math.floor((pos.x - radius) / self.cellSize) + 1
    )
    
    local maxX = math.min(
    self.cols,
    math.floor((pos.x + radius) / self.cellSize) + 1
    )
    
    local minY = math.max(
    1,
    math.floor((pos.y - radius) / self.cellSize) + 1
    )
    
    local maxY = math.min(
    self.rows,
    math.floor((pos.y + radius) / self.cellSize) + 1
    )
    
    for x = minX,maxX do
        for y = minY,maxY do
            local cell = self.cells[x][y]
            
            for i = 1,#cell do
                results[#results + 1] = cell[i]
            end
        end
    end
    
    return results
end

function Grid:drawGrid(strokeColor)
    stroke(strokeColor or 255)
    strokeWidth(1)
    noFill()
    
    for x = 0,self.cols do
        local px = x * self.cellSize
        
        line(
        px, 0,
        px, self.world.height
        )
    end
    
    for y = 0,self.rows do
        local py = y * self.cellSize
        
        line(
        0, py,
        self.world.width, py
        )
    end
end

function Grid:drawHeatmap()
    noStroke()
    
    local maxCount = 0
    
    for x = 1,self.cols do
        for y = 1,self.rows do
            local count = #self.cells[x][y]
            
            if count > maxCount then
                maxCount = count
            end
        end
    end
    
    if maxCount == 0 then
        return
    end
    
    for x = 1,self.cols do
        for y = 1,self.rows do
            local count = #self.cells[x][y]
            
            if count > 0 then
                local intensity = count / maxCount
                
                fill(255, 255, 255, intensity * 180)
                
                rect(
                (x - 1) * self.cellSize,
                (y - 1) * self.cellSize,
                self.cellSize,
                self.cellSize
                )
            end
        end
    end
end