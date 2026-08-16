-- quadtree for performance scaling
-- chris geese @ 2026

function setup()
    showParameters() -- for debugging
    te = ThemeEngine()
    qt = Quadtree(0,0,WIDTH,HEIGHT,10,0,4)
end

function update(dt)
    updateTheme()
end

function draw()
    qt:draw() -- for debugging
end

function touched(touch)
end
