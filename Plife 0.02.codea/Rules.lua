viewer.mode = FULLSCREEN

showGrid = false
showHeatmap = false

rules = {
    AA=0,AB=0,AC=0,AD=0,AE=0,AF=0,AG=0,
    BA=0,BB=0,BC=0,BD=0,BE=0,BF=0,BG=0,
    CA=0,CB=0,CC=0,CD=0,CE=0,CF=0,CG=0,
    DA=0,DB=0,DC=0,DD=0,DE=0,DF=0,DG=0,
    EA=0,EB=0,EC=0,ED=0,EE=0,EF=0,EG=0,
    FA=0,FB=0,FC=0,FD=0,FE=0,FF=0,FG=0,
    GA=0,GB=0,GC=0,GD=0,GE=0,GF=0,GG=0,
    
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

names = {"A","B","C","D","E","F","G"}

function updateRules() 
    for a = 1,7 do
        for b = 1,7 do
            local name = names[a] .. names[b]
            rules[name] = _G[name]
            rules.matrix[a][b] = _G[name]
        end
    end 
end

function resetRules()
    for a = 1,7 do
        for b = 1,7 do
            local name = names[a] .. names[b]
            _G[name] = 0
        end
    end
    updateRules() 
end

function randomizeRules()
    for a = 1,7 do
        for b = 1,7 do
            local name = names[a] .. names[b]
            _G[name] = math.random(-10,10) * 0.1  
        end
    end
    updateRules()
end

parameter.boolean("showGrid")
parameter.boolean("showHeatmap")
parameter.action("Randomize", randomizeRules)
parameter.action("Reset", resetRules)

for a = 1,7 do
    for b = 1,7 do
        local name = names[a] .. names[b] 
        _G[name] = 0
        parameter.number(name, -1, 1, 0,
        function(value)
            _G[name] = value
        end)  
    end
end

updateRules()