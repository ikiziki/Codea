Camera = class()

function Camera:init(world)
    self.world = world
    self.x = world.width / 2
    self.y = world.height / 2
    self.zoom = 1 / 3
end

function Camera:apply()
    pushMatrix()
    translate(WIDTH / 2, HEIGHT / 2)
    scale(self.zoom)
    translate(-self.x, -self.y)
end

function Camera:remove()
    popMatrix()
end