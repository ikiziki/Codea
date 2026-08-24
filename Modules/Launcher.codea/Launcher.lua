-- Launcher for NEiL
-- chris geese @ 2026

Launcher = class("Launcher")

function Launcher:init()
    self.active = false
    self.launched = false
    self.start = vec2(0, 0)
    self.current = vec2(0, 0)
    self.maxDistance = 200
    self.maxSpeed = 100
    self.circleRadius = 20
    self.velocity = vec2(0, 0)
end

function Launcher:touchBegan(touch)
    self.start = touch.pos
    self.current = touch.pos
    self.active = true
    self.launched = false
end

function Launcher:touchMoved(touch)
    if not self.active then return end
    self.current = touch.pos
end

function Launcher:touchEnded(touch)
    if not self.active then return end
    
    self.current = touch.pos
    self:launch()
end

function Launcher:launch()
    self.velocity = self:getVelocity()
    self.launched = true
    self.active = false
end

function Launcher:getVelocity()
    local vector = self.start - self.current
    local lengthSqr = vector.lengthSqr
    
    if lengthSqr == 0 then return vec2(0, 0) end
    
    local length = math.sqrt(lengthSqr)
    local distance = math.min(length, self.maxDistance)
    local direction = vector / length
    local power = distance / self.maxDistance
    
    return direction * (power * self.maxSpeed)
end

function Launcher:getPower()
    local vector = self.start - self.current
    local distance = math.sqrt(vector.lengthSqr)
    
    return math.min(distance / self.maxDistance, 1)
end

function Launcher:getPowerColor()
    local power = self:getPower()
    
    if power < 0.333 then
        local t = power / 0.333
        return color(theme.fg.r * (1 - t), theme.fg.g * (1 - t) + 255 * t, theme.fg.b * (1 - t))
    elseif power < 0.666 then
        local t = (power - 0.333) / 0.333
        return color(0 + 255 * t, 255 - 100 * t, 0)
    else
        local t = (power - 0.666) / 0.334
        return color(255, 155 * (1 - t), 0)
    end
end

function Launcher:draw()
    if not self.active then return end
    
    local powerColor = self:getPowerColor()
    local radius = self.circleRadius * 4 * self:getPower()
    
    style.push()
    
    -- Drag line
    stroke(powerColor.r, powerColor.g, powerColor.b, 128)
    strokeWidth(2)
    line(self.start.x, self.start.y, self.current.x, self.current.y)
    
    -- Power circle
    noFill()
    stroke(powerColor.r, powerColor.g, powerColor.b, 128)
    strokeWidth(4)
    ellipse(self.start.x, self.start.y, radius * 2, radius * 2)
    
    -- Launch point
    fill(theme.fg)
    noStroke()
    ellipse(self.start.x, self.start.y, 12, 12)
    
    style.pop()
end