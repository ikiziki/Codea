-- NEiL 3.0
-- chris geese @ 2026

function setup()
    game = Game()
    game.sm:enter(MenuState())
end

function update(dt)
    game.sm:update(dt)
end

function draw()
    game.sm:draw()
end

function touched(touch)
    game.sm:touched(touch)
end