-- simple starfield animation
-- chris geese @ 2026

Star = class("Star")
function Star:init()
    self.x = rX()
    self.y = rY()
    self.maxSpeed = 3
    self.speed = rFlt(1, self.maxSpeed)
    self.radius = rInt(1, 4)
end

function Star:update(dt)
    self.x = self.x + self.speed * dt * 30
    if self.x > WIDTH+5 then
        self.x = -5
        self.y = rY()
        self.speed = rFlt(1, self.maxSpeed)
        self.radius = rInt(1, 4)
    end
end

function Star:draw()
    fill(te.FG)
    noStroke()
    --sprite(img.asteroid, self.x, self.y, self.radius)
    ellipse(self.x, self.y, self.radius)
end

Starfield = class("Starfield")
function Starfield:init()
    self.stars = {}
    self.count = 200
    
    for i = 1, self.count do
        table.insert(self.stars, Star())
    end
end

function Starfield:update(dt)
    for _, star in ipairs(self.stars) do
        star:update(dt)
    end
end

function Starfield:draw()
    for _, star in ipairs(self.stars) do
        star:draw()
    end
end