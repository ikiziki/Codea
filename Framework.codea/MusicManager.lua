-- used to hanldle music playback
-- cheis geese @ 2026

MusicManager = class("MusicManager")

function MusicManager:init()
    self.current = nil
    print("Music Manager Loaded")
end

function MusicManager:play(track, loop)
    if self.current == track then
        return
    end
    
    music(track, loop or true)
    self.current = track
end

function MusicManager:stop()
    music.stop()
    self.current = nil
end

function MusicManager:pause()
    music.paused = true
end

function MusicManager:resume()
    music.paused = false
end

function MusicManager:setVolume(volume)
    music.volume = volume
end