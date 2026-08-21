-- State Manager
-- chris geese @ 2026

-- ised to transition states 
StateManager = class("StateManager")
function StateManager:init()
    self.currentState = nil
    self.previousState = nil
    self.stateStack = {}
end

-- called if the supplied state has an enter method
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

-- called when a state should be pushed
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

-- called when a state is removed from the stack
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

-- redirects update to the current state
function StateManager:update(dt)
    if self.currentState and self.currentState.update then
        self.currentState:update(dt)
    end
end

-- redirects draw to the current state
function StateManager:draw()
    if self.currentState and self.currentState.draw then
        self.currentState:draw()
    end
end

-- called when exiting a state
function StateManager:exit()
    if self.currentState and self.currentState.exit then
        self.currentState:exit()
    end
end

-- redirects touch input to the cirrent state
function StateManager:touched(touch)
    if self.currentState and self.currentState.touched then
        self.currentState:touched(touch)
    end
end