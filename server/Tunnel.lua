local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP") 
local vrps = Tunnel.getInterface("vRP")

MIBIs = {}
Tunnel.bindInterface("MIBI_CasinoRoulete", MIBIs)


MIBIs.HasItem = function(source)
    local user_id = vRP.getUserId(source)
    local has = vRP.getInventoryItemAmount(user_id, "ticket_casino")
    if has > 0 and not spining then
        Wait(10)
        return true
    end
    Wait(10)
    return false
end

MIBIs.GiveItemAndSpining = function(source)
    local user_id = vRP.getUserId(source)
    vRP.tryGetInventoryItem(user_id, "ticket_casino", 1)
    spining = true
    return true
end

MIBIs.HasPerm = function(perm, source)
    local user_id = vRP.getUserId(source)
    local perm = vRP.hasPermission(userid, perm)
    return perm
end

MIBIs.GetSpin = function()
    return spining
end

MIBIs.GetRotation = function()
    if not rotacao then
        return 0.0
    end
    return -rotacao
end

RegisterCommand("fds",function(source, args)
    SetPlayerRoutingBucket(source, args[1])
end)
