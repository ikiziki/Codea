-- 2D Camera
-- chris geese @ 2026

Camera = class()

function Camera:init()
    -- Camera position and zoom
    self.x = 0
    self.y = 0
    self.zoom = 1
    
    -- Zoom limits
    self.minZoom = 0.25
    self.maxZoom = 3
    
    -- Active touches used for pan and pinch
    self.touches = {}
    self.pinchDistance = nil
    self.pinchCenterX = nil
    self.pinchCenterY = nil
end

function Camera:update()
    -- Build a list of active touches
    local list = {}
    for _,t in pairs(self.touches) do
        table.insert(list,t)
    end
    
    -- One finger: pan the camera
    if #list == 1 then
        local t = list[1]
        self.x = self.x + (t.x - t.lastX)
        self.y = self.y + (t.y - t.lastY)
        t.lastX = t.x
        t.lastY = t.y
        self:endPinch()
        
        -- Two fingers: pinch zoom around the finger midpoint
    elseif #list >= 2 then
        local a = list[1]
        local b = list[2]
        local dx = b.x - a.x
        local dy = b.y - a.y
        local distance = math.sqrt(dx * dx + dy * dy)
        local centerX = (a.x + b.x) * 0.5
        local centerY = (a.y + b.y) * 0.5
        
        if self.pinchDistance then
            local oldZoom = self.zoom
            local newZoom = oldZoom * distance / self.pinchDistance
            
            -- Keep zoom inside the allowed range
            newZoom = math.max(self.minZoom,math.min(self.maxZoom,newZoom))
            
            -- Find the world point under the previous pinch center
            local worldX = (self.pinchCenterX - self.x) / oldZoom
            local worldY = (self.pinchCenterY - self.y) / oldZoom
            
            -- Apply zoom while keeping that point under the fingers
            self.zoom = newZoom
            self.x = centerX - worldX * self.zoom
            self.y = centerY - worldY * self.zoom
        end
        
        -- Store this frame's pinch information
        self.pinchDistance = distance
        self.pinchCenterX = centerX
        self.pinchCenterY = centerY
        
        a.lastX = a.x
        a.lastY = a.y
        b.lastX = b.x
        b.lastY = b.y
    end
end

function Camera:touched(touch)
    -- Start tracking a new finger
    if touch.state == BEGAN then
        self.touches[touch.id] = {
            x = touch.x,
            y = touch.y,
            lastX = touch.x,
            lastY = touch.y
        }
        
        -- Two fingers means a pinch begins
        if self:getTouchCount() == 2 then
            self:beginPinch()
        end
        
        -- Update the tracked finger position
    elseif touch.state == MOVING then
        local t = self.touches[touch.id]
        if t then
            t.lastX = t.x
            t.lastY = t.y
            t.x = touch.x
            t.y = touch.y
        end
        
        -- Stop tracking the finger
    elseif touch.state == ENDED or touch.state == CANCELLED then
        self.touches[touch.id] = nil
        
        -- End pinch when fewer than two fingers remain
        if self:getTouchCount() < 2 then
            self:endPinch()
        end
    end
end

function Camera:beginPinch()
    local list = self:getTouches()
    if #list < 2 then return end
    
    local a = list[1]
    local b = list[2]
    local dx = b.x - a.x
    local dy = b.y - a.y
    
    -- Save the initial pinch distance and center
    self.pinchDistance = math.sqrt(dx * dx + dy * dy)
    self.pinchCenterX = (a.x + b.x) * 0.5
    self.pinchCenterY = (a.y + b.y) * 0.5
end

function Camera:endPinch()
    -- Clear pinch tracking
    self.pinchDistance = nil
    self.pinchCenterX = nil
    self.pinchCenterY = nil
end

function Camera:getTouches()
    -- Return active touches as an array
    local list = {}
    for _,t in pairs(self.touches) do
        table.insert(list,t)
    end
    return list
end

function Camera:getTouchCount()
    -- Return the number of active touches
    local count = 0
    for _ in pairs(self.touches) do
        count = count + 1
    end
    return count
end

function Camera:begin()
    -- Start drawing through the camera
    pushMatrix()
    translate(self.x,self.y)
    scale(self.zoom)
end

function Camera:finish()
    -- Restore normal screen coordinates
    popMatrix()
end

function Camera:setPosition(x,y)
    -- Set the camera position directly
    self.x = x
    self.y = y
end

function Camera:setZoom(zoom)
    -- Set zoom while respecting the limits
    self.zoom = math.max(self.minZoom,math.min(self.maxZoom,zoom))
end

function Camera:move(dx,dy)
    -- Move the camera by an offset
    self.x = self.x + dx
    self.y = self.y + dy
end

function Camera:zoomBy(amount)
    -- Change zoom relative to the current zoom
    self:setZoom(self.zoom * amount)
end

function Camera:reset(x,y,zoom)
    -- Reset position and zoom
    self.x = x or 0
    self.y = y or 0
    self.zoom = math.max(self.minZoom,math.min(self.maxZoom,zoom or 1))
    self:endPinch()
end

function Camera:screenToWorld(x,y)
    -- Convert screen coordinates into camera/world coordinates
    return vec2(
    (x - self.x) / self.zoom,
    (y - self.y) / self.zoom
    )
end

function Camera:worldToScreen(x,y)
    -- Convert camera/world coordinates into screen coordinates
    return vec2(
    x * self.zoom + self.x,
    y * self.zoom + self.y
    )
end