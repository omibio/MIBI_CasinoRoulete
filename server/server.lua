local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP") 
local vrps = Tunnel.getInterface("vRP")

local spinspeed = 2.0
local bowspin = 0
rotacao = nil
spining = false
random = {}
ItemsSize = #casinowhell.ItemsAndRewardsOnClockwise 
bow = 360/ItemsSize
random[1] = 1
local oldloop = 0

function multiply(random, voltas, bowspin)
    bowspin = voltas*(ItemsSize) +random[2] -random[1] 
    if bowspin == 0 then
        return itemsize
    end
    random[1] = random[2] 
    return bowspin
end

RegisterServerEvent("MIBI:preparespin")
AddEventHandler("MIBI:preparespin", function()
    local seed = os.clock()*100
    math.randomseed(seed)
    random[2] = math.random(1, ItemsSize)
    print(random[2])
    print(random[1])
    if random[2] == 1 then
        random[2] = ItemsSize +1
    end
    if random[1] == 21 then
        random[1] = 1
    end
    local multiply = multiply(random, 3, bowspin) 
    local loop = bow*multiply +oldloop
    oldloop = loop
    TriggerClientEvent("MIBI:spinroulete", -1, loop, spinspeed)
end)

RegisterNetEvent("MIBI:rotaion")
AddEventHandler("MIBI:rotaion", function(rotation, source, ped)
    rotacao = (random[2] -1)*bow
    local user_id = vRP.getUserId(source)
    if random[2] == 21 then
        random[2] = 1
    end
    casinowhell:Handler(function(fds)
        for k, v in pairs(fds.SpecialItems) do
            Wait(10)
            for k2, v2 in pairs(fds.ItemsAndRewardsOnClockwise[random[2]]) do
                Wait(10)
                spining = false
                if v == k2 then
                    if k2 == "dinheiro" then
                        vRP.giveMoney(user_id, tonumber(v2))
                    elseif k2 == "carro" then
                       
                    elseif k2 == "procurado" then
                        TriggerEvent("notificacao", casinowhell.pos.x, casinowhell.pos.y, casinowhell.pos.z, user_id)
                    elseif k2 == "preso" then
                        
                    end
                    vRP.giveInventoryItem(userid, k2, tonumber(v2))
                    return
                end
                vRP.giveInventoryItem(user_id, k2, v2, nil)
                return 
            end        
        end
    end)
end)
