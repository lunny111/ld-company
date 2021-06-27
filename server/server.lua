PantCore = nil
TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)


RegisterServerEvent("ld-company:giveCutItem")
AddEventHandler("ld-company:giveCutItem", function(additem, removeitem, amount)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem(removeitem, amount)
    TriggerClientEvent('inventory:client:ItemBox', source, PantCore.Shared.Items[removeitem], "remove", amount)
    xPlayer.Functions.AddItem(additem, amount)
    TriggerClientEvent('inventory:client:ItemBox', source, PantCore.Shared.Items[additem], "add", amount)
end)

PantCore.Functions.CreateCallback("ld-company:checkItem", function(source, cb, item, amount)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    for name, miktar in pairs(item) do
        local itemchech = xPlayer.Functions.GetItemByName(name)
        if itemchech ~= nil then
            if itemchech.amount >= miktar * amount then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end
end)

RegisterServerEvent("ld-company:giveItem")
AddEventHandler("ld-company:giveItem", function(additem, removeitem, amount, bool)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    for x,y in pairs(removeitem) do
    xPlayer.Functions.RemoveItem(x, y)
    TriggerClientEvent('inventory:client:ItemBox', source, PantCore.Shared.Items[x], "remove", y)
    end
    xPlayer.Functions.AddItem(additem, amount)
    TriggerClientEvent('inventory:client:ItemBox', source, PantCore.Shared.Items[additem], "add", amount)
end)

PantCore.Functions.CreateCallback('', function(source, cb, item)
	local ply = PantCore.Functions.GetPlayer(source)
	local item = ply.Functions.GetItemByName(item)

	if item ~= nil then 
		cb(item.amount)
	else
		cb(0)
	end
end)

