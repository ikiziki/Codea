-- Spatial Grid
-- chris geese @ 2026

SpatialGrid = class("SpatialGrid")

function SpatialGrid:init(cellSize)
    self.cellSize = cellSize or 100
    self.cols = math.ceil(WIDTH / self.cellSize)
    self.rows = math.ceil(HEIGHT / self.cellSize)
    self.cells = {}
    
    for i = 1,self.cols * self.rows do
        self.cells[i] = {}
    end
end

function SpatialGrid:index(x,y)
    local col = math.floor(x / self.cellSize) + 1
    local row = math.floor(y / self.cellSize) + 1
    
    if col < 1 then col = 1 elseif col > self.cols then col = self.cols end
    if row < 1 then row = 1 elseif row > self.rows then row = self.rows end
    
    return (row - 1) * self.cols + col
end

function SpatialGrid:clear()
    for i = 1,#self.cells do
        local cell = self.cells[i]
        for j = #cell,1,-1 do
            cell[j] = nil
        end
    end
end

function SpatialGrid:insert(atom)
    local index = self:index(atom.pos.x,atom.pos.y)
    local cell = self.cells[index]
    cell[#cell + 1] = atom
end

function SpatialGrid:cellRange(x,y,radius)
    local minCol = math.floor((x - radius) / self.cellSize) + 1
    local maxCol = math.floor((x + radius) / self.cellSize) + 1
    local minRow = math.floor((y - radius) / self.cellSize) + 1
    local maxRow = math.floor((y + radius) / self.cellSize) + 1
    
    if minCol < 1 then minCol = 1 elseif minCol > self.cols then minCol = self.cols end
    if maxCol < 1 then maxCol = 1 elseif maxCol > self.cols then maxCol = self.cols end
    if minRow < 1 then minRow = 1 elseif minRow > self.rows then minRow = self.rows end
    if maxRow < 1 then maxRow = 1 elseif maxRow > self.rows then maxRow = self.rows end
    
    return minCol,maxCol,minRow,maxRow
end

function SpatialGrid:query(x,y,radius,results)
    local minCol,maxCol,minRow,maxRow = self:cellRange(x,y,radius)
    local radiusSq = radius * radius
    local count = 0
    
    for row = minRow,maxRow do
        local base = (row - 1) * self.cols
        
        for col = minCol,maxCol do
            local cell = self.cells[base + col]
            
            for i = 1,#cell do
                local atom = cell[i]
                local dx = atom.pos.x - x
                local dy = atom.pos.y - y
                
                if dx * dx + dy * dy <= radiusSq then
                    count = count + 1
                    results[count] = atom
                end
            end
        end
    end
    
    for i = count + 1,#results do
        results[i] = nil
    end
    
    return count
end

function SpatialGrid:draw(strokeColor)
    style.push()
    noFill()
    stroke(strokeColor)
    strokeWidth(1)
    
    for x = 1,self.cols - 1 do
        local px = x * self.cellSize
        line(px,0,px,HEIGHT)
    end
    
    for y = 1,self.rows - 1 do
        local py = y * self.cellSize
        line(0,py,WIDTH,py)
    end
    
    style.pop()
end