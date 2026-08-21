-- useful utilities to streamline projects
-- chris geese @ 2026

viewer.mode = FULLSCREEN

function rInt(min, max)
    return math.random(min, max)
end

function rFlt(min, max)
    return min + math.random() * (max - min)
end

function rBool()
    return math.random() < 0.5
end

function rSign()
    return math.random() < 0.5 and -1 or 1
end

function flipSign(n)
    return -n
end

function rX()
    return math.random(0, WIDTH)
end

function rY()
    return math.random(0, HEIGHT)
end
