-- particle interaction rules
-- chris geese @ 2026

local types = {"A", "B", "C", "D", "E", "F", "G"}

-- Interaction rule tables
ARules = {
    A = 0.0, B = 0.0, C = 0.0, D = 0.0, E = 0.0, F = 0.0, G = 0.0
}

BRules = {
    A = 0.0, B = 0.0, C = 0.0, D = 0.0, E = 0.0, F = 0.0, G = 0.0
}

CRules = {
    A = 0.0, B = 0.0, C = 0.0, D = 0.0, E = 0.0, F = 0.0, G = 0.0
}

DRules = {
    A = 0.0, B = 0.0, C = 0.0, D = 0.0, E = 0.0, F = 0.0, G = 0.0
}

ERules = {
    A = 0.0, B = 0.0, C = 0.0, D = 0.0, E = 0.0, F = 0.0, G = 0.0
}

FRules = {
    A = 0.0, B = 0.0, C = 0.0, D = 0.0, E = 0.0, F = 0.0, G = 0.0
}

GRules = {
    A = 0.0, B = 0.0, C = 0.0, D = 0.0, E = 0.0, F = 0.0, G = 0.0
}

-- References to the rule tables
local ruleTables = {
    A = ARules,
    B = BRules,
    C = CRules,
    D = DRules,
    E = ERules,
    F = FRules,
    G = GRules
}

-- Create Codea parameters
function setupRules()
    parameter.action("Randomize Rules", randomRules)
    parameter.action("Reset Rules", resetRules)   
    for _, from in ipairs(types) do
        for _, to in ipairs(types) do
            local name = from .. to 
            _G[name] = 0.0
            parameter.number(
            name,
            -1.0,
            1.0,
            0.0,
            function(v)
                _G[name] = v
                ruleTables[from][to] = v
            end
            )
        end
    end
end

-- Reset all interaction rules to 0.0
function resetRules()
    for _, from in ipairs(types) do
        for _, to in ipairs(types) do
            local name = from .. to  
            _G[name] = 0.0
            ruleTables[from][to] = 0.0
        end
    end
end

-- Set all interaction rules to random values
function randomRules()
    for _, from in ipairs(types) do
        for _, to in ipairs(types) do
            local name = from .. to
            local value = math.random() * 2.0 - 1.0  
            _G[name] = value
            ruleTables[from][to] = value
        end
    end
end

-- Return the interaction between two particle types
function getRule(typeA, typeB)
    if ruleTables[typeA] then
        return ruleTables[typeA][typeB] or 0.0
    end
    return 0.0
end