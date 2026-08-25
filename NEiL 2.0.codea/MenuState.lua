-- Menu State for NEiL
-- chris geese @ 2026

MenuState = class("MenuState", BaseState)

function MenuState:init()
    self.buttons = {
        {
            title = "NEW GAME",
            action = function()
                stateManager:load(launchState)
            end
        },
        {
            title = "CONTINUE",
            action = function()
                stateManager:load(launchState)
            end
        },
        {
            title = "TUTORIAL",
            action = function()
                print("tutorial")
            end
        },
        {
            title = "CREDITS",
            action = function()
                print("credits")
            end
        }
    }
    
    self.buttonWidth = WIDTH / 2
    self.buttonHeight = 80
    self.spacing = 25
end

function MenuState:enter()
    print("menu loaded")
end

function MenuState:update(dt)
end

function MenuState:draw()
    resetMatrix()
    
    local totalHeight =
    (#self.buttons * self.buttonHeight) +
    ((#self.buttons - 1) * self.spacing)
    
    local startY =
    HEIGHT / 2 +
    totalHeight / 2 -
    self.buttonHeight / 2
    
    for i, button in ipairs(self.buttons) do
        local y =
        startY -
        (i - 1) * (self.buttonHeight + self.spacing)
        
        fill(theme.fg.r, theme.fg.g, theme.fg.b, 192)
        noStroke()
        
        rectMode(CENTER)
        
        rect(
        WIDTH / 2,
        y,
        self.buttonWidth,
        self.buttonHeight,
        20
        )
        
        fill(theme.bg)
        fontSize(18)
        textAlign(CENTER)
        
        text(
        button.title,
        WIDTH / 2,
        y
        )
    end
end
function MenuState:exit()
end

function MenuState:touched(touch)
    if touch.state ~= BEGAN then return end
    
    local totalHeight =
    (#self.buttons * self.buttonHeight) +
    ((#self.buttons - 1) * self.spacing)
    
    local startY =
    HEIGHT / 2 +
    totalHeight / 2 -
    self.buttonHeight / 2
    
    for i, button in ipairs(self.buttons) do
        local y =
        startY -
        (i - 1) * (self.buttonHeight + self.spacing)
        
        if touch.x >= WIDTH / 2 - self.buttonWidth / 2 and
        touch.x <= WIDTH / 2 + self.buttonWidth / 2 and
        touch.y >= y - self.buttonHeight / 2 and
        touch.y <= y + self.buttonHeight / 2 then
            
            button.action()
            return
        end
    end
end