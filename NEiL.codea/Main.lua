-- Main for NEiL
-- chris geese @ 2026

function setup()
    viewer.mode = FULLSCREEN
    theme = ThemeEngine()
    worldWidth = WIDTH * 2
    worldHeight = HEIGHT * 2
    starfield = Starfield()
    camera = Camera()
    launcher = Launcher()
    neil = NEiL(camera:screenToWorld(vec2(WIDTH / 2, HEIGHT / 2)))
    touches = {}
    launcherTouchID = nil
    cameraTouchID = nil
    pinchActive = false
    neilWasActive = false
end

function update(dt)
    theme:update()
    starfield:update(dt)
    neil:update(dt)
    if neilWasActive and not neil.active then
        camera:reset()
    end
    neilWasActive = neil.active
end

function draw()
    background(theme.bg)
    starfield:draw()
    camera:drawWorld()
    camera:drawNeil(neil)
    resetMatrix()
    camera:drawNeilIndicator(neil)
    camera:drawZoomIndicator()
    launcher:draw(neil.active)
end

function touched(touch)
    if touch.state == BEGAN then
        touches[touch.id] = {
            x = touch.x,
            y = touch.y
        }
    elseif touch.state == MOVING then
        if touches[touch.id] then
            touches[touch.id].x = touch.x
            touches[touch.id].y = touch.y
        end
    end
    
    if touch.state == ENDED or touch.state == CANCELLED then
        if launcherTouchID == touch.id then
            if touch.state == ENDED then
                launcher:touchEnded(touch)
                local velocity = launcher:launch()
                neil.pos = camera:screenToWorld(launcher.start)
                neil.velocity = velocity
                neil.active = velocity.lengthSqr > 0
            else
                launcher:cancel()
            end
            launcherTouchID = nil
        elseif cameraTouchID == touch.id then
            cameraTouchID = nil
        end
        
        touches[touch.id] = nil
        
        local count = 0
        for _ in pairs(touches) do
            count = count + 1
        end
        
        if count < 2 then
            pinchActive = false
            camera:endPinch()
        end
        
        return
    end
    
    local active = {}
    
    for id, t in pairs(touches) do
        table.insert(active, {
            id = id,
            x = t.x,
            y = t.y
        })
    end
    
    if #active >= 2 then
        if launcher.active then
            launcher:cancel()
            launcherTouchID = nil
        end
        
        if not pinchActive then
            local dx = active[2].x - active[1].x
            local dy = active[2].y - active[1].y
            local distance = math.sqrt(dx * dx + dy * dy)
            camera:beginPinch(distance)
            pinchActive = true
        else
            local dx = active[2].x - active[1].x
            local dy = active[2].y - active[1].y
            local distance = math.sqrt(dx * dx + dy * dy)
            camera:updatePinch(distance)
        end
        
        return
    end
    
    if #active == 1 then
        local t = active[1]
        
        if pinchActive then
            pinchActive = false
            camera:endPinch()
            camera:beginPan(t)
            cameraTouchID = t.id
            return
        end
        
        if touch.id ~= t.id then return end
        
        if touch.state == BEGAN then
            if not neil.active and not launcher.active and t.y <= HEIGHT / 4 then
                if launcher:touchBegan(touch, neil.active) then
                    launcherTouchID = touch.id
                end
            else
                cameraTouchID = touch.id
                camera:beginPan(touch)
            end
        elseif touch.state == MOVING then
            if launcherTouchID == touch.id then
                launcher:touchMoved(touch)
            elseif cameraTouchID == touch.id then
                camera:updatePan(touch)
            end
        end
    end
end