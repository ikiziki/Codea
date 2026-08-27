tutorialState = class("tutorialState", BaseState)
function tutorialState:init()
end

function tutorialState:enter()
    print("Welcome to the tutorial")
end

function tutorialState:update(dt)
    game.sf:update(dt)
end

function tutorialState:draw()
    background(game.theme.bg)
    game.sf:draw()
end

function tutorialState:exit()
end