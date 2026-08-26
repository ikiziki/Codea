-- Flight State for NEiL
-- chris geese @ 2026

FlightState = class("FlightState")

function FlightState:init()
    self.flightTime = 0
end

function FlightState:enter()
    self.flightTime = 0
    camera:endPinch()
    camera:follow(neil)
end

function FlightState:update(dt)
    self.flightTime = math.floor((self.flightTime + dt) * 100) / 100
    neil:update(dt)
    camera:updateFollow(dt)
    if not neil.active then
        launchState.previousFlightTime = self.flightTime
        camera:reset()
        stateManager:load(launchState)
    end
end

function FlightState:draw()
    starfield:drawParallax(camera.x - WIDTH * 1.5,camera.y - HEIGHT * 0.5)
    camera:drawWorld()
    camera:drawNeil(neil)
    camera:drawNeilIndicator(neil)
    camera:drawZoomIndicator()
    resetMatrix()
    fill(theme.fg)
    noStroke()
    fontSize(20)
    textAlign(LEFT)
    text(string.format("%.2f",self.flightTime),65,HEIGHT - 30)
end

function FlightState:touched(touch)
    camera:touched(touch)
end

function FlightState:exit()
    camera:reset()
end