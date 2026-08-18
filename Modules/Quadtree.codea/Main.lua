-- Quadtree
-- chris geese @ 2026

-- circular search area
CircFinder = class("CircFinder") 
function CircFinder:init(x, y, radius)
    self.type = "circle"
    self.x = x or 0
    self.y = y or 0
    self.radius = radius or 0
end

-- rectangular search arwa
RectFinder = class("RectFinder")
function RectFinder:init(x, y, width, height)
    self.type = "rectangle"
    self.x = x or 0
    self.y = y or 0
    self.width = width or 0
    self.height = height or 0
end

-- primary class
Quadtree = class("Quadtree")
function Quadtree:init(x, y, width, height, capacity, depth, maxDepth)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 0
    self.height = height or 0 
    self.capacity = capacity or 10
    self.depth = depth or 0
    self.maxDepth = maxDepth or 4  
    self.subdivided = false
    self.parent = nil
    self.objects = {}
    self.children = {
        NE = nil,
        NW = nil,
        SE = nil,
        SW = nil
    }
end

-- Attempts to insert an object into this node.
function Quadtree:insert(object) 
    if not self:contains(object) then
        return false
    end
    if #self.objects < self.capacity and not self.subdivided then
        table.insert(self.objects, object)
        return true
    end
    if self.depth >= self.maxDepth then
        table.insert(self.objects, object)
        return true
    end
    if not self.subdivided then
        self:subdivide()
    end
    for _, child in pairs(self.children) do
        if child and child:insert(object) then
            return true
        end
    end
    return false
end


-- Checks whether this node intersects a search range.
function Quadtree:intersects(range)
    if range.type == "rectangle" then
        return not (
        range.x > self.x + self.width or
        range.x + range.width < self.x or
        range.y > self.y + self.height or
        range.y + range.height < self.y
        )
    end
    if range.type == "circle" then
        local closestX = math.max(
        self.x,
        math.min(range.x, self.x + self.width)
        ) 
        local closestY = math.max(
        self.y,
        math.min(range.y, self.y + self.height)
        ) 
        local dx = range.x - closestX
        local dy = range.y - closestY 
        return dx * dx + dy * dy <= range.radius * range.radius
    end
    return false
end

-- Finds objects within a search range.
function Quadtree:query(range, found)  
    found = found or {}
    if not self:intersects(range) then
        return found
    end
    if range.type == "rectangle" then
        for _, object in ipairs(self.objects) do
            if object.x >= range.x
            and object.x < range.x + range.width
            and object.y >= range.y
            and object.y < range.y + range.height then      
                table.insert(found, object)
            end
        end
    elseif range.type == "circle" then 
        for _, object in ipairs(self.objects) do 
            local dx = object.x - range.x
            local dy = object.y - range.y
            if dx * dx + dy * dy <= range.radius * range.radius then
                table.insert(found, object)
            end
        end
    end
    if self.subdivided then
        for _, child in pairs(self.children) do
            if child then
                child:query(range, found)
            end
        end
    end
    return found
end

-- Checks whether an object is completely contained within this node.
function Quadtree:contains(object)
    if object.radius then
        return object.x - object.radius >= self.x
        and object.x + object.radius <= self.x + self.width
        and object.y - object.radius >= self.y
        and object.y + object.radius <= self.y + self.height
    end
    if object.width and object.height then
        return object.x >= self.x
        and object.x + object.width <= self.x + self.width
        and object.y >= self.y
        and object.y + object.height <= self.y + self.height
    end
    return false
end

-- Splits this node into four smaller nodes.
function Quadtree:subdivide()
    if self.subdivided then
        return
    end
    if self.depth >= self.maxDepth then
        return
    end
    local halfwidth = self.width / 2
    local halfheight = self.height / 2
    
    self.children.NW = Quadtree(
    self.x,
    self.y,
    halfwidth,
    halfheight,
    self.capacity,
    self.depth + 1,
    self.maxDepth
    )
    
    self.children.NE = Quadtree(
    self.x + halfwidth,
    self.y,
    halfwidth,
    halfheight,
    self.capacity,
    self.depth + 1,
    self.maxDepth
    )
    
    self.children.SW = Quadtree(
    self.x,
    self.y + halfheight,
    halfwidth,
    halfheight,
    self.capacity,
    self.depth + 1,
    self.maxDepth
    )
    
    self.children.SE = Quadtree(
    self.x + halfwidth,
    self.y + halfheight,
    halfwidth,
    halfheight,
    self.capacity,
    self.depth + 1,
    self.maxDepth
    )
    
    self.children.NW.parent = self
    self.children.NE.parent = self
    self.children.SW.parent = self
    self.children.SE.parent = self
    
    self.subdivided = true
    local remaining = {}
    for _, object in ipairs(self.objects) do
        local inserted = false
        for _, child in pairs(self.children) do 
            if child:insert(object) then
                inserted = true
                break
            end
        end
        if not inserted then
            table.insert(remaining, object)
        end
    end
    self.objects = remaining
end

-- The supplied callback is called once for each object.
function Quadtree:forEach(callback)
    for _, object in ipairs(self.objects) do
        callback(object)
    end
    if self.subdivided then
        for _, child in pairs(self.children) do
            if child then
                child:forEach(callback)
            end
        end
    end
end

-- Removes all objects and child nodes from this node.
function Quadtree:clear() 
    self.objects = {}
    self.children.NE = nil
    self.children.NW = nil
    self.children.SE = nil
    self.children.SW = nil
    self.subdivided = false
end

-- Draws this node and recursively draws all children.
function Quadtree:draw()
    style.push()
    noFill()
    strokeWidth(1)
    stroke(128)
    rect(
    self.x,
    self.y,
    self.width,
    self.height
    )
    if self.subdivided then
        for _, child in pairs(self.children) do
            if child then
                child:draw()
            end
        end
    end
    style.pop()
end