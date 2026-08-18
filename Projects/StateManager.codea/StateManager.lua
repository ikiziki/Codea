-- state manager class 
-- chris geese @ 2026

StateManager = class("StateManager")

function StateManager:init()
    self.currentState = nil
    self.previousState = nil
end

function StateManager:load(state)
end

function StateManager:enter()
end

function StateManager:update(dt)
end

function StateManager:draw()
end

function StateManager:pause(state)
end

function StateManager:resume(state)
end

function StateManager:cleanup()
end

function StateManager:exit()
end
