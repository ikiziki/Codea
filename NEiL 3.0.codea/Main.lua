function setup()
    game = Game()
end

function update(dt)
    game.theme:update()
    game.sf:update(dt)
    game.sm:update(dt)
end

function draw()
    background(game.theme.bg)
    game.sm:draw()
    game.sf:draw()
end

function touched(touch)
    game.sm:touched(touch)
end