local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local FirstSpawn = false
local car = nil
local ped = nil
local coords = vector3(2538.675,-1144.211,50.175)


RegisterCommand('first', function()
    TriggerEvent('FRP:CREATOR:FirstSpawn')
end)
--[[
RegisterCommand('goped', function()
   -- TriggerMusicEvent("REDLP_START")
  --  TriggerMusicEvent("REHR_START") -- MELHOR
  TriggerMusicEvent("REHR_START")
end)
RegisterCommand('first2', function()
    TriggerMusicEvent("MC_MUSIC_STOP")
end) ]]


RegisterNetEvent("FRP:CREATOR:FirstSpawn")
AddEventHandler(
    "FRP:CREATOR:FirstSpawn",
    function()
        if not FirstSpawn and Config.EnableCutscene then
            cAPI.StartFade(500)
            Citizen.Wait(6250)
            TriggerMusicEvent("REHR_START")            
            NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)           
            Wait(1000)
            SetEntityCoords(PlayerPedId(), 2541.934,-363.564,41.574)
            Wait(3000)
            TriggerEvent('FRP:CREATOR:CreateVehicle', 'STAGECOACH001X')
            Wait(1000)
            TriggerEvent('FRP:CREATOR:CreatePedOnVehicle', 'CS_BivCoachDriver')
            Wait(3000)
            SetPedIntoVehicle(PlayerPedId(), car, 1)
            cAPI.EndFade(500)
            Wait(2000) 
            TriggerEvent('FRP:CREATOR:StartNotify')
            FirstSpawn = true
        else            
            TriggerEvent('FRP:CREATOR:StartNotify')            
            SetEntityCoords(PlayerPedId(), Config.FirstSpawnCoords)
            FirstSpawn = false
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(10)
            if FirstSpawn then	
                local pcoords = GetEntityCoords(PlayerPedId())                
                local dst = #(coords - pcoords)	   
                if dst < 5 then
                    RemovePedFromGroup(ped, GetPedGroupIndex(PlayerPedId()))
                    Wait(100)
                    DisableAllControlActions(0)                  
                    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                    SetEntityInvincible(PlayerPedId(), false)  
                    SetCinematicModeActive(0)                    
                    FirstSpawn = false
                    N_0x69d65e89ffd72313(false)    
                    Wait(1000)
                    TaskLeaveVehicle(PlayerPedId(), car, 0, 0) 
                    Wait(2000)                         
                    TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), 2600.436,-1205.932,53.323, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
                    TriggerEvent('FRP:NOTIFY:Simple', 'Ellopták a ruháidat, de itt van a kozelben egy ruhabolt, miért nem nezel be oda?', 10000)
                    TriggerMusicEvent("MC_MUSIC_STOP")                    
                    Wait(10000)
                  --  TriggerEvent('FRP:NOTIFY:Simple', 'Digite /guiainiciante ver o Jornal Guia de Iniciante.', 10000)
                    DeleteVehicle(car)
                    DeleteEntity(ped)
                else               
                    N_0x69d65e89ffd72313(true)
                    SetCinematicModeActive(1)
                    DisableAllControlActions(1)
                end 
            end	
        end
    end
)

RegisterNetEvent("FRP:CREATOR:CreateVehicle")
AddEventHandler(
	"FRP:CREATOR:CreateVehicle",
	function(vModel)
		local veh = GetHashKey(vModel)
		local ply = GetPlayerPed()
		local coords = GetEntityCoords(ply)
		Citizen.CreateThread(
			function()
				RequestModel(veh)
				while not HasModelLoaded(veh) do
                    Wait(1000)                    
				end
				if HasModelLoaded(veh) then
                    car = CreateVehicle(veh, coords, 264.0, false, true, false, true)
				end
			end
		)
	end
)

RegisterNetEvent("FRP:CREATOR:StartNotify")
AddEventHandler(
	"FRP:CREATOR:StartNotify",
    function()
    Wait(5000)
	TriggerEvent('FRP:NOTIFY:Simple', 'Üdvözöllek kalandor. Nyugodtan fedezd fel a szerver különböző régióit, és ismerd meg a rejtélyt amit ez az új világ nyújt. ', 12000)
    Wait(15000)
    TriggerEvent('FRP:NOTIFY:Simple', 'Olvasd el a szabályzatot~ hogy tisztában légy mindennel amit csinálhatsz a szerveren, hogy elkerüld a késöbbi kérdéseket, problémákat. ', 10000)
    Wait(15000)
    TriggerEvent('FRP:NOTIFY:Simple', 'És vigyázz éjszaka a vadnyugaton, csak az igazi kalandorok maradnak fent éjszaka... azt mondják ez egy teljesen másik világ a holdfény alatt.', 12000)
    Wait(18000)
    TriggerEvent('FRP:NOTIFY:Simple', 'Ez itt Saint Dennis, az első város amit elöszőr meglátogatsz. Itt talalhatsz különféle épületeket, mint a ruhabolt, a fodrász, rendőrség, és még sok mást, de ne feledd egy nagy világ áll elötted felfedezetlenül!', 18000)
end)

RegisterNetEvent("FRP:CREATOR:CreatePedOnVehicle")
AddEventHandler(
    "FRP:CREATOR:CreatePedOnVehicle",    
    function(pedModel)
        Citizen.Wait(550)
        local pedModelHash = GetHashKey(pedModel)
		if not IsModelValid(pedModelHash) then
			return
		end

		if not HasModelLoaded(pedModelHash) then
			RequestModel(pedModelHash)
			while not HasModelLoaded(pedModelHash) do
				Citizen.Wait(10)
			end
        end
        
		ped = CreatePed(pedModelHash, coords, GetEntityHeading(PlayerPedId()), false, 0)        
        Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
        Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)

        SetEntityAsMissionEntity(ped)

        -- SetModelAsNoLongerNeeded(pedModelHash)
        Citizen.Wait(950)
        SetPedAsGroupMember(ped, GetPedGroupIndex(PlayerPedId()))

        SetPedIntoVehicle(ped, car, -1)   
        TaskVehicleDriveToCoord(ped, GetVehiclePedIsIn(ped, false), 2538.675,-1144.211,50.175, 10.0, 1.0, GetEntityModel(GetVehiclePedIsIn(PlayerPedId())), 67633207, 5.0, false)
        
        Citizen.Wait(250)
	end
)

