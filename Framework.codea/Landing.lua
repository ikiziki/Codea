-- serves the games main menu
-- chris geese @ 2026

Landing = class("Landing", BaseState)
function Landing:init()
    mscmgr:play(audioAssets.fell, true)
end

function Landing:enter()
    print("Landing Loaded")
end

function Landing:update(dt)
end

function Landing:draw()
    if te.style == 1.0 then
        background(235)
    elseif te.style == 2.0 then
        background(35)
    end
end

function Landing:exit()
end

function Landing:touched(touch)
end

