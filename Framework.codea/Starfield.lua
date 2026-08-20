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
    self.x = self.x + self.speed * dt * 60
    if self.x > WIDTH then
        self.x = 0
        self.y = rY()
        self.speed = rFlt(1, self.maxSpeed)
        self.radius = rInt(1, 4)
    end
end

function Star:draw()
    if te.style == 1.0 then
        fill(35)
    elseif te.style == 2.0 then
        fill(235)
    end
    noStroke()
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