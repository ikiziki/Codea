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
    background(te.BG)
    sf:draw()
    self:drawButtons()
end

function Landing:exit()
end

function Landing:touched(touch)
end

function Landing:drawButtons()
    pushStyle()
    noStroke()
    fill(te.BTN)
    rectMode(CENTER)
    rect(WIDTH/2,(HEIGHT/2+175), 250, 75, 20)
    rect(WIDTH/2, (HEIGHT/2), 250, 75, 20)
    rect(WIDTH/2, (HEIGHT/2-175), 250, 75, 20)
    popStyle()
end
