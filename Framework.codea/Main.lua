-- game framework
-- chris geese @ 2026

function setup()
    -- theme system
    te = ThemeEngine()
    -- game state manager
    gsm = StateManager()
    -- assets
    img = loadImageAssets()
    msc = loadAudioAssets()
    snd = loadSoundAssets()
    -- music manager
    mscmgr = MusicManager()
    -- load the landing state
    gsm:enter(Landing())

end

function update(dt)
    -- update the theme
    te:update()
    -- update current state
    gsm:update(dt)
end

function draw()
    -- draw currwnt state
    gsm:draw()
end

function touched(touch)
    -- resirect touch to current atate
    gsm:touched(touch)
end


-- load project sprites
function loadImageAssets()
    assets = {
        asteroid = asset.images.asteroid,
        baloonNeil = asset.images.balloon_neil,
        baloonPlanets = asset.images.balloon_planets,
        blackhole = asset.images.blackhole,
        earth = asset.images.earth,
        floatingNeil = asset.images.floating_neil,
        jupiter = asset.images.jupiter,
        mars = asset.images.mars,
        mercury = asset.images.mercury,
        moon = asset.images.moon,
        neil = asset.images.neil,
        neilPlanet = asset.images.neil_planet,
        neptune = asset.images.neptune,
        pluto = asset.images.pluto,
        pointingNeil = asset.images.pointing_neil,
        rocketNeil = asset.images.rocket_neil,
        saturn = asset.images.saturn,
        starBaloon = asset.images.star_balloon,
        starNeil = asset.images.star_neil,
        sun = asset.images.sun,
        uranus = asset.images.uranus,
        venus = asset.images.venus
        }
    return assets
end

-- load project audio assets
function loadAudioAssets()
    audioAssets = {
        cost = asset.audio.cost,
        data = asset.audio.data,
        drippy = asset.audio.drippy,
        echo = asset.audio.echo,
        fell = asset.audio.fell,
        loom = asset.audio.loom,
        lost = asset.audio.lost,
        mel = asset.audio.mel,
        ominous = asset.audio.ominous,
        trial = asset.audio.trial,
        way = asset.audio.way,
        which = asset.audio.which
        }
    return audioAssets
end

-- load project sound asseta
function loadSoundAssets()
    soundAssets = {
        off = asset.audio.Off,
        back = asset.audio.back,
        ding = asset.audio.ding,
        drip = asset.audio.drip,
        drop = asset.audio.drop,
        error = asset.audio.error,
        hit = asset.audio.hit,
        knock = asset.audio.knock,
        on = asset.audio.on,
        pop = asset.audio.pop,
        sink = asset.audio.sink,
        start = asset.audio.start
    }
    return soundAssets
end
