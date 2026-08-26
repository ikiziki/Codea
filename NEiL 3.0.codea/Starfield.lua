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
    style.push()
    fill(game.theme.fg)
    noStroke()
    for _,star in ipairs(self.stars) do
        ellipse(star.x,star.y,star.size,star.size)
    end
    style.pop()
end

function Starfield:drawParallax(x,y)
    local offsetX = -x * self.parallax
    local offsetY = -y * self.parallax
    style.push()
    fill(game.theme.fg)
    noStroke()
    for _,star in ipairs(self.stars) do
        local sx = (star.x + offsetX) % WIDTH
        local sy = (star.y + offsetY) % HEIGHT
        ellipse(sx,sy,star.size,star.size)
    end
    style.pop()
end