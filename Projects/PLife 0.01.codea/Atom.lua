-- Atom
-- chris geese @ 2026

Atom = class("Atom")

function Atom:init(type,pos)
    self.type = type or math.random(5)
    self.pos = pos or vec2(math.random(WIDTH),math.random(HEIGHT))
    self.vel = vec2(0,0)
    self.radius = 5
    self.repulsionRadius = 50
    self.repulsionStrength = 100
    self.interactionRadius = 100
    self.maxSpeed = 200
end

function Atom:repel(other,dt)
    local dx = self.pos.x - other.pos.x
    local dy = self.pos.y - other.pos.y
    local distSq = dx * dx + dy * dy
    
    if distSq == 0 or distSq > self.repulsionRadius * self.repulsionRadius then
        return
    end
    
    local dist = math.sqrt(distSq)
    local strength = (self.repulsionRadius - dist) / self.repulsionRadius
    local force = strength * self.repulsionStrength * dt
    
    self.vel.x = self.vel.x + dx / dist * force
    self.vel.y = self.vel.y + dy / dist * force
end

function Atom:limitSpeed()
    local vx = self.vel.x
    local vy = self.vel.y
    local speedSq = vx * vx + vy * vy
    local max = self.maxSpeed
    
    if speedSq > max * max then
        local scale = max / math.sqrt(speedSq)
        self.vel.x = vx * scale
        self.vel.y = vy * scale
    end
end

function Atom:update(dt)
    self.pos.x = self.pos.x + self.vel.x * dt
    self.pos.y = self.pos.y + self.vel.y * dt
    
    if self.pos.x < 0 then
        self.pos.x = WIDTH
    elseif self.pos.x > WIDTH then
        self.pos.x = 0
    end
    
    if self.pos.y < 0 then
        self.pos.y = HEIGHT
    elseif self.pos.y > HEIGHT then
        self.pos.y = 0
    end
end

function Atom:draw(theme)
    local colors = {"A","B","C","D","E"}
    
    fill(theme:atomColor(colors[self.type]))
    noStroke()
    ellipse(self.pos.x,self.pos.y,self.radius * 2)
end