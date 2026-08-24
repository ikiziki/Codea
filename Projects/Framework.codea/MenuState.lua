-- main menu state
-- chris geese @ 2026

MenuState = class("MenuState", BaseState)
function MenuState:init()
    sf = Starfield()
    musmgr:play(mus.fell, true)
end

function MenuState:enter()
end

function MenuState:update(dt)
    sf:update(dt)
end

function MenuState:draw()
    background(theme.bg)
    sf:draw()
end

function MenuState:exit()
end

function MenuState:touched(touch)
end


