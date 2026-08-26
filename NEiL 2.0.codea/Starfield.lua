-- simple starfield animation BL => TR
-- chris geese @ 2026

Star = class("Star")

function Star:init(maxSpeed,maxSize)
    self.x = rX()
    self.y = rY()
    self.v = rInt(1,maxSpeed)
    self.size = rInt(1,maxSize)
    self.scalar = 2
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
    fill(theme.fg)
    ellipse(self.x,self.y,self.size,self.size)
    style.pop()
end

Starfield = class("Starfield")

function Starfield:init()
    self.count = 250
    self.maxSpeed = 5
    self.maxSize = 3
    self.parallax = 0.15
    self.stars = {}
    for i = 1,self.count do
        table.insert(self.stars,Star(self.maxSpeed,self.maxSize))
    end
end

function Starfield:update(dt)
    for _,star in ipairs(self.stars) do
        star:update(dt)
    end
end

function Starfield:draw()
    for _,star in ipairs(self.stars) do
        star:draw()
    end
end

function Starfield:drawParallax(x,y)
    local offsetX = -x * self.parallax
    local offsetY = -y * self.parallax
    
    for _,star in ipairs(self.stars) do
        local sx = (star.x + offsetX) % WIDTH
        local sy = (star.y + offsetY) % HEIGHT
        
        style.push()
        fill(theme.fg)
        ellipse(sx,sy,star.size,star.size)
        style.pop()
    end
end