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
    self.x = x or rX()
    self.y = y or rY()
    self.vX = 0
    self.vY = 0
    self.aX = 0
    self.aY = 0
    self.fX = 0
    self.fY = 0
    self.maxSpeed = 100
    self.maxForce = 10
    self.interactionRadius = 100
    self.mass = 1
    self.radius = 5
    self.type = type or setType()
    self.color = getTypeColor(self.type)
    self.selected = false
end

-- updates the particle
function Particle:update(dt, qt)
    -- Reset force
    self.fX = 0
    self.fY = 0
    -- Find nearby particles
    local finder = circFinder(self.x, self.y, self.interactionRadius)
    local neighbors = qt:query(finder)
    -- Get the rule table for this particle type
    local rules = _G[self.type .. "Rules"]
    -- Calculate interaction forces
    for _, other in ipairs(neighbors) do
        if other ~= self then
            local dx = other.x - self.x
            local dy = other.y - self.y
            local distanceSq = dx * dx + dy * dy
            if distanceSq > 0 then
                local distance = math.sqrt(distanceSq)
                -- Normalize direction
                local nx = dx / distance
                local ny = dy / distance
                -- Get interaction strength
                local strength = rules[other.type] or 0
                -- Apply the rule
                self.fX = self.fX + nx * strength
                self.fY = self.fY + ny * strength
            end
        end
    end
    -- Limit total force
    local force = math.sqrt(self.fX * self.fX + self.fY * self.fY)
    if force > self.maxForce then
        self.fX = self.fX / force * self.maxForce
        self.fY = self.fY / force * self.maxForce
    end
    -- Force -> acceleration
    self.aX = self.fX / self.mass
    self.aY = self.fY / self.mass
    -- Acceleration -> velocity
    self.vX = self.vX + self.aX * dt
    self.vY = self.vY + self.aY * dt
    -- Limit speed
    local speed = math.sqrt(self.vX * self.vX + self.vY * self.vY)
    if speed > self.maxSpeed then
        self.vX = self.vX / speed * self.maxSpeed
        self.vY = self.vY / speed * self.maxSpeed
    end
    -- Velocity -> position
    self.x = self.x + self.vX * dt
    self.y = self.y + self.vY * dt
    -- Wrap horizontally
    if self.x < 0 then
        self.x = WIDTH
    elseif self.x > WIDTH then
        self.x = 0
    end
    -- Wrap vertically
    if self.y < 0 then
        self.y = HEIGHT
    elseif self.y > HEIGHT then
        self.y = 0
    end
end

-- draws the particle as an ellipse
function Particle:drawEllipse()
    pushStyle()
    if self.selected then
        stroke(255, 0, 0)
        strokeWidth(1)
    else
        noStroke()
    end
    fill(self.color[1], self.color[2], self.color[3])
    ellipse(self.x, self.y, self.radius)
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
    local x1 = self.radius
    local y1 = 0
    local x2 = -self.radius
    local y2 = -self.radius * 0.6
    local x3 = -self.radius
    local y3 = self.radius * 0.6
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
        strokeWidth(2)
    end
    ellipse(self.x, self.y, self.radius)
    popStyle()
end

-- draw as theme style
function Particle:drawAllSolid()
    pushStyle()
    local style
    if te.style == 1.0 then
        style = color(35)
    elseif te.style == 2.0 then
        style = color(220)
    end
    fill(style)
    if self.selected then
        stroke(255, 0, 0)
        strokeWidth(2)
    else
        noStroke()
    end
    ellipse(self.x, self.y, self.radius)
    popStyle()
end