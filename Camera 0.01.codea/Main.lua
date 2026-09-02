-- 2D Camera
-- chris geese @ 2026

function setup()
    viewer.mode = FULLSCREEN
    
    -- Size of our game world
    worldWidth = WIDTH * 3
    worldHeight = HEIGHT * 3
    
    -- Camera position and zoom
    camX = 0
    camY = 0
    camZoom = 1
    
    -- Zoom limits
    minZoom = 0.25
    maxZoom = 3
    
    -- Stores information about each finger currently touching
    touches = {}
    
    -- Used to remember the previous pinch distance
    pinchDistance = nil
    
    -- Used to remember the previous pinch midpoint
    pinchCenterX = nil
    pinchCenterY = nil
end

function draw()
    background(235)
    
    -- Update the camera before drawing the world
    updateCamera()
    
    -- Everything between these two calls is affected
    -- by the camera position and zoom
    pushMatrix()
    translate(camX,camY)
    scale(camZoom)
    
    -- Draw our world
    drawGrid()
    
    -- Restore the normal screen coordinate system
    popMatrix()
end

function touched(touch)
    -- A new finger has touched the screen
    if touch.state == BEGAN then
        
        -- Create a record for this finger
        touches[touch.id] = {
            x = touch.x,
            y = touch.y,
            lastX = touch.x,
            lastY = touch.y
        }
        
        -- An existing finger has moved
    elseif touch.state == MOVING then
        
        local t = touches[touch.id]
        
        if t then
            -- Save the previous position
            t.lastX = t.x
            t.lastY = t.y
            
            -- Store the new position
            t.x = touch.x
            t.y = touch.y
        end
        
        -- A finger has left the screen
    elseif touch.state == ENDED or touch.state == CANCELLED then
        
        -- Remove that finger from our touch list
        touches[touch.id] = nil
        
        -- Reset pinch information
        pinchDistance = nil
        pinchCenterX = nil
        pinchCenterY = nil
    end
end

function updateCamera()
    -- Make a simple list of the fingers currently touching
    local list = {}
    
    for _,t in pairs(touches) do
        table.insert(list,t)
    end
    
    -- ==========================================
    -- ONE FINGER = PAN
    -- ==========================================
    
    if #list == 1 then
        
        local t = list[1]
        
        -- Move the camera by the amount the finger moved
        camX = camX + (t.x - t.lastX)
        camY = camY + (t.y - t.lastY)
        
        -- The current position becomes the previous
        -- position for the next frame
        t.lastX = t.x
        t.lastY = t.y
        
        -- We aren't pinching anymore
        pinchDistance = nil
        pinchCenterX = nil
        pinchCenterY = nil
        
        -- ==========================================
        -- TWO FINGERS = PINCH ZOOM
        -- ==========================================
        
    elseif #list >= 2 then
        
        -- Get our two fingers
        local a = list[1]
        local b = list[2]
        
        -- Find the horizontal and vertical distance
        -- between the two fingers
        local dx = b.x - a.x
        local dy = b.y - a.y
        
        -- Calculate the actual distance between them
        local distance = math.sqrt(dx * dx + dy * dy)
        
        -- Find the point exactly between the two fingers
        local centerX = (a.x + b.x) * 0.5
        local centerY = (a.y + b.y) * 0.5
        
        -- If we already have a previous pinch distance,
        -- we can calculate how much the fingers moved
        if pinchDistance then
            
            -- Remember the zoom before changing it
            local oldZoom = camZoom
            
            -- Increase or decrease zoom based on the
            -- change in distance between the fingers
            local newZoom = oldZoom * distance / pinchDistance
            
            -- Keep zoom within our limits
            newZoom = math.max(minZoom,math.min(maxZoom,newZoom))
            
            -- Find the world position underneath the
            -- previous pinch center
            local worldX = (pinchCenterX - camX) / oldZoom
            local worldY = (pinchCenterY - camY) / oldZoom
            
            -- Apply the new zoom
            camZoom = newZoom
            
            -- Move the camera so that the same world
            -- point stays underneath the fingers
            camX = centerX - worldX * camZoom
            camY = centerY - worldY * camZoom
        end
        
        -- Remember the current pinch information.
        -- It becomes the "previous" information
        -- during the next update.
        pinchDistance = distance
        pinchCenterX = centerX
        pinchCenterY = centerY
        
        -- Update the previous finger positions
        a.lastX = a.x
        a.lastY = a.y
        b.lastX = b.x
        b.lastY = b.y
    end
end

function drawGrid()
    stroke(35)
    strokeWidth(2)
    
    -- Divide the world into exactly 30 columns
    -- and 40 rows
    local stepX = worldWidth / 30
    local stepY = worldHeight / 40
    
    -- Draw vertical lines
    for x = 0,worldWidth,stepX do
        line(x,0,x,worldHeight)
    end
    
    -- Draw horizontal lines
    for y = 0,worldHeight,stepY do
        line(0,y,worldWidth,y)
    end
end