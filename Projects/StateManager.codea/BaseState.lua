-- base class (extend this class to build a new state)
-- chris geese @ 2026

BaseState = class("BaseState")

function BaseState:init()
end

function BaseState:load()
end

function BaseState:enter()
end

function BaseState:update(dt)
end

function BaseState:draw()
end

function BaseState:pause(state)
end

function BaseState:resume(state)
end

function BaseState:cleanup()
end

function BaseState:exit()
end
