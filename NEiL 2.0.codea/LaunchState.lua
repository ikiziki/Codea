-- Launch State for NEiL
-- chris geese @ 2026

LaunchState = class("LaunchState")

function LaunchState:init()
    self.launcherTouchID = nil
end

function LaunchState:enter()
    camera:reset()
    self.launcherTouchID = nil
    launcher:cancel()
end

function LaunchState:update(dt)
end

function LaunchState:draw()
    camera:drawWorld()
    camera:drawNeil(neil)
    launcher:draw(neil.active, neil.previousFlightTime)
    camera:drawZoomIndicator()
end

function LaunchState:touched(touch)
    if touch.state == BEGAN then
        if touch.y <= HEIGHT / 4 and not launcher.active then
            camera:reset()
            if launcher:touchBegan(touch) then
                self.launcherTouchID = touch.id
                return
            end
        end
        camera:touched(touch)
        return
    end
    
    if touch.state == MOVING then
        if self.launcherTouchID == touch.id then
            launcher:touchMoved(touch)
            return
        end
        camera:touched(touch)
        return
    end
    
    if touch.state == ENDED or touch.state == CANCELLED then
        if self.launcherTouchID == touch.id then
            local velocity = vec2(0, 0)
            if touch.state == ENDED then
                velocity = launcher:touchEnded(touch)
            else
                launcher:cancel()
            end
            self.launcherTouchID = nil
            if velocity.lengthSqr > 0 then
                neil.pos = camera:screenToWorld(launcher.start)
                neil.velocity = velocity
                neil.active = true
                stateManager:load(flightState)
            end
            return
        end
        camera:touched(touch)
    end
end

function LaunchState:exit()
    self.launcherTouchID = nil
    launcher:cancel()
end