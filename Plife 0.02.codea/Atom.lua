Atom = class("Atom")
function Atom:init(world)
    self.world = world
    self.radius = 5
    self.pos = vec2(math.random(world.width), math.random(world.height))
    local angle = math.random() * math.pi * 2
    local speed = math.random(20, 50)
    self.vel = vec2(math.cos(angle), math.sin(angle)) * speed
    self.species = math.random(1, 7)
end
function Atom:update(dt)
    self.pos = self.pos + self.vel * dt
    if self.pos.x <= self.radius or
    self.pos.x >= self.world.width - self.radius then
        self.vel.x = -self.vel.x
    end
    if self.pos.y <= self.radius or
    self.pos.y >= self.world.height - self.radius then
        self.vel.y = -self.vel.y
    end
end
function Atom:draw()
    fill(self.world.theme.species[self.species])
    ellipse(self.pos.x, self.pos.y, self.radius * 2) 
end