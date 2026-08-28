tutorialState = class("tutorialState", BaseState)
function tutorialState:init()
    self.backButton = {x = 90, y = 60, w = 140, h = 60, label = "Back", fontSize = 28, action = function() self:onBack() end}
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
    self:drawBackButton()
end

function tutorialState:exit()
end

function tutorialState:touched(touch)
    if touch.state == ENDED then
        local b = self.backButton
        local left   = b.x - b.w/2
        local right  = b.x + b.w/2
        local bottom = b.y - b.h/2
        local top    = b.y + b.h/2
        if touch.x >= left and touch.x <= right and touch.y >= bottom and touch.y <= top then
            b.action()
        end
    end
end

function tutorialState:drawBackButton()
    style.push()
    rectMode(CENTER)
    textAlign(CENTER)
    local b = self.backButton
    local c = game.theme.fg
    fill(c.r, c.g, c.b, 192)
    rect(b.x, b.y, b.w, b.h, 20)
    fontSize(b.fontSize)
    fill(game.theme.bg)
    text(b.label, b.x, b.y + 15)
    style.pop()
end

function tutorialState:onBack()
    game.sm:enter(MenuState())
end
