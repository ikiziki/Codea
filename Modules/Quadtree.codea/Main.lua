-- Quadtree
-- Used for performance scaling by dividing the world into
-- smaller regions and only searching relevant regions.
--
-- chris geese @ 2026


-- ============================================================
-- Circular Search Range
-- ============================================================

CircFinder = class("CircFinder")

function CircFinder:init(x, y, radius)
    self.type = "circle"
    self.x = x or 0
    self.y = y or 0
    self.radius = radius or 0
end


-- ============================================================
-- Rectangular Search Range
-- ============================================================

RectFinder = class("RectFinder")

function RectFinder:init(x, y, width, height)
    self.type = "rectangle"
    self.x = x or 0
    self.y = y or 0
    self.width = width or 0
    self.height = height or 0
end


-- ============================================================
-- Quadtree
-- ============================================================

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
    
    -- Each node can have four children.
    self.children = {
        NE = nil,
        NW = nil,
        SE = nil,
        SW = nil
    }
end


-- ============================================================
-- Insert
-- ============================================================

-- Attempts to insert an object into this node.
function Quadtree:insert(object)
    
    -- The object must fit completely inside this node.
    if not self:contains(object) then
        return false
    end
    
    -- Store the object here if there is still room.
    if #self.objects < self.capacity and not self.subdivided then
        table.insert(self.objects, object)
        return true
    end
    
    -- Stop subdividing once the maximum depth is reached.
    if self.depth >= self.maxDepth then
        table.insert(self.objects, object)
        return true
    end
    
    -- Create child nodes when necessary.
    if not self.subdivided then
        self:subdivide()
    end
    
    -- Try to insert the object into one of the children.
    for _, child in pairs(self.children) do
        if child and child:insert(object) then
            return true
        end
    end
    
    -- The object did not fit into any child.
    return false
end


-- ============================================================
-- Intersects
-- ============================================================

-- Checks whether this node intersects a search range.
function Quadtree:intersects(range)
    
    -- Rectangle / rectangle intersection.
    if range.type == "rectangle" then
        return not (
        range.x > self.x + self.width or
        range.x + range.width < self.x or
        range.y > self.y + self.height or
        range.y + range.height < self.y
        )
    end
    
    -- Circle / rectangle intersection.
    if range.type == "circle" then
        
        -- Find the closest point on the rectangle
        -- to the center of the circle.
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


-- ============================================================
-- Query
-- ============================================================

-- Finds objects within a search range.
function Quadtree:query(range, found)
    
    found = found or {}
    
    -- If this node does not intersect the search range,
    -- there is nothing to search here.
    if not self:intersects(range) then
        return found
    end
    
    -- Search for objects inside a rectangular range.
    if range.type == "rectangle" then
        
        for _, object in ipairs(self.objects) do
            if object.x >= range.x
            and object.x < range.x + range.width
            and object.y >= range.y
            and object.y < range.y + range.height then
                
                table.insert(found, object)
            end
        end
        
        -- Search for objects inside a circular range.
    elseif range.type == "circle" then
        
        for _, object in ipairs(self.objects) do
            
            local dx = object.x - range.x
            local dy = object.y - range.y
            
            if dx * dx + dy * dy <= range.radius * range.radius then
                table.insert(found, object)
            end
        end
    end
    
    -- Recursively search child nodes.
    if self.subdivided then
        for _, child in pairs(self.children) do
            if child then
                child:query(range, found)
            end
        end
    end
    
    return found
end


-- ============================================================
-- Contains
-- ============================================================

-- Checks whether an object is completely contained
-- within this node.
function Quadtree:contains(object)
    
    -- Check for a circular object.
    if object.radius then
        return object.x - object.radius >= self.x
        and object.x + object.radius <= self.x + self.width
        and object.y - object.radius >= self.y
        and object.y + object.radius <= self.y + self.height
    end
    
    -- Check for a rectangular object.
    if object.width and object.height then
        return object.x >= self.x
        and object.x + object.width <= self.x + self.width
        and object.y >= self.y
        and object.y + object.height <= self.y + self.height
    end
    
    -- Unknown object type.
    return false
end


-- ============================================================
-- Subdivide
-- ============================================================

-- Splits this node into four smaller nodes.
function Quadtree:subdivide()
    
    -- Don't subdivide more than once.
    if self.subdivided then
        return
    end
    
    -- Stop when the maximum tree depth is reached.
    if self.depth >= self.maxDepth then
        return
    end
    
    local halfwidth = self.width / 2
    local halfheight = self.height / 2
    
    -- Create the northwest child.
    self.children.NW = Quadtree(
    self.x,
    self.y,
    halfwidth,
    halfheight,
    self.capacity,
    self.depth + 1,
    self.maxDepth
    )
    
    -- Create the northeast child.
    self.children.NE = Quadtree(
    self.x + halfwidth,
    self.y,
    halfwidth,
    halfheight,
    self.capacity,
    self.depth + 1,
    self.maxDepth
    )
    
    -- Create the southwest child.
    self.children.SW = Quadtree(
    self.x,
    self.y + halfheight,
    halfwidth,
    halfheight,
    self.capacity,
    self.depth + 1,
    self.maxDepth
    )
    
    -- Create the southeast child.
    self.children.SE = Quadtree(
    self.x + halfwidth,
    self.y + halfheight,
    halfwidth,
    halfheight,
    self.capacity,
    self.depth + 1,
    self.maxDepth
    )
    
    -- Give each child a reference to its parent.
    self.children.NW.parent = self
    self.children.NE.parent = self
    self.children.SW.parent = self
    self.children.SE.parent = self
    
    self.subdivided = true
    
    -- Existing objects need to be redistributed
    -- among the new children.
    local remaining = {}
    
    for _, object in ipairs(self.objects) do
        
        local inserted = false
        
        -- Try each child until one accepts the object.
        for _, child in pairs(self.children) do
            
            if child:insert(object) then
                inserted = true
                break
            end
        end
        
        -- Objects that don't fit completely inside a child
        -- remain stored in the current node.
        if not inserted then
            table.insert(remaining, object)
        end
    end
    
    self.objects = remaining
end


-- ============================================================
-- For Each
-- ============================================================

-- Accesses every object stored in the tree.
--
-- The supplied callback is called once for each object.
function Quadtree:forEach(callback)
    
    -- Process objects stored in this node.
    for _, object in ipairs(self.objects) do
        callback(object)
    end
    
    -- Recursively process child nodes.
    if self.subdivided then
        for _, child in pairs(self.children) do
            if child then
                child:forEach(callback)
            end
        end
    end
end


-- ============================================================
-- Clear
-- ============================================================

-- Removes all objects and child nodes from this node.
function Quadtree:clear()
    
    self.objects = {}
    
    self.children.NE = nil
    self.children.NW = nil
    self.children.SE = nil
    self.children.SW = nil
    
    self.subdivided = false
end


-- ============================================================
-- Draw
-- ============================================================

-- Draws this node and recursively draws all children.
function Quadtree:draw()
    
    style.push()
    
    noFill()
    strokeWidth(1)
    stroke(128)
    
    -- Draw this node's boundary.
    rect(
    self.x,
    self.y,
    self.width,
    self.height
    )
    
    -- Recursively draw child nodes.
    if self.subdivided then
        for _, child in pairs(self.children) do
            if child then
                child:draw()
            end
        end
    end
    
    style.pop()
end


-- ============================================================
-- Quadtree Tutorial
-- ============================================================
--
-- A Quadtree divides a rectangular area into four smaller
-- areas whenever a node contains too many objects.
--
-- This allows nearby objects to be searched without checking
-- every object in the entire world.
--
--
-- 1. CREATE A QUADTREE
--
-- Create the root node using:
--
--     qt = Quadtree(
--         0,
--         0,
--         WIDTH,
--         HEIGHT,
--         10,
--         0,
--         4
--     )
--
-- Arguments:
--
--     x          Starting X position
--     y          Starting Y position
--     width      Width of the node
--     height     Height of the node
--     capacity   Maximum objects before subdivision
--     depth      Current depth
--     maxDepth   Maximum tree depth
--
--
-- 2. INSERT OBJECTS
--
-- Any object with an x and y position can potentially be
-- inserted.
--
-- Circular objects should have:
--
--     object.x
--     object.y
--     object.radius
--
-- Example:
--
--     qt:insert(particle)
--
-- The object must fit completely inside a node.
--
--
-- 3. CIRCULAR SEARCH
--
-- Create a circular search range:
--
--     local range = CircFinder(
--         x,
--         y,
--         radius
--     )
--
-- Then query the tree:
--
--     local objects = qt:query(range)
--
-- The returned table contains objects found inside the circle.
--
-- This is useful for particle interactions:
--
--     local range = CircFinder(
--         particle.x,
--         particle.y,
--         50
--     )
--
--     local nearby = qt:query(range)
--
--
-- 4. RECTANGULAR SEARCH
--
-- Create a rectangular search range:
--
--     local range = RectFinder(
--         x,
--         y,
--         width,
--         height
--     )
--
-- Then query the tree:
--
--     local objects = qt:query(range)
--
--
-- 5. PROCESS SEARCH RESULTS
--
-- query() returns a table of objects.
--
-- Example:
--
--     local nearby = qt:query(range)
--
--     for _, object in ipairs(nearby) do
--         -- Process object.
--     end
--
--
-- 6. ITERATE THROUGH THE ENTIRE TREE
--
-- forEach() visits every object in the tree.
--
-- Example:
--
--     qt:forEach(function(object)
--         object:draw()
--     end)
--
-- This is useful when you need to process every object
-- regardless of its location.
--
--
-- 7. DRAW THE TREE
--
-- The tree can be visualized with:
--
--     qt:draw()
--
-- This recursively draws the boundaries of every node.
--
-- It is useful for debugging the tree and seeing how the
-- world is being divided.
--
--
-- 8. CLEAR THE TREE
--
-- clear() removes every object and child node:
--
--     qt:clear()
--
-- The root node remains available and can be reused.
--
-- This is useful when rebuilding the tree every frame:
--
--     qt:clear()
--
--     for _, object in ipairs(objects) do
--         qt:insert(object)
--     end
--
--
-- 9. TYPICAL PARTICLE SIMULATION
--
-- A common pattern is:
--
--     qt:clear()
--
--     for _, particle in ipairs(particles) do
--         qt:insert(particle)
--     end
--
--     for _, particle in ipairs(particles) do
--
--         local range = CircFinder(
--             particle.x,
--             particle.y,
--             50
--         )
--
--         local nearby = qt:query(range)
--
--         for _, other in ipairs(nearby) do
--             -- Calculate interaction here.
--         end
--     end
--
--
-- 10. HOW THE TREE WORKS
--
-- Before subdivision:
--
--     +-----------------------+
--     |                       |
--     |       Objects         |
--     |                       |
--     +-----------------------+
--
-- After subdivision:
--
--     +-----------+-----------+
--     |           |           |
--     |    NW     |    NE     |
--     |           |           |
--     +-----------+-----------+
--     |           |           |
--     |    SW     |    SE     |
--     |           |           |
--     +-----------+-----------+
--
-- Each child can subdivide again, creating another four
-- children.
--
--
-- 11. OBJECTS THAT CROSS BOUNDARIES
--
-- An object is only moved into a child if it fits completely
-- inside that child.
--
-- If it crosses a child boundary, it remains in the parent.
--
-- This prevents the same object from being stored in multiple
-- nodes.
--
--
-- ============================================================