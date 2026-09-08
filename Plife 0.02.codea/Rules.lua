viewer.mode = FULLSCREEN

showGrid = false
showHeatmap = false

rules = {
    
    AA=0, AB=0, AC=0, AD=0, AE=0, AF=0, AG=0,
    BA=0, BB=0, BC=0, BD=0, BE=0, BF=0, BG=0,
    CA=0, CB=0, CC=0, CD=0, CE=0, CF=0, CG=0,
    DA=0, DB=0, DC=0, DD=0, DE=0, DF=0, DG=0,
    EA=0, EB=0, EC=0, ED=0, EE=0, EF=0, EG=0,
    FA=0, FB=0, FC=0, FD=0, FE=0, FF=0, FG=0,
    GA=0, GB=0, GC=0, GD=0, GE=0, GF=0, GG=0,
    
    matrix = {
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0}
    }
}

local names = {
    "A","B","C","D","E","F","G"
}

local function updateRules()
    for a = 1,7 do
        for b = 1,7 do
            rules.matrix[a][b] =
            rules[names[a]..names[b]]
        end
    end
end

local function resetRules()
    for a = 1,7 do
        for b = 1,7 do
            local name = names[a]..names[b]
            
            _G[name] = 0
            rules[name] = 0
            rules.matrix[a][b] = 0
        end
    end
end

local function randomizeRules()
    for a = 1,7 do
        for b = 1,7 do
            local name = names[a]..names[b]
            local value = math.random(-10,10) * 0.1
            
            _G[name] = value
            rules[name] = value
            rules.matrix[a][b] = value
        end
    end
end

parameter.boolean("showGrid")
parameter.boolean("showHeatmap")
parameter.number("InteractionRange", 10, 100, 30)
parameter.number("RepulsionRange", 1, 100, 40)
parameter.number("RepulsionStrength", 1, 300, 100)
parameter.action("Randomize",randomizeRules)
parameter.action("Reset",resetRules)

for a = 1,7 do
    for b = 1,7 do
        local name = names[a]..names[b]
        parameter.number(name, -1, 1, 0,
        function(value)
            rules[name] = value
            rules.matrix[a][b] = value
        end)
    end
end

updateRules()