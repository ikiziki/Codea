ThemeEngine = class("ThemeEngine")

function ThemeEngine:init()
    self.lightSpecies = {
        [1] = color(220, 50, 50),
        [2] = color(230, 120, 30),
        [3] = color(210, 170, 20),
        [4] = color(30, 160, 70),
        [5] = color(30, 120, 210),
        [6] = color(100, 60, 190),
        [7] = color(200, 60, 160) 
    }
    self.darkSpecies = {
        [1] = color(255, 90, 90),
        [2] = color(255, 160, 60),
        [3] = color(255, 230, 80),
        [4] = color(80, 230, 120),
        [5] = color(80, 180, 255),
        [6] = color(150, 110, 255),
        [7] = color(240, 110, 200)
    }
    self:update()
end

function ThemeEngine:update()
    self.style = self:get()
    if self.style == 1.0 then
        self.bg = color(235)
        self.fg = color(35)
        self.species = self.lightSpecies
    elseif self.style == 2.0 then
        self.bg = color(35)
        self.fg = color(235)
        self.species = self.darkSpecies
    end
end

function ThemeEngine:get()
    return objc.viewer.view.window.screen.traitCollection.userInterfaceStyle
end
