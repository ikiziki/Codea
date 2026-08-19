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
        self.currentState:exit()
    end
    
    self.previousState = self.currentState
    self.currentState = state
    self.currentState:enter()
end

function StateManager:push(state)
    if self.currentState then
        self.currentState:pause()
        table.insert(self.stateStack, self.currentState)
    end
    
    self.currentState = state
    self.currentState:enter()
end

function StateManager:pop()
    if not self.currentState then
        return
    end
    
    self.currentState:exit()
    self.currentState = table.remove(self.stateStack)
    
    if self.currentState then
        self.currentState:resume()
    end
end

function StateManager:update(dt)
    if self.currentState then
        self.currentState:update(dt)
    end
end

function StateManager:draw()
    if self.currentState then
        self.currentState:draw()
    end
end

function StateManager:touched(touch)
    if self.currentState then
        self.currentState:touched(touch)
    end
end
