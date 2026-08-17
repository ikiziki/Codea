-- quadtree for performance scaling
-- chris geese @ 2026

lastQuery = {}
touchX = nil
touchY = nil

function setup()
    te = ThemeEngine()
    qt = Quadtree(0, 0, WIDTH, HEIGHT, 10, 0, 4)
    setupRules()
    
    for i = 1, 250 do
        local particle = Particle()
        particle.x = rX()
        particle.y = rY()
        qt:insert(particle)
    end
end

function update(dt)
    updateTheme()
end

function draw()
    -- Draw all particles
    qt:forEach(function(particle)
        particle:drawEllipse()
    end)
    
    -- Draw quadtree boundaries for debugging
    qt:draw()
    
    -- Draw touch search range
    if touchX and touchY then
        pushStyle()
        noFill()
        stroke(255, 255, 255, 100)
        strokeWidth(2)
        ellipse(touchX, touchY, 200)
        popStyle()
    end
end

function touched(touch)
    if touch.state == BEGAN or touch.state == MOVING then
        touchX = touch.x
        touchY = touch.y
        -- Clear previous highlights
        for _, particle in ipairs(lastQuery) do
            particle.selected = false
        end
        -- Query the quadtree
        local finder = circFinder(touch.x, touch.y, 100)
        lastQuery = qt:query(finder)
        -- Highlight query results
        for _, particle in ipairs(lastQuery) do
            particle.selected = true
        end
        print("Found: " .. #lastQuery)
    end
end