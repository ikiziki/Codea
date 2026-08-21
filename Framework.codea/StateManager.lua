-- State Manager
-- chris geese @ 2026

StateManager = class("StateManager")
function StateManager:init()
    self.currentState = nil
    self.previousState = nil
    self.stateStack = {}
end

function StateManager:enter(state)
    if self.currentState then
        if self.currentState.exit then
            self.currentState:exit()
        end
    end
    self.previousState = self.currentState
    self.currentState = state
    if self.currentState.enter then
        self.currentState:enter()
    end
end

function StateManager:push(state)
    if self.currentState then
        if self.currentState.pause then
            self.currentState:pause()
        end
        table.insert(self.stateStack, self.currentState)
    end
    self.currentState = state
    if self.currentState.enter then
        self.currentState:enter()
    end
end

function StateManager:pop()
    if not self.currentState then
        return
    end
    if self.currentState.exit then
        self.currentState:exit()
    end
    self.currentState = table.remove(self.stateStack)
    if self.currentState and self.currentState.resume then
        self.currentState:resume()
    end
end

function StateManager:update(dt)
    if self.currentState and self.currentState.update then
        self.currentState:update(dt)
    end
end

function StateManager:draw()
    if self.currentState and self.currentState.draw then
        self.currentState:draw()
    end
end

function StateManager:exit()
    if self.currentState and self.currentState.exit then
        self.currentState:exit()
    end
end

function StateManager:touched(touch)
    if self.currentState and self.currentState.touched then
        self.currentState:touched(touch)
    end
end