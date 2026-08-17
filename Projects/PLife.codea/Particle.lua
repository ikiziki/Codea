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
    if self.selected then
        stroke(255, 255, 255)
        strokeWidth(2)
    else
        noStroke()
    end
    fill(self.color[1], self.color[2], self.color[3])
    ellipse(self.x, self.y, self.radius * 2)
    popStyle()
end

-- draws the particle as a heading triangle
function Particle:drawHeading()
    pushStyle()
    if self.selected then
        stroke(255, 255, 255)
    else
        stroke(self.color[1], self.color[2], self.color[3])
    end
    strokeWidth(2)
    local angle = math.atan(self.vY, self.vX)
    pushMatrix()
    translate(self.x, self.y)
    rotate(math.deg(angle))
    -- Triangle vertices
    local x1 = self.radius
    local y1 = 0
    local x2 = -self.radius
    local y2 = -self.radius * 0.6
    local x3 = -self.radius
    local y3 = self.radius * 0.6
    -- Draw triangle
    line(x1, y1, x2, y2)
    line(x2, y2, x3, y3)
    line(x3, y3, x1, y1) 
    popMatrix()
    popStyle()
end

-- draw with no fill
function Particle:drawNoFill()
    pushStyle() 
    noFill()
    if self.selected then
        stroke(255)
        strokeWidth(2)
    else
        stroke(self.color[1], self.color[2], self.color[3])
        strokeWidth(1)
    end
    ellipse(self.x, self.y, self.radius * 2) 
    popStyle()
end

-- draw as theme style 
function Particle:drawAllSolid()
    pushStyle()
    local style
    if te.style == 1.0 then
        style = color(35)
    elseif te.style == 2.0 then
        style = color(235)
    end   
    fill(style)   
    if self.selected then
        stroke(255)
        strokeWidth(2)
    else
        noStroke()
    end  
    ellipse(self.x, self.y, self.radius * 2) 
    popStyle()
end