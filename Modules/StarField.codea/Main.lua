-- simple starfield animation 
-- cheis geese @ 2026

Star = class("Star")
function Star:init(maxSpeed, maxSize)
    self.x = rX()
    self.y = rY()
    self.v = rInt(1, maxSpeed)
    self.size = rInt(1, maxSize)  
    self.scalar = 10
end

function Star:update(dt)
    local movement = self.v * dt * self.scalar  
    self.x = self.x + movement
    self.y = self.y + movement  
    if self.x > WIDTH then
        self.x = 0
    end
    if self.y > HEIGHT then
        self.y = 0
    end
end

function Star:draw()
    style.push()
    fill(255)
    ellipse(self.x, self.y, self.size, self.size)
    style.pop()
end




Starfield = class("Starfield")
function Starfield:init()
    self.count = 250
    self.maxSpeed = 5
    self.maxSize = 3
    self.stars = {}  
    for i = 1, self.count do
        table.insert(self.stars, Star(self.maxSpeed, self.maxSize))
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
