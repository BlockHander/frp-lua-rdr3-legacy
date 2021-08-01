local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
local HUD = false
cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

RegisterNetEvent("openHUD")
AddEventHandler(
  "openHUD",
  function(username, charname, playtime, money, level, uid, cid, gold, xp, role)
    SendNUIMessage(
      {
        type = "openHUD",
        username = username,
        charname = charname,
        playtime = playtime,
        money = money, 
        level = level,
        uid = uid,
        cid = cid,
        gold = gold,
        xp = xp,
        role = role
      }
    )
  end
)


RegisterCommand("openplayermenu", function(source)
    HUD = true
    local User = API.getUserFromSource(source)
    local Character = User:getCharacter()
    local Inventory = User:getCharacter():getInventory()

    local username = GetPlayerName(-1)

    local charname = Character:getName()

    local playtime = "123456"

    local money = Inventory.hasItem("money")

    local level = Character:getLevel()

    local uid = User:getId()

    local cid = Character:getId()
    
    local gold = Inventory.hasItem("gold")

    local xp = Character:getExp()

    local role = "user"


    TriggerEvent("openHUD", username, charname, playtime, money, level, uid, cid, gold, xp, role)

end, false)



Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
  while HUD do
    Citizen.Wait(5)

    SetTextEntry("STRING")
    AddTextComponentString("asd0")
    DrawTxt(0.0001, 0.0001)
  end
end
end)