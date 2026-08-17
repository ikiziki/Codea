-- particle class
-- chris geese @ 2026

-- particle color table
typeColor = {
    A = {255, 145, 145},
    B = {255, 190, 130},
    C = {245, 220, 115},
    D = {120, 220, 175},
    E = {105, 205, 229},
    F = {175, 155, 225},
    G = {235, 145, 205}
}

-- picks a random type assignment
function setType()
    local types = {"A", "B", "C", "D", "E", "F", "G"}
    return types[rInt(1, #types)]
end

-- returns a color based on type
function getTypeColor(type)
    return typeColor[type]
end

-- particle class
Particle = class("Particle")

function Particle:init(x, y, type)
    self.x = x or rX()  -- particle x position
    self.y = y or rY()  -- particle y position
    self.vX = 0         -- x velocity
    self.vY = 0         -- y velocity
    self.aX = 0         -- x acceleration
    self.aY = 0         -- y acceleration
    self.fX = 0         -- x force
    self.fY = 0         -- y force
    self.maxSpeed = 5   -- maximum particle speed
    self.maxForce = 1   -- maximum force that can be applied
    self.mass = 1       -- particle mass
    self.radius = 5     -- particle size
    self.type = type or setType()      -- particle type
    self.color = getTypeColor(self.type) -- particle color
    self.selected = false
end

-- updates the particle
function Particle:update(dt)
end

-- draws the particle as an ellipse
function Particle:drawEllipse()
    pushStyle()
    noStroke()
    
    if self.selected then
        fill(255, 255, 255)
        ellipse(self.x, self.y, self.radius * 4)
    end
    
    fill(self.color[1], self.color[2], self.color[3])
    ellipse(self.x, self.y, self.radius * 2)
    
    popStyle()
end

-- draws the particle as a heading triangle
function Particle:drawHeading()
    pushStyle()
    noStroke()
    
    local angle = math.atan(self.vY, self.vX)
    
    pushMatrix()
    translate(self.x, self.y)
    rotate(math.deg(angle))
    
    if self.selected then
        fill(255, 255, 255)
        triangle(
        self.radius * 2, 0,
        -self.radius * 2, -self.radius * 1.2,
        -self.radius * 2, self.radius * 1.2
        )
    end
    
    fill(self.color[1], self.color[2], self.color[3])
    triangle(
    self.radius, 0,
    -self.radius, -self.radius * 0.6,
    -self.radius, self.radius * 0.6
    )
    
    popMatrix()
    popStyle()
end