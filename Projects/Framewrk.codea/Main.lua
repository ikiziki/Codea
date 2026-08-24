-- Framework for NEiL
-- chris geese @ 2026

function setup()
    theme = ThemeEngine()
    gsm = StateManager()
    musmgr = MusicManager()
    obj = loadObjects()
    mus = loadMusic()
    plr = loadPlayer()
    shd = loadShaders()
    snd = loadSounds()
    gsm:enter(MenuState())
end

function update(dt)
    theme:update()
    gsm:update(dt)
end

function draw()
    gsm:draw()
end

function touched(touch)
    gsm:touched(touch)
end