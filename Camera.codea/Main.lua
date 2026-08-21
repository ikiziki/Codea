-- test camera system

function setup()
    worldWidth = WIDTH * 2
    worldHeight = HEIGHT * 2
    cameraX = WIDTH
    cameraY = HEIGHT
    lastTouchX = 0
    lastTouchY = 0
end

function draw()
    background(0) 
    pushMatrix() 
    -- Camera
    translate(
    WIDTH / 2 - cameraX,
    HEIGHT / 2 - cameraY
    )
    -- Bottom-left
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
    if touch.state == BEGAN then
        lastTouchX = touch.x
        lastTouchY = touch.y 
    elseif touch.state == MOVING then
        local dx = touch.x - lastTouchX
        local dy = touch.y - lastTouchY
        cameraX = cameraX - dx
        cameraY = cameraY - dy
        -- Keep camera inside the world
        cameraX = math.max(WIDTH / 2,
        math.min(cameraX, worldWidth - WIDTH / 2))
        cameraY = math.max(HEIGHT / 2,
        math.min(cameraY, worldHeight - HEIGHT / 2))
        lastTouchX = touch.x
        lastTouchY = touch.y
    end
end