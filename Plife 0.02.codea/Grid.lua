Grid = class("Grid")

function Grid:init(world, cellSize)
    self.world = world
    self.cellSize = cellSize or 100
    
    self.cols = math.ceil(world.width / self.cellSize)
    self.rows = math.ceil(world.height / self.cellSize)
    
    self.cells = {}
    
    for y = 1, self.rows do
        self.cells[y] = {}
        
        for x = 1, self.cols do
            self.cells[y][x] = {}
        end
    end
end

function Grid:clear()
    for y = 1, self.rows do
        for x = 1, self.cols do
            self.cells[y][x] = {}
        end
    end
end

function Grid:insert(object)
    local col = math.floor(object.pos.x / self.cellSize) + 1
    local row = math.floor(object.pos.y / self.cellSize) + 1
    
    if col < 1 or col > self.cols then return end
    if row < 1 or row > self.rows then return end
    
    table.insert(self.cells[row][col], object)
end

function Grid:query(object)
    local col = math.floor(object.pos.x / self.cellSize) + 1
    local row = math.floor(object.pos.y / self.cellSize) + 1
    
    local nearby = {}
    
    for y = row - 1, row + 1 do
        for x = col - 1, col + 1 do
            
            if y >= 1 and y <= self.rows and
            x >= 1 and x <= self.cols then
                
                local cell = self.cells[y][x]
                
                for i = 1, #cell do
                    nearby[#nearby + 1] = cell[i]
                end
            end
        end
    end
    
    return nearby
end

function Grid:drawGrid(strokeColor)
    pushStyle()
    noFill()
    stroke(strokeColor.r, strokeColor.g, strokeColor.b, 80)
    strokeWidth(3)
    for x = 0, self.cols do
        local px = x * self.cellSize
        line(px, 0, px, self.world.height)
    end
    for y = 0, self.rows do
        local py = y * self.cellSize
        line(0, py, self.world.width, py)
    end
    popStyle()
end

function Grid:drawHeatmap()
    pushStyle()
    noStroke()
    for y = 1, self.rows do
        for x = 1, self.cols do
            local count = #self.cells[y][x]
            if count > 0 then
                local intensity = math.min(count / 10, 1)
                fill(255, 255 * intensity, 0, 100)
                rect((x - 1) * self.cellSize, (y - 1) * self.cellSize, self.cellSize, self.cellSize)
            end
        end
    end
    popStyle()
end