-- State Manager
-- chris geese @ 2026

StateManager = class("StateManager")

function StateManager:init()
    self.currentState = nil
    self.previousState = nil
    self.stateStack = {}
end

function StateManager:load(state)
    if self.currentState then
        self.currentState:exit()
    end
    
    self.previousState = self.currentState
    self.currentState = state
    self.currentState:enter()
end

function StateManager:push(state)
    if self.currentState then
        self.currentState:pause()
        table.insert(self.stateStack, self.currentState)
    end
    
    self.currentState = state
    self.currentState:enter()
end

function StateManager:pop()
    if not self.currentState then
        return
    end
    
    self.currentState:exit()
    self.currentState = table.remove(self.stateStack)
    
    if self.currentState then
        self.currentState:resume()
    end
end

function StateManager:update(dt)
    if self.currentState then
        self.currentState:update(dt)
    end
end

function StateManager:draw()
    if self.currentState then
        self.currentState:draw()
    end
end

function StateManager:touched(touch)
    if self.currentState then
        self.currentState:touched(touch)
    end
end


-- ============================================================
-- StateManager Tutorial
-- ============================================================
--
-- The StateManager controls which state is currently active.
--
-- A state is an object created from BaseState or a class that
-- inherits from BaseState.
--
--
-- 1. CREATE THE STATE MANAGER
--
-- In setup(), create a StateManager:
--
--     sm = StateManager()
--
--
-- 2. LOAD A STATE
--
-- Use load() when you want to completely replace the current
-- state with another state.
--
--     sm:load(HomeState())
--
-- This will:
--
--     currentState:exit()
--             ↓
--     currentState becomes previousState
--             ↓
--     new state becomes currentState
--             ↓
--     new state:enter()
--
--
-- 3. UPDATE AND DRAW
--
-- The StateManager automatically forwards update() and draw()
-- to the current state.
--
--     function update(dt)
--         sm:update(dt)
--     end
--
--     function draw()
--         sm:draw()
--     end
--
--
-- 4. HANDLE TOUCHES
--
-- Touches are also forwarded to the current state.
--
--     function touched(touch)
--         sm:touched(touch)
--     end
--
-- The active state then handles the touch:
--
--     function HomeState:touched(touch)
--         -- Handle touch here
--     end
--
--
-- 5. PUSH A STATE
--
-- Use push() when you want to temporarily place a new state
-- on top of the current state.
--
-- For example, opening a pause menu:
--
--     sm:push(PauseState())
--
-- The current state is paused and placed on the state stack.
--
--     stateStack
--         └── GameState
--
--     currentState
--         └── PauseState
--
--
-- 6. POP A STATE
--
-- Use pop() to remove the current state and return to the
-- state underneath it.
--
--     sm:pop()
--
-- This will:
--
--     currentState:exit()
--             ↓
--     currentState is removed
--             ↓
--     previous state is removed from stateStack
--             ↓
--     previous state becomes currentState
--             ↓
--     currentState:resume()
--
--
-- 7. TYPICAL STATE FLOW
--
--     HomeState
--         │
--         │ load()
--         ▼
--     GameState
--         │
--         │ push()
--         ▼
--     PauseState
--         │
--         │ pop()
--         ▼
--     GameState
--         │
--         │ load()
--         ▼
--     HomeState
--
--
-- 8. STATE LIFECYCLE
--
-- A state can implement these methods:
--
--     enter()
--         Called when the state becomes active.
--
--     update(dt)
--         Called every frame while the state is active.
--
--     draw()
--         Called every frame while the state is active.
--
--     touched(touch)
--         Called when Codea receives a touch.
--
--     pause()
--         Called when the state is pushed underneath another
--         state.
--
--     resume()
--         Called when a state above it is popped.
--
--     exit()
--         Called when the state is permanently leaving.
--
--
-- 9. BASIC MAIN FILE
--
--     function setup()
--         sm = StateManager()
--         sm:load(HomeState())
--     end
--
--     function update(dt)
--         sm:update(dt)
--     end
--
--     function draw()
--         sm:draw()
--     end
--
--     function touched(touch)
--         sm:touched(touch)
--     end
--
--
-- ============================================================