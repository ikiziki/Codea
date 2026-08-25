NEiL = class("NEiL")
function NEiL:init(pos)
    self.pos = pos or vec2(0, 0)
    self.velocity = vec2(0, 0)
    self.radius = 6
    self.active = false
end

function NEiL:update(dt)
    if not self.active then return end
    self.pos = self.pos + self.velocity * dt 
    if self.pos.x < -self.radius or
    self.pos.x > WIDTH + self.radius or
    self.pos.y < -self.radius or
    self.pos.y > HEIGHT + self.radius then
        self.active = false
    end
end

function NEiL:draw()
    if not self.active then return end
    fill(theme.fg)
    noStroke()
    ellipse(self.pos.x, self.pos.y, self.radius * 2, self.radius * 2)
end