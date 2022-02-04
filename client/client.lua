local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP") 
local vrps = Tunnel.getInterface("vRP")
local MIBIs = Tunnel.getInterface("MIBI_CasinoRoulete")

local modelodaroleta = GetHashKey('vw_prop_vw_luckywheel_02a')
local basedaroleta = GetHashKey('vw_prop_vw_luckywheel_01a')
local wait = Citizen.Wait
local ped = PlayerPedId()
local pid = PlayerId()
local source = GetPlayerServerId(pid)
local animdict = "anim_casino_a@amb@casino@games@lucky7wheel@male"
local j = 0 
local cena
local hasitem 

--#############__Comandos de ajuda__#############--{
    local GetNearestObjectByRad = function(handler,raio)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local fim, obj = FindFirstObject()
        repeat 
            local opos = GetEntityCoords(obj)
            local distancia = #(coords -opos)
            if (distancia <= raio) then
                handler(obj, fim)
                break
            end
            achar, obj = FindNextObject(fim)
        until(not achar)
        EndFindObject(fim)
    end
    
    RegisterCommand("do", function(src, args)
        GetNearestObjectByRad(function(obj)   
            if MIBIs.HasPerm(MIBI.perm, source) then
                SetEntityAsMissionEntity(obj,false,false)  
                DeleteEntity(obj)
            end
        end, 5)
    end)
    --#############__Comandos de ajuda__#############--}
    
    function loadanim(animdict)
        RequestAnimDict(animdict)
        repeat
            Wait(1)
        until HasAnimDictLoaded(animdict)
    end
    
    function loadmodel(model)
        RequestModel(model)
        repeat
            wait(1)
        until HasModelLoaded(model)
    end
    
    --#####################################################################################################################
    AddEventHandler("playerSpawned", function(spawned)
        loadmodel(basedaroleta)
        basedaroleta = CreateObject(basedaroleta, MIBI.pos.x, MIBI.pos.y, MIBI.pos.z, false, false, true)
        SetModelAsNoLongerNeeded(basedaroleta)
        SetEntityHeading(basedaroleta, 60.0)
        --##########################################################################################################
        loadmodel(modelodaroleta)
        roleta = CreateObject(modelodaroleta, MIBI.pos.x, MIBI.pos.y, MIBI.pos.z2, false, false, true)
        SetModelAsNoLongerNeeded(modelodaroleta)
        local rotacao = MIBIs.GetRotation()
        SetEntityRotation(roleta, 0.0, rotacao, MIBI.Heading, 2, true)
        --##########################################################################################################
        loadanim(animdict)
        TriggerEvent("keep")
    end)
    
RegisterNetEvent("keep")
AddEventHandler("keep", function()
    wait(1000)
    local ped = PlayerPedId()
    repeat
        local distance = #(GetEntityCoords(roleta) -GetEntityCoords(ped))
        if distance <= 30 then
            if distance <= 5 then
                if IsControlJustPressed(0, 38) then
                    if (MIBIs.HasItem(source) and not MIBIs.GetSpin()) then
                        MIBIs.GiveItemAndSpining(source)
                        cena = NetworkCreateSynchronisedScene(MIBI.animpos.x , MIBI.animpos.y, MIBI.animpos.z, 0.0, 0.0, 0.0, 2, true, false, 2.0, 10.0, 1.3)
                        NetworkAddPedToSynchronisedScene(ped, cena, animdict, "enter_to_armraisedidle", 1.5, 1.5, 2, 1, 2.0, 0)
                        local cena2 = NetworkCreateSynchronisedScene(MIBI.animpos.x , MIBI.animpos.y, MIBI.animpos.z, 0.0, 0.0, 0.0, 2, false, false, 2.0, 10.0, 1.3)
                        NetworkAddPedToSynchronisedScene(ped, cena2, animdict, "armraisedidle_to_spinningidle_high", 1.5, 1.5, 2, 1, 2.0, 0)
                        NetworkStartSynchronisedScene(cena)
                        wait(1000)
                        TriggerServerEvent("MIBI:preparespin")
                        NetworkStartSynchronisedScene(cena2)
                        return
                    end
                end
                wait(10)
            else
                wait(1000)
            end
        else
            wait(10000)
        end
    until false
end)

RegisterNetEvent("MIBI:spinroulete")
AddEventHandler("MIBI:spinroulete", function(loop, spinspeed)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local opos = GetEntityCoords(roleta)
    local distancia = #(coords -opos)
    local lowspeed = spinspeed/1150
    local rotation
    while (j <= loop) do
        spinspeed = spinspeed -lowspeed
        if (spinspeed < 0.6) then
            spinspeed = 1.0
        end
        j = j +spinspeed
        SetEntityRotation(roleta, 0.0, -j, MIBI.Heading, 2, true)
        wait(10)
    end
    rotation = GetEntityRotation(roleta)
    j = math.floor(j)
    TriggerServerEvent("MIBI:rotaion", rotation.y, source, ped)
    TriggerEvent("keep")
end)
