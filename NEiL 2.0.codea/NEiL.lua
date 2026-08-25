-- NEiL for NEiL
-- chris geese @ 2026

NEiL = class("NEiL")

function NEiL:init(pos)
    self.pos = pos or vec2(0, 0)
    self.velocity = vec2(0, 0)
    self.radius = 6
    self.size = 24
    self.active = false
    self.previousFlightTime = 0
end

function NEiL:update(dt)
    if not self.active then return end
    
    self.pos = self.pos + self.velocity * dt
    
    if self.pos.x < -self.radius or
    self.pos.x > worldWidth + self.radius or
    self.pos.y < -self.radius or
    self.pos.y > worldHeight + self.radius then
        self.active = false
    end
end

function NEiL:draw()
    if not self.active then return end
    
    sprite(
    asset.floating_neil,
    self.pos.x,
    self.pos.y,
    self.size
    )
end