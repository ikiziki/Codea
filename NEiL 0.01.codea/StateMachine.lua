StateMachine = class("StateMachine")
function StateMachine:init()
    self.currentState = nil
    self.previousState = nil
    self.stateStack = {}
end

function StateMachine:enter(state)
    if self.currentState and self.currentState.exit then
        self.currentState:exit()
    end
    self.previousState = self.currentState
    self.currentState = state
    if self.currentState.enter then 
        self.currentState:enter()
    end
end

function StateMachine:update(dt)
    if self.currentState and self.currentState.update then
        self.currentState:update(dt)
    end
end

function StateMachine:draw()
    if self.currentState and self.currentState.draw then
        self.currentState:draw()
    end
end

function StateMachine:pause()
    if self.currentState then
        table.insert(self.stateStack, self.currentState)
        if self.currentState.pause then
            self.currentState:pause()
        end
    end
end

function StateMachine:resume()
    if #self.stateStack > 0 then
        if self.currentState and self.currentState.exit then
            self.currentState:exit()
        end
        self.previousState = self.currentState
        self.currentState = table.remove(self.stateStack)
        if self.currentState.resume then
            self.currentState:resume()
        end
    end
end

function StateMachine:exit()
    if self.currentState and self.currentState.exit then
        self.currentState:exit()
    end
end

function StateMachine:touched(touch)
    if self.currentState and self.currentState.touched then
        self.currentState:touched(touch)
    end
end
