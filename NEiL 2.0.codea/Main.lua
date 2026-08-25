-- Main for NEiL
-- chris geese @ 2026

function setup()
    theme = ThemeEngine()
    worldWidth = WIDTH * 3
    worldHeight = HEIGHT * 4
    starfield = Starfield()
    camera = Camera()
    launcher = Launcher()
    neil = NEiL(camera:screenToWorld(vec2(WIDTH / 2, HEIGHT / 2)))
    stateManager = StateManager()
    launchState = LaunchState()
    flightState = FlightState()
    stateManager:load(MenuState())
end

function update(dt)
    theme:update()
    starfield:update(dt)
    stateManager:update(dt)
end

function draw()
    background(theme.bg)
    starfield:draw()
    stateManager:draw()
end

function touched(touch)
    stateManager:touched(touch)
end