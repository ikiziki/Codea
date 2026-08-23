-- test camera system

function setup()
    -- World is twice the size of the screen
    worldWidth = WIDTH * 2
    worldHeight = HEIGHT * 2
    -- Camera starts at the center of the world
    cameraX = WIDTH
    cameraY = HEIGHT
    -- Zoom settings
    zoom = 1
    zoomSpeed = 0.002
    minZoom = 0.5
    maxZoom = 2
    -- Position of the last single touch
    lastTouchX = 0
    lastTouchY = 0
    -- Store all currently active touches by ID
    touches = {}
    -- Previous distance between two touches
    lastPinchDistance = nil
end

function draw()
    background(0)
    pushMatrix()
    -- Move origin to screen center
    translate(WIDTH / 2, HEIGHT / 2)
    -- Scale the world around the screen center
    scale(zoom)
    -- Move the world opposite to the camera
    translate(-cameraX, -cameraY)
    -- Bottom-left
    strokeWidth(10)
    stroke(0)
    fill(255, 0, 0)
    rect(0, 0, WIDTH, HEIGHT)
    -- Bottom-right
    fill(0, 255, 0)
    rect(WIDTH, 0, WIDTH, HEIGHT)
    -- Top-left
    fill(0, 0, 255)
    rect(0, HEIGHT, WIDTH, HEIGHT)
    -- Top-right
    fill(255, 255, 0)
    rect(WIDTH, HEIGHT, WIDTH, HEIGHT)
    popMatrix()
end

function touched(touch)
    -- Add a new touch
    if touch.state == BEGAN then
        touches[touch.id] = {
            x = touch.x,
            y = touch.y
        }
        -- Update an existing touch
    elseif touch.state == MOVING then
        if touches[touch.id] then
            touches[touch.id].x = touch.x
            touches[touch.id].y = touch.y
        end
        -- Remove a touch when it ends
    elseif touch.state == ENDED or touch.state == CANCELLED then
        touches[touch.id] = nil
    end
    -- Create an array containing active touches
    local active = {}
    for id, t in pairs(touches) do
        table.insert(active, t)
    end
    -- ONE FINGER = PAN
    if #active == 1 then
        local t = active[1]
        -- Reset pan position when coming out of a pinch
        if lastPinchDistance then
            lastTouchX = t.x
            lastTouchY = t.y
            lastPinchDistance = nil
        end
        -- Start tracking the finger
        if touch.state == BEGAN then
            lastTouchX = t.x
            lastTouchY = t.y
            -- Move camera with the finger
        elseif touch.state == MOVING then
            local dx = t.x - lastTouchX
            local dy = t.y - lastTouchY
            -- Convert screen movement to world movement
            cameraX = cameraX - dx / zoom
            cameraY = cameraY - dy / zoom
            -- Prevent camera from leaving world
            clampCamera()
            lastTouchX = t.x
            lastTouchY = t.y
        end
        -- TWO FINGERS = ZOOM
    elseif #active == 2 then
        local t1 = active[1]
        local t2 = active[2]
        -- Distance between the two fingers
        local dx = t2.x - t1.x
        local dy = t2.y - t1.y
        local distance = math.sqrt(dx * dx + dy * dy)
        -- Establish starting pinch distance
        if not lastPinchDistance then
            lastPinchDistance = distance
        else
            -- Difference between current and previous distance
            local change = distance - lastPinchDistance
            -- Change zoom based on finger movement
            zoom = zoom + change * zoomSpeed
            -- Keep zoom within limits
            zoom = math.max(minZoom, math.min(zoom, maxZoom))
            lastPinchDistance = distance
            -- Recalculate camera boundaries after zooming
            clampCamera()
        end
    end
end

function clampCamera()
    -- Amount of world visible on each side of camera
    local halfWidth = WIDTH / (2 * zoom)
    local halfHeight = HEIGHT / (2 * zoom)
    -- Horizontal camera limits
    cameraX = math.max(
    halfWidth,
    math.min(cameraX, worldWidth - halfWidth)
    )
    -- Vertical camera limits
    cameraY = math.max(
    halfHeight,
    math.min(cameraY, worldHeight - halfHeight)
    )
end