-- game framework
-- chris geese @ 2026

function setup()
    te = ThemeEngine()
    gsm = StateManager()
    gsm:enter(Landing())
    gameAssets = loadAssets()
end

function update(dt)
    te:update()
    gsm:update(dt)
end

function draw()
    gsm:draw()
end

function touched(touch)
    gsm:touched(touch)
end

function loadAssets()
    assets = {
        asteroid = asset.asteroid,
        baloonNeil = asset.balloon_neil,
        baloonPlanets = asset.balloon_planets,
        blackhole = asset.blackhole,
        earth = asset.earth,
        floatingNeil = asset.floating_neil,
        jupiter = asset.jupiter,
        mars = asset.mars,
        mercury = asset.mercury,
        moon = asset.moon,
        neil = asset.neil,
        neilPlanet = asset.neil_planet,
        neptune = asset.neptune,
        pluto = asset.pluto,
        pointingNeil = asset.pointing_neil,
        rocketNeil = asset.rocket_neil,
        saturn = asset.saturn,
        starBaloon = asset.star_balloon,
        starNeil = asset.star_neil,
        sun = asset.sun,
        uranus = asset.uranus,
        venus = asset.venus,
    }
    return assets
end
