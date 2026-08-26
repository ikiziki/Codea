-- NEiL for NEiL
-- chris geese @ 2026

NEiL = class("NEiL")

function NEiL:init(pos)
    self.pos = pos or vec2(0,0)
    self.velocity = vec2(0,0)
    self.radius = 6
    self.size = 24
    self.active = false
    self.previousFlightTime = 0
    self.lives = 3
end

function NEiL:update(dt)
    if not self.active then return end
    
    self.pos = self.pos + self.velocity * dt
    
    if self.pos.x < -self.radius or
    self.pos.x > worldWidth + self.radius or
    self.pos.y < -self.radius or
    self.pos.y > worldHeight + self.radius then
        self.lives = math.max(0,self.lives - 1)
        print("Lives:",self.lives)
        self.active = false
    end
end

function NEiL:draw()
    if not self.active then return end
    
    sprite(
    asset.floating_neil,
    self.pos.x,
    self.pos.y,
    self.size
    )
end

function NEiL:drawLives()
    local heartSize = 24
    local spacing = 8
    local totalWidth = heartSize * 3 + spacing * 2
    local startX = worldWidth / 2 - totalWidth / 2 + heartSize / 2
    local worldY = worldHeight - heartSize / 2 - 10
    
    for i = 1,3 do
        if i <= self.lives then
            local worldPos = vec2(
            startX + (i - 1) * (heartSize + spacing),
            worldY
            )
            local screenPos = camera:worldToScreen(worldPos)
            
            sprite(
            asset.heart,
            screenPos.x,
            screenPos.y,
            heartSize * camera.zoom
            )
        end
    end
end