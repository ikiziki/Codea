-- serves the games main menu
-- chris geese @ 2026

Landing = class("Landing", BaseState)
function Landing:init()
    mscmgr:play(audioAssets.fell, true)
    sf = Starfield()
end

function Landing:enter()
end

function Landing:update(dt)
    sf:update(dt)
end

function Landing:draw()
    if te.style == 1.0 then
        background(235)
    elseif te.style == 2.0 then
        background(35)
    end
    sf:draw()
end

function Landing:exit()
end

function Landing:touched(touch)
end

