-- State Manager
-- chris geese @ 2026

function setup()
    te = ThemeEngine()
    sm = StateManager()
    sm:load(HomeState())
end

function update(dt)
    te:update()
    sm:update(dt)
end

function draw()
    if te.style == 1.0 then
        background(235)
    elseif te.style == 2.0 then
        background(35)
    end
    sm:draw()
end

function touched(touch)
    sm:touched(touch)
end