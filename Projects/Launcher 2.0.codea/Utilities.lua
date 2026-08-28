-- useful utilities to streamline projects
-- chris geese @ 2026

viewer.mode = FULLSCREEN

-- returns a random whole number between min/max
function rInt(min, max)
    return math.random(min, max)
end

-- returns a random float between min/max
function rFlt(min, max)
    return min + math.random() * (max - min)
end

-- returna a random boolean value
function rBool()
    return math.random() < 0.5
end

-- returns a random sign of 1 or -1
function rSign()
    return math.random() < 0.5 and -1 or 1
end

-- returns a flipped sign for n
function flipSign(n)
    return -n
end

-- returns a random integer between 0 and width
function rX()
    return math.random(0, WIDTH)
end

-- rwturns a random integer between 0 and height
function rY()
    return math.random(0, HEIGHT)
end

-- rerurns a floored vec2
function floorVec2(v)
    return vec2(math.floor(v.x), math.floor(v.y))
end
