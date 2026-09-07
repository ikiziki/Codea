Atom = class("Atom")

function Atom:init(world)
    self.world = world
    self.pos = vec2(math.random(world.width), math.random(world.height))
    self.vel = vec2(0, 0)
    self.species = math.random(1, 7)
end

function Atom:update(dt)
    self.pos = self.pos + self.vel * dt
end

function Atom:draw()
    ellipse(self.pos.x, self.pos.y, 10)
end