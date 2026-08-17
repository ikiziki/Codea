-- helper functions
-- chris geese @ 2026

-- close debug window by default
viewer.mode = FULLSCREEN

-- theme engine
function updateTheme()
    te:update()
    if te.style == 1.0 then
        bg = color(235)
        fg = color(35)
    elseif te.style == 2.0 then
        bg = color(35)
        fg = color(235)
    end
    background(bg)
end

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

