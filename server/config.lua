casinowhell = {}

casinowhell.ItemsAndRewardsOnClockwise = {
--posicao |    item     |    quantidade
    [1] =    {radio =        "1"},
    [2] =    {repairkit =    "1"},
    [3] =    {dinheiro =     "10000"},
    [4] =    {procurado =    "1000"}, 
    [5] =    {ticket_casino= "2"},
    [6] =    {repairkit =    "1"},
    [7] =    {dinheiro =     "10000"},
    [8] =    {procurado =    "1000"},
    [9] =    {radio =        "1"},
    [10] =   {repairkit =    "1"},
    [11] =   {procurado =    "1000"},
    [12] =   {preso =        "10"},
    [13] =   {radio =        "1"},
    [14] =   {repairkit =    "1"},
    [15] =   {dinheiro =     "10000"},
    [16] =   {procurado =    "1000"},
    [17] =   {radio =        "1"},
    [18] =   {repairkit =    "1"},
    [19] =   {carro =        "t20"},
    [20] =   {dinheiro =     "10000"},
}

--> o specialitems do indentificador
casinowhell.SpecialItems = {"dinheiro", "carro", "procurado", "preso"}

function casinowhell:Handler(handler)
    handler(self)
end

casinowhell.pos = {x = 948.7, y = 63.27, z = 75.0}

--OBS: As Coisas Variam De Base A Base Muito Ent Mudem E Caso N Funcione Entre Em Contato Comigo: OMIBIO#5378