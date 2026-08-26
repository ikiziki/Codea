Game = class("Game")
function Game:init()
    self.theme = ThemeEngine()
    self.sm = StateManager()
    self.sf = Starfield()
end
