RegisterServerEvent("ld-company:daily")
AddEventHandler("ld-company:daily", function()
local xPlayer = PantCore.Functions.GetPlayer(source)
    if xPlayer then 
        xPlayer.Functions.AddItem("atom", 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['atom'], "add", 1)
        xPlayer.Functions.AddItem("hamburger", 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['hamburger'], "add", 1)
    end
end)