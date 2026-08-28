-- Camera for NEiL
-- chris geese @ 2026

Camera = class("Camera")
function Camera:init()
    self.worldWidth = WIDTH * 3
    self.worldHeight = HEIGHT * 4
    self.x = WIDTH * 1.5
    self.y = HEIGHT * 0.5
    self.zoom = 1
    self.zoomSpeed = 0.002
    self.minZoom = 0.5
    self.maxZoom = 2
    self.lastTouchX = 0
    self.lastTouchY = 0
    self.lastPinchDistance = nil
    self.zoomIndicatorSize = 70
    self.zoomIndicatorMargin = 25
    self.cameraMargin = 0.1
end

function Camera:screenToWorld(pos)
    return vec2(
    self.x + (pos.x - WIDTH / 2) / self.zoom,
    self.y + (pos.y - HEIGHT / 2) / self.zoom
    )
end

function Camera:worldToScreen(pos)
    return vec2(
    WIDTH / 2 + (pos.x - self.x) * self.zoom,
    HEIGHT / 2 + (pos.y - self.y) * self.zoom
    )
end

function Camera:beginPan(touch)
    self.lastTouchX = touch.x
    self.lastTouchY = touch.y
end

function Camera:updatePan(touch)
    local dx = touch.x - self.lastTouchX
    local dy = touch.y - self.lastTouchY
    self.x = self.x - dx / self.zoom
    self.y = self.y - dy / self.zoom
    self:clamp()
    self.lastTouchX = touch.x
    self.lastTouchY = touch.y
end

function Camera:beginPinch(distance)
    self.lastPinchDistance = distance
end

function Camera:updatePinch(distance)
    if not self.lastPinchDistance then
        self.lastPinchDistance = distance
        return
    end
    local change = distance - self.lastPinchDistance
    self.zoom = self.zoom + change * self.zoomSpeed
    self.zoom = math.max(self.minZoom, math.min(self.zoom, self.maxZoom))
    self.lastPinchDistance = distance
    self:clamp()
end

function Camera:endPinch()
    self.lastPinchDistance = nil
end

function Camera:reset()
    self.x = WIDTH * 1.5
    self.y = HEIGHT * 0.5
    self.zoom = 1
    self.lastTouchX = 0
    self.lastTouchY = 0
    self.lastPinchDistance = nil
end

function Camera:clamp()
    local halfWidth = WIDTH / (2 * self.zoom)
    local halfHeight = HEIGHT / (2 * self.zoom)
    local marginX = WIDTH * 0.1 / self.zoom
    local marginY = HEIGHT * 0.1 / self.zoom
    self.x = math.max(
    halfWidth - marginX,
    math.min(self.x, self.worldWidth - halfWidth + marginX)
    )
    self.y = math.max(
    halfHeight - marginY,
    math.min(self.y, self.worldHeight - halfHeight + marginY)
    )
end

function Camera:drawWorld()
    pushMatrix()
    translate(WIDTH / 2, HEIGHT / 2)
    scale(self.zoom)
    translate(-self.x, -self.y)
    noFill()
    stroke(theme.fg.r, theme.fg.g, theme.fg.b, 128)
    strokeWidth(8 / self.zoom)
    local dashLength = 40
    local gapLength = 25
    local x = 0
    while x < self.worldWidth do
        line(x, 0, math.min(x + dashLength, self.worldWidth), 0)
        line(x, self.worldHeight, math.min(x + dashLength, self.worldWidth), self.worldHeight)
        x = x + dashLength + gapLength
    end
    local y = 0
    while y < self.worldHeight do
        line(0, y, 0, math.min(y + dashLength, self.worldHeight))
        line(self.worldWidth, y, self.worldWidth, math.min(y + dashLength, self.worldHeight))
        y = y + dashLength + gapLength
    end
    popMatrix()
end

function Camera:drawNeil(neil)
    if not neil.active then return end
    pushMatrix()
    translate(WIDTH / 2, HEIGHT / 2)
    scale(self.zoom)
    translate(-self.x, -self.y)
    neil:draw()
    popMatrix()
end

function Camera:drawNeilIndicator(neil)
    if not neil.active then return end
    
    local pos = self:worldToScreen(neil.pos)
    
    if pos.x >= 0 and
    pos.x <= WIDTH and
    pos.y >= 0 and
    pos.y <= HEIGHT then
        return
    end
    
    local center = vec2(WIDTH / 2, HEIGHT / 2)
    local direction = pos - center
    
    if direction.lengthSqr == 0 then return end
    
    local length = math.sqrt(direction.lengthSqr)
    direction = direction / length
    
    local margin = 35
    local halfWidth = WIDTH / 2 - margin
    local halfHeight = HEIGHT / 2 - margin
    
    local scaleX = math.huge
    local scaleY = math.huge
    
    if math.abs(direction.x) > 0 then
        scaleX = halfWidth / math.abs(direction.x)
    end
    
    if math.abs(direction.y) > 0 then
        scaleY = halfHeight / math.abs(direction.y)
    end
    
    local distance = math.min(scaleX, scaleY)
    local arrowPos = center + direction * distance
    
    local arrowLength = 24
    local arrowWidth = 14
    local perpendicular = vec2(-direction.y, direction.x)
    
    local tip = arrowPos + direction * arrowLength / 2
    local left = arrowPos - direction * arrowLength / 2 + perpendicular * arrowWidth / 2
    local right = arrowPos - direction * arrowLength / 2 - perpendicular * arrowWidth / 2
    
    resetMatrix()
    
    stroke(theme.fg.r, theme.fg.g, theme.fg.b, 220)
    strokeWidth(3)
    
    line(tip.x, tip.y, left.x, left.y)
    line(left.x, left.y, right.x, right.y)
    line(right.x, right.y, tip.x, tip.y)
end

function Camera:drawZoomIndicator()
    if self.zoom == 1 then return end
    
    resetMatrix()
    
    local x = WIDTH - self.zoomIndicatorMargin
    local centerY = HEIGHT - self.zoomIndicatorMargin - self.zoomIndicatorSize / 2
    local halfSize = self.zoomIndicatorSize / 2
    
    local minY = centerY - halfSize
    local maxY = centerY + halfSize
    
    local range = self.maxZoom - self.minZoom
    local normalized = (self.zoom - self.minZoom) / range
    local indicatorY = maxY - normalized * self.zoomIndicatorSize
    
    stroke(theme.fg.r, theme.fg.g, theme.fg.b, 100)
    strokeWidth(2)
    
    line(x, minY, x, maxY)
    line(x - 8, minY, x + 8, minY)
    line(x - 8, maxY, x + 8, maxY)
    
    fill(theme.fg)
    noStroke()
    ellipse(x, indicatorY, 12, 12)
    
    fill(theme.fg)
    fontSize(14)
    textAlign(CENTER)
    text(string.format("%.1fx", self.zoom), x - 25, indicatorY + 6)
end