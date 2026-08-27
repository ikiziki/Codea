Game = class("Game")
function Game:init()
    self.sm = StateMachine()
    self.theme = ThemeEngine()
    self.menu = MenuState()
end
