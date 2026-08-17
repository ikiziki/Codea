-- particle interaction rules
-- chris geese @ 2026

ARules = {
    A = 0.0,
    B = 0.0,
    C = 0.0,
    D = 0.0,
    E = 0.0,
    F = 0.0,
    G = 0.0
}

BRules = {
    A = 0.0,
    B = 0.0,
    C = 0.0,
    D = 0.0,
    E = 0.0,
    F = 0.0,
    G = 0.0
}

CRules = {
    A = 0.0,
    B = 0.0,
    C = 0.0,
    D = 0.0,
    E = 0.0,
    F = 0.0,
    G = 0.0
}

DRules = {
    A = 0.0,
    B = 0.0,
    C = 0.0,
    D = 0.0,
    E = 0.0,
    F = 0.0,
    G = 0.0
}

ERules = {
    A = 0.0,
    B = 0.0,
    C = 0.0,
    D = 0.0,
    E = 0.0,
    F = 0.0,
    G = 0.0
}

FRules = {
    A = 0.0,
    B = 0.0,
    C = 0.0,
    D = 0.0,
    E = 0.0,
    F = 0.0,
    G = 0.0
}

GRules = {
    A = 0.0,
    B = 0.0,
    C = 0.0,
    D = 0.0,
    E = 0.0,
    F = 0.0,
    G = 0.0
}

-- Create Codea parameters
function setupRules()
    parameter.action("Randomize Rules", randomRules)
    parameter.action("Reset Rules", resetRules)
    parameter.number("AA", -1.0, 1.0, 0.0, function(v) ARules.A = v end)
    parameter.number("AB", -1.0, 1.0, 0.0, function(v) ARules.B = v end)
    parameter.number("AC", -1.0, 1.0, 0.0, function(v) ARules.C = v end)
    parameter.number("AD", -1.0, 1.0, 0.0, function(v) ARules.D = v end)
    parameter.number("AE", -1.0, 1.0, 0.0, function(v) ARules.E = v end)
    parameter.number("AF", -1.0, 1.0, 0.0, function(v) ARules.F = v end)
    parameter.number("AG", -1.0, 1.0, 0.0, function(v) ARules.G = v end)
    
    parameter.number("BA", -1.0, 1.0, 0.0, function(v) BRules.A = v end)
    parameter.number("BB", -1.0, 1.0, 0.0, function(v) BRules.B = v end)
    parameter.number("BC", -1.0, 1.0, 0.0, function(v) BRules.C = v end)
    parameter.number("BD", -1.0, 1.0, 0.0, function(v) BRules.D = v end)
    parameter.number("BE", -1.0, 1.0, 0.0, function(v) BRules.E = v end)
    parameter.number("BF", -1.0, 1.0, 0.0, function(v) BRules.F = v end)
    parameter.number("BG", -1.0, 1.0, 0.0, function(v) BRules.G = v end)
    
    parameter.number("CA", -1.0, 1.0, 0.0, function(v) CRules.A = v end)
    parameter.number("CB", -1.0, 1.0, 0.0, function(v) CRules.B = v end)
    parameter.number("CC", -1.0, 1.0, 0.0, function(v) CRules.C = v end)
    parameter.number("CD", -1.0, 1.0, 0.0, function(v) CRules.D = v end)
    parameter.number("CE", -1.0, 1.0, 0.0, function(v) CRules.E = v end)
    parameter.number("CF", -1.0, 1.0, 0.0, function(v) CRules.F = v end)
    parameter.number("CG", -1.0, 1.0, 0.0, function(v) CRules.G = v end)
    
    parameter.number("DA", -1.0, 1.0, 0.0, function(v) DRules.A = v end)
    parameter.number("DB", -1.0, 1.0, 0.0, function(v) DRules.B = v end)
    parameter.number("DC", -1.0, 1.0, 0.0, function(v) DRules.C = v end)
    parameter.number("DD", -1.0, 1.0, 0.0, function(v) DRules.D = v end)
    parameter.number("DE", -1.0, 1.0, 0.0, function(v) DRules.E = v end)
    parameter.number("DF", -1.0, 1.0, 0.0, function(v) DRules.F = v end)
    parameter.number("DG", -1.0, 1.0, 0.0, function(v) DRules.G = v end)
    
    parameter.number("EA", -1.0, 1.0, 0.0, function(v) ERules.A = v end)
    parameter.number("EB", -1.0, 1.0, 0.0, function(v) ERules.B = v end)
    parameter.number("EC", -1.0, 1.0, 0.0, function(v) ERules.C = v end)
    parameter.number("ED", -1.0, 1.0, 0.0, function(v) ERules.D = v end)
    parameter.number("EE", -1.0, 1.0, 0.0, function(v) ERules.E = v end)
    parameter.number("EF", -1.0, 1.0, 0.0, function(v) ERules.F = v end)
    parameter.number("EG", -1.0, 1.0, 0.0, function(v) ERules.G = v end)
    
    parameter.number("FA", -1.0, 1.0, 0.0, function(v) FRules.A = v end)
    parameter.number("FB", -1.0, 1.0, 0.0, function(v) FRules.B = v end)
    parameter.number("FC", -1.0, 1.0, 0.0, function(v) FRules.C = v end)
    parameter.number("FD", -1.0, 1.0, 0.0, function(v) FRules.D = v end)
    parameter.number("FE", -1.0, 1.0, 0.0, function(v) FRules.E = v end)
    parameter.number("FF", -1.0, 1.0, 0.0, function(v) FRules.F = v end)
    parameter.number("FG", -1.0, 1.0, 0.0, function(v) FRules.G = v end)
    
    parameter.number("GA", -1.0, 1.0, 0.0, function(v) GRules.A = v end)
    parameter.number("GB", -1.0, 1.0, 0.0, function(v) GRules.B = v end)
    parameter.number("GC", -1.0, 1.0, 0.0, function(v) GRules.C = v end)
    parameter.number("GD", -1.0, 1.0, 0.0, function(v) GRules.D = v end)
    parameter.number("GE", -1.0, 1.0, 0.0, function(v) GRules.E = v end)
    parameter.number("GF", -1.0, 1.0, 0.0, function(v) GRules.F = v end)
    parameter.number("GG", -1.0, 1.0, 0.0, function(v) GRules.G = v end)
end

-- Reset all interaction rules to 0.0
function resetRules()
    AA = 0.0
    AB = 0.0
    AC = 0.0
    AD = 0.0
    AE = 0.0
    AF = 0.0
    AG = 0.0
    
    BA = 0.0
    BB = 0.0
    BC = 0.0
    BD = 0.0
    BE = 0.0
    BF = 0.0
    BG = 0.0
    
    CA = 0.0
    CB = 0.0
    CC = 0.0
    CD = 0.0
    CE = 0.0
    CF = 0.0
    CG = 0.0
    
    DA = 0.0
    DB = 0.0
    DC = 0.0
    DD = 0.0
    DE = 0.0
    DF = 0.0
    DG = 0.0
    
    EA = 0.0
    EB = 0.0
    EC = 0.0
    ED = 0.0
    EE = 0.0
    EF = 0.0
    EG = 0.0
    
    FA = 0.0
    FB = 0.0
    FC = 0.0
    FD = 0.0
    FE = 0.0
    FF = 0.0
    FG = 0.0
    
    GA = 0.0
    GB = 0.0
    GC = 0.0
    GD = 0.0
    GE = 0.0
    GF = 0.0
    GG = 0.0
    
    updateRules()
end

-- Set all interaction rules to random values
function randomRules()
    AA = math.random() * 2.0 - 1.0
    AB = math.random() * 2.0 - 1.0
    AC = math.random() * 2.0 - 1.0
    AD = math.random() * 2.0 - 1.0
    AE = math.random() * 2.0 - 1.0
    AF = math.random() * 2.0 - 1.0
    AG = math.random() * 2.0 - 1.0
    
    BA = math.random() * 2.0 - 1.0
    BB = math.random() * 2.0 - 1.0
    BC = math.random() * 2.0 - 1.0
    BD = math.random() * 2.0 - 1.0
    BE = math.random() * 2.0 - 1.0
    BF = math.random() * 2.0 - 1.0
    BG = math.random() * 2.0 - 1.0
    
    CA = math.random() * 2.0 - 1.0
    CB = math.random() * 2.0 - 1.0
    CC = math.random() * 2.0 - 1.0
    CD = math.random() * 2.0 - 1.0
    CE = math.random() * 2.0 - 1.0
    CF = math.random() * 2.0 - 1.0
    CG = math.random() * 2.0 - 1.0
    
    DA = math.random() * 2.0 - 1.0
    DB = math.random() * 2.0 - 1.0
    DC = math.random() * 2.0 - 1.0
    DD = math.random() * 2.0 - 1.0
    DE = math.random() * 2.0 - 1.0
    DF = math.random() * 2.0 - 1.0
    DG = math.random() * 2.0 - 1.0
    
    EA = math.random() * 2.0 - 1.0
    EB = math.random() * 2.0 - 1.0
    EC = math.random() * 2.0 - 1.0
    ED = math.random() * 2.0 - 1.0
    EE = math.random() * 2.0 - 1.0
    EF = math.random() * 2.0 - 1.0
    EG = math.random() * 2.0 - 1.0
    
    FA = math.random() * 2.0 - 1.0
    FB = math.random() * 2.0 - 1.0
    FC = math.random() * 2.0 - 1.0
    FD = math.random() * 2.0 - 1.0
    FE = math.random() * 2.0 - 1.0
    FF = math.random() * 2.0 - 1.0
    FG = math.random() * 2.0 - 1.0
    
    GA = math.random() * 2.0 - 1.0
    GB = math.random() * 2.0 - 1.0
    GC = math.random() * 2.0 - 1.0
    GD = math.random() * 2.0 - 1.0
    GE = math.random() * 2.0 - 1.0
    GF = math.random() * 2.0 - 1.0
    GG = math.random() * 2.0 - 1.0
    
    updateRules()
end

-- Copy parameter values into the rule tables
function updateRules()
    ARules.A = AA
    ARules.B = AB
    ARules.C = AC
    ARules.D = AD
    ARules.E = AE
    ARules.F = AF
    ARules.G = AG
    
    BRules.A = BA
    BRules.B = BB
    BRules.C = BC
    BRules.D = BD
    BRules.E = BE
    BRules.F = BF
    BRules.G = BG
    
    CRules.A = CA
    CRules.B = CB
    CRules.C = CC
    CRules.D = CD
    CRules.E = CE
    CRules.F = CF
    CRules.G = CG
    
    DRules.A = DA
    DRules.B = DB
    DRules.C = DC
    DRules.D = DD
    DRules.E = DE
    DRules.F = DF
    DRules.G = DG
    
    ERules.A = EA
    ERules.B = EB
    ERules.C = EC
    ERules.D = ED
    ERules.E = EE
    ERules.F = EF
    ERules.G = EG
    
    FRules.A = FA
    FRules.B = FB
    FRules.C = FC
    FRules.D = FD
    FRules.E = FE
    FRules.F = FF
    FRules.G = FG
    
    GRules.A = GA
    GRules.B = GB
    GRules.C = GC
    GRules.D = GD
    GRules.E = GE
    GRules.F = GF
    GRules.G = GG
end

-- Return the interaction between two particle types
function getRule(typeA, typeB)
    if typeA == "A" then
        return ARules[typeB]
    elseif typeA == "B" then
        return BRules[typeB]
    elseif typeA == "C" then
        return CRules[typeB]
    elseif typeA == "D" then
        return DRules[typeB]
    elseif typeA == "E" then
        return ERules[typeB]
    elseif typeA == "F" then
        return FRules[typeB]
    elseif typeA == "G" then
        return GRules[typeB]
    end
    
    return 0.0
end