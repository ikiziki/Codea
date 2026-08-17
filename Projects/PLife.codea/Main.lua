-- particle life playground
-- chris geese @ 2026

function setup()
    te = ThemeEngine()
    qt = Quadtree(0, 0, WIDTH, HEIGHT, 10, 0, 4)
    setupRules()
    particles = {}
    lastQuery = {}
    fps = 0
    frameCount = 0
    fpsTime = ElapsedTime
    -- Create particles
    for i = 1, 250 do
        local particle = Particle()
        particles[#particles + 1] = particle
        qt:insert(particle)
    end
end

function update(dt)
    updateTheme()
    -- Update FPS
    frameCount = frameCount + 1
    if ElapsedTime - fpsTime >= 1 then
        fps = frameCount
        frameCount = 0
        fpsTime = ElapsedTime
        print("FPS: " .. fps)
    end
    -- Update particles
    for _, particle in ipairs(particles) do
        particle:update(dt, qt)
    end
    -- Rebuild QuadTree
    qt:clear()
    for _, particle in ipairs(particles) do
        qt:insert(particle)
    end
end

function draw()
    -- Draw particles
    for _, particle in ipairs(particles) do
        if drawMode == 1 then
            particle:drawEllipse()
        elseif drawMode == 2 then
            particle:drawHeading()
        elseif drawMode == 3 then
            particle:drawNoFill()
        elseif drawMode == 4 then
            particle:drawAllSolid()
        end
    end
    -- Draw quadtree boundaries for debugging
    -- qt:draw()
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
        -- Query QuadTree
        local finder = circFinder(touch.x, touch.y, 100)
        lastQuery = qt:query(finder)
        -- Highlight query results
        for _, particle in ipairs(lastQuery) do
            particle.selected = true
        end
        print("Found: " .. #lastQuery)
    end
    if touch.state == ENDED then
        touchX = nil
        touchY = nil
    end
end