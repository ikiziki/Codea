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
                fill(255, 0, 0, count / maxCount * 60)
                rect((x - 1) * cellSize, (y - 1) * cellSize, cellSize, cellSize)
            end
        end
    end
end