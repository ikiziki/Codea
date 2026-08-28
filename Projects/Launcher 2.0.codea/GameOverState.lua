-- Game Over State for NEiL
-- chris geese @ 2026

GameOverState = class("GameOverState", BaseState)

function GameOverState:init()
end

function GameOverState:enter()
    camera:reset()
    launcher:cancel()
end

function GameOverState:update(dt)
end

function GameOverState:draw()
    resetMatrix()
    fill(theme.fg)
    noStroke()
    textAlign(CENTER)
    fontSize(32)
    text("GAME OVER",WIDTH / 2,HEIGHT / 2 + 20)
    fontSize(16)
    text("TAP TO RESTART",WIDTH / 2,HEIGHT / 2 - 20)
end

function GameOverState:touched(touch)
    if touch.state == BEGAN then
        neil.lives = 3
        neil.active = false
        stateManager:load(launchState)
    end
end

function GameOverState:exit()
end