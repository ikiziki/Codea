HomeState = class("HomeState", BaseState)

function HomeState:enter()
    print("home loaded")
    sf = Starfield()
end

function HomeState:update(dt)
    sf:update(dt)
end

function HomeState:draw()
    sf:draw()
end

function HomeState:touched(touch)
end

function HomeState:exit()
end