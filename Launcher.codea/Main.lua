-- Launcher for NEiL
-- chris geese @ 2026

function setup()
    theme = ThemeEngine()
    launcher = Launcher()
end

function update(dt)
    theme:update()
end

function draw()
    background(theme.bg)
    launcher:draw()
end

function touched(touch)
    if touch.state == BEGAN then
        launcher:touchBegan(touch)
    elseif touch.state == MOVING then
        launcher:touchMoved(touch)
    elseif touch.state == ENDED then
        launcher:touchEnded(touch)
    end
end