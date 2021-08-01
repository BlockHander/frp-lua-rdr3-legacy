RegisterCommand("openplayermenu", function(source)
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


    TriggerClientEvent("openHUD", username, charname, playtime, money, level, uid, cid, gold, xp, role)

end, false)