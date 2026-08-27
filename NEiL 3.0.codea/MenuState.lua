MenuState = class("MenuState", BaseState)
function MenuState:init()
    self.starfield = Starfield()
    self.buttons = {
        {y = HEIGHT/2+150, w = 225, h = 75, label = "New Game", fontSize = 32, action = function() self:onNewGame() end},
        {y = HEIGHT/2,     w = 225, h = 75, label = "Continue", fontSize = 32, action = function() self:onContinue() end},
        {y = HEIGHT/2-150, w = 225, h = 75, label = "Tutorial", fontSize = 32, action = function() self:onTutorial() end},
        {y = HEIGHT/2-310, w = 125, h = 50, label = "Credits",  fontSize = 32, action = function() self:onCredits() end},
    }
end

function MenuState:enter()
end

function MenuState:update(dt)
    game.theme:update()
    self.starfield:update(dt)
end

function MenuState:draw()
    background(game.theme.bg)
    self.starfield:draw()
    self:drawTitle()
    self:drawButtons()
end

function MenuState:exit()
end

function MenuState:touched(touch)
    if touch.state == ENDED then
        for _, b in ipairs(self.buttons) do
            local left   = WIDTH/2 - b.w/2
            local right  = WIDTH/2 + b.w/2
            local bottom = b.y - b.h/2
            local top    = b.y + b.h/2
            if touch.x >= left and touch.x <= right and touch.y >= bottom and touch.y <= top then
                b.action()
                break
            end
        end
    end
end

function MenuState:drawTitle()
    style.push()
    textAlign(CENTER)
    fontSize(80)
    fill(game.theme.fg)
    text("N.E.i.L", WIDTH/2, HEIGHT - 145)
    style.pop()
end

function MenuState:drawButtons()
    style.push()
    rectMode(CENTER)
    textAlign(CENTER)
    local c = game.theme.fg
    for _, b in ipairs(self.buttons) do
        fill(c.r, c.g, c.b, 192)
        rect(WIDTH/2, b.y, b.w, b.h, 20)
        fontSize(b.fontSize)
        fill(game.theme.bg)
        text(b.label, WIDTH/2, b.y + 15)
    end
    style.pop()
end

function MenuState:onNewGame()
    print("new game")
end

function MenuState:onContinue()
    print("continue")
end

function MenuState:onTutorial()
    game.sm:enter(tutorialState())
end

function MenuState:onCredits()
    print("credits")
end
