Atom = class("Atom")

function Atom:init(world)
    self.world = world
    self.pos = vec2(math.random(world.width), math.random(world.height))
    local angle = math.random() * math.pi * 2
    local speed = math.random(20, 50)
    self.vel = vec2(math.cos(angle), math.sin(angle)) * speed
    self.species = math.random(1, 7)
end

function Atom:update(dt)
    self.pos = self.pos + self.vel * dt
end

function Atom:draw()
    ellipse(self.pos.x, self.pos.y, 10)
end