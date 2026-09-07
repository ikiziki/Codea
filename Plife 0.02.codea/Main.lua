-- particle life 0.02
-- chris geese @ 2026

function setup()
    world = World()
    cam = Camera(world)
end

function update(dt)
    world:update(dt)
end

function draw()
    cam:apply()
    world:draw()
    cam:remove()
end

function touched(touch)
    world:touched(touch)
end