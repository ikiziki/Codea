-- load game assets
-- chris geese @ 2026

function loadObjects()
    local obj = {
        asteroid = asset.assets.obj.asteroid,
        blackhole = asset.assets.obj.blackhole,
        earth = asset.assets.obj.earth,
        jupiter = asset.assets.obj.jupiter,
        mars = asset.assets.obj.mars,
        mercury = asset.assets.obj.mercury,
        moon = asset.assets.obj.moon,
        neptune = asset.assets.obj.neptune,
        pluto = asset.assets.obj.pluto,
        saturn = asset.assets.obj.saturn,
        sun = asset.assets.obj.sun,
        uranus = asset.assets.obj.uranus,
        venus = asset.assets.obj.venus
    }
    return obj
end

function loadPlayer()
    local plr = {
        baloonNeil = asset.assets.plr.balloon_neil,
        baloonPlanets= asset.assets.plr.balloon_planets,
        floatingNeil = asset.assets.plr.floating_neil,
        neil = asset.assets.plr.neil,
        neilPlanet = asset.assets.plr.neil_planet,
        pointingNeil = asset.assets.plr.pointing_neil,
        rocketNeil = asset.assets.plr.rocket_neil,
        starBaloon = asset.assets.plr.star_balloon,
        starNeil = asset.assets.plr.star_neil
    }
    return plr
end

function loadSounds()
    snd = {
        off = asset.assets.snd.Off,
        back = asset.assets.snd.back,
        ding = asset.assets.snd.ding,
        drip = asset.assets.snd.drip,
        drop = asset.assets.snd.drop,
        error = asset.assets.snd.error,
        hit = asset.assets.snd.hit,
        knock = asset.assets.snd.knock,
        on = asset.assets.snd.on,
        pop = asset.assets.snd.pop,
        simk = asset.assets.snd.sink,
        start = asset.assets.snd.start
    }
    return snd
end

function loadMusic()
    mus = {
        cost = asset.assets.mus.cost,
        data = asset.assets.mus.data,
        drippy = asset.assets.mus.drippy,
        echo = asset.assets.mus.echo,
        fell = asset.assets.mus.fell,
        loom = asset.assets.mus.loom,
        lost = asset.assets.mus.lost,
        mel = asset.assets.mus.mel,
        ominous = asset.assets.mus.ominous,
        trial = asset.assets.mus.trial,
        way = asset.assets.mus.way,
        which = asset.assets.mus.which
    }
    return mus
end

function loadShaders()
    shd = {
        ripple = asset.assets.shd.Ripple,
        swirl = asset.assets.shd.Swirl
    }
    return shd
end
