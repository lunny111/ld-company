PantCore = nil
local PlayerData = {}
local coreLoaded = false
Citizen.CreateThread(function()
    while PantCore == nil do
        TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

RegisterNetEvent('PantCore:Client:OnPlayerLoaded')
AddEventHandler('PantCore:Client:OnPlayerLoaded', function()
    PlayerData = PantCore.Functions.GetPlayerData()
end)

RegisterNetEvent('PantCore:Client:OnJobUpdate')
AddEventHandler('PantCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

local playerPed = PlayerPedId()
local playerCoords = GetEntityCoords(playerPed)
local zone = ""
local inProgress = false

Citizen.CreateThread(function()
    for name, data in pairs(blips) do
        local blip = AddBlipForCoord(data.coord)
        SetBlipSprite(blip, data.sprite)
        SetBlipDisplay(blip, 2)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, 17)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(data.name)
        EndTextCommandSetBlipName(blip)
    end

    while true do
        Citizen.Wait(500)
        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        local foundZone = false
        for name, data in pairs(blips) do
            if #(data.coord - playerCoords) < 150 then
                foundZone = true
                zone = name
                break
            end
        end
        if not foundZone then zone = "" end
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if coreLoaded then
            if PlayerData.job == nil then PlayerData = PantCore.Functions.GetPlayerData() end
            if PlayerData.job and PlayerData.job.name == zone then
                for name, cutCoord in pairs(cuttingCoords) do
                    local distance = #(cutCoord - playerCoords)
                    if distance < 3 and coreLoaded and not inProgress then
                        time = 1
                        local text = ""
                        if distance < 1.2 then
                            text = "[E] "
                            if IsControlJustReleased(0, 38) then
                                PantCore.UI.Menu.CloseAll()
                                local elements = {}
                                for giveItem, removeItem in pairs(cuttingItems) do
                                    table.insert(elements, {label =  PantCore.Shared.Items[giveItem].label, addItem = giveItem, removeItem = removeItem})
                                end

                                PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'cutMenu', {
                                    title    = 'Malzeme Kes/Doğra',
                                    align    = 'left',
                                    elements = elements
                                }, function(data, menu)
                                    menu.close()
                                    if data.current.addItem then
                                        PantCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cutAmount', {
                                            title = "Kaç Adet Kesmek/Doğramak İstiyorsun (Max 10)"
                                        }, function(data2, menu2)
                                            local wAmount = tonumber(data2.value)
                                            if wAmount == nil or wAmount < 0 or wAmount > 10 or wAmount == 0 then
                                                PantCore.Functions.Notify("Incorrect Value", "error")
                                            else
                                                PantCore.Functions.TriggerCallback("ld-base:item-kontrol", function(amount)
                                                    if amount >= wAmount then
                                                        menu2.close()
                                                        inProgress = true
                                                        TriggerEvent("dpemotes:play-anim", {"kelepçesök"})
                                                        PantCore.Functions.Progressbar("kd", "Cutting/Chopping", 1000*wAmount, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                                            disableMovement = true,
                                                            disableCarMovement = true,
                                                            disableMouse = false,
                                                            disableCombat = true,
                                                        }, { }, {}, {}, function() -- Done
                                                            inProgress = false
                                                            TriggerEvent("dpemotes:play-anim", {"c"})
                                                            TriggerServerEvent("ld-company:giveCutItem", data.current.addItem, data.current.removeItem, wAmount)
                                                        end, function() -- Cancel
                                                            inProgress = false
                                                            TriggerEvent("dpemotes:play-anim", {"c"})
                                                        end)
                                                    else
                                                        PantCore.Functions.Notify("Over "..wAmount.." Piece "..PantCore.Shared.Items[data.current.removeItem].label.." None!", "error")
                                                    end
                                                end, data.current.removeItem)
                                            end
                                        end, function(data2, menu2)
                                            menu2.close()
                                        end)
                                    end
                                end,function(data, menu)
                                    menu.close()
                                end)
                            end
                        end
                        PantCore.Functions.DrawText3D(cutCoord.x, cutCoord.y, cutCoord.z, text.."Cut/Chop Material")
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if PlayerData.job and PlayerData.job.name == zone then
            for name, friesCoord in pairs(friesCoords) do
                local distance = #(friesCoord - playerCoords)
                if distance < 3 and coreLoaded and not inProgress then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            PantCore.UI.Menu.CloseAll()
                            local elements = {}
                            for giveItem, removeItems in pairs(frieItem) do
                                table.insert(elements, {label =  PantCore.Shared.Items[giveItem].label, addItem = giveItem, removeItem = removeItems})
                            end

                            PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'friesMenu', {
                                title    = 'Patates Kızartması Yap',
                                align    = 'left',
                                elements = elements
                            }, function(data, menu)
                                menu.close()
                                if data.current.addItem then

                                    PantCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'cutAmount', {
                                        title = "Kaç AdetPatates Kızartması Yapmak İstiyorsun (Max 10)"
                                    }, function(data2, menu2)
                                        local wAmount = tonumber(data2.value)
                                        if wAmount == nil or wAmount < 0 or wAmount > 10 or wAmount == 0 then
                                            PantCore.Functions.Notify("Incorrect Value", "error")
                                        else
                                            PantCore.Functions.TriggerCallback("ld-company:checkItem", function(success)
                                                if success then
                                                    menu2.close()
                                                    inProgress = true
                                                    TriggerEvent("dpemotes:play-anim", {"elısıt"})
                                                    PantCore.Functions.Progressbar("pkh", "French Fries Preparing", 1000*wAmount, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                                        disableMovement = true,
                                                        disableCarMovement = true,
                                                        disableMouse = false,
                                                        disableCombat = true,
                                                    }, { }, {}, {}, function() -- Done
                                                        inProgress = false
                                                        TriggerEvent("dpemotes:play-anim", {"c"})
                                                        TriggerServerEvent("ld-company:giveItem", data.current.addItem, data.current.removeItem, wAmount, true)
                                                    end, function() -- Cancel
                                                        inProgress = false
                                                        TriggerEvent("dpemotes:play-anim", {"c"})
                                                    end)
                                                else
                                                    PantCore.Functions.Notify('You Dont Have Enough Items',"error")
                                                    menu2.close()
                                                end
                                            end, data.current.removeItem, wAmount)
                                        end
                                    end, function(data2, menu2)
                                        menu2.close()
                                    end)
                                    
                                end
                            end,function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                    PantCore.Functions.DrawText3D(friesCoord.x, friesCoord.y, friesCoord.z, text.."Prepare french fries")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

--Skill Bar
Citizen.CreateThread(function()
    while true do
        local time = 500
        if PlayerData.job and PlayerData.job.name == zone then
            for name, drinkCoord in pairs(drinkCoords) do
                local distance = #(drinkCoord - playerCoords)
                if distance < 3 and coreLoaded and not inProgress then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            PantCore.UI.Menu.CloseAll()
                            local elements = {}
                            for giveItem, removeItems in pairs(drinkItem) do
                                table.insert(elements, {label =  PantCore.Shared.Items[giveItem].label, addItem = giveItem, removeItem = removeItems})
                            end

                            PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'drinkMenu', {
                                title    = 'İçecek Hazırla',
                                align    = 'left',
                                elements = elements
                            }, function(data, menu)
                                menu.close()
                                if data.current.addItem then
                                    PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(success)
                                        if success >= 1 then
                                            inProgress = true
                                            TriggerEvent("dpemotes:play-anim", {"bardak"})
                                            local finished = exports["ld-skillbar"]:taskBar(7000,math.random(10,15), true)
                                            if finished then
                                                TriggerServerEvent("ld-company:giveItem", data.current.addItem, data.current.removeItem, 1, true)
                                            else
                                                PantCore.Functions.Notify(PantCore.Shared.Items[data.current.addItem].label.." Spilled on the Ground!", "error")
                                            end
                                            TriggerEvent("dpemotes:play-anim", {"c"})
                                            inProgress = false
                                        else
                                        end
                                    end, 'havuc', 'portakal_suyu', 'domates_suyu')
                                end
                            end,function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                    PantCore.Functions.DrawText3D(drinkCoord.x, drinkCoord.y, drinkCoord.z, text.."Prepare the drink")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

-- Skill Bar Yemek Pişirme
Citizen.CreateThread(function()
    while true do
        local time = 500
        if PlayerData.job and PlayerData.job.name == zone then
            for name, foodCoord in pairs(foodCoords) do
                local distance = #(foodCoord - playerCoords)
                if distance < 3 and coreLoaded and not inProgress then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            PantCore.UI.Menu.CloseAll()
                            local elements = {}
                            for giveItem, removeItems in pairs(foodItems[zone]) do
                                table.insert(elements, {label =  PantCore.Shared.Items[giveItem].label, addItem = giveItem, removeItem = removeItems})
                            end

                            PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'foodMenu', {
                                title    = 'Yiyecek Hazırla',
                                align    = 'left',
                                elements = elements
                            }, function(data, menu)
                                menu.close()
                                if data.current.addItem then
                                    PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(success)
                                        if success >= 1 then
                                            inProgress = true
                                            TriggerEvent("dpemotes:play-anim", {"bozukluk"})
                                            local finished = exports["ld-skillbar"]:taskBar(7000,math.random(10,15), true)
                                            if finished then
                                                TriggerServerEvent("ld-company:giveItem", data.current.addItem, data.current.removeItem, 1, true)
                                            else
                                                PantCore.Functions.Notify(PantCore.Shared.Items[data.current.addItem].label.."Burned!", "error")
                                            end
                                            TriggerEvent("dpemotes:play-anim", {"c"})
                                            inProgress = false
                                        else
                                            PantCore.Functions.Notify('It should be cold lettuce, cold tomato, cold onion, minced meat.', 'error')
                                        end
                                    end, 'marul2', 'kiyma', 'domates2', 'sogan2')
                                end
                            end,function(data, menu)
                                menu.close()
                            end)
                        end
                    end
                    PantCore.Functions.DrawText3D(foodCoord.x, foodCoord.y, foodCoord.z, text.."Prepare the food")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if PlayerData.job and PlayerData.job.name == zone then
            for name, storageCoord in pairs(storageCoord) do
                local distance = #(storageCoord - playerCoords)
                if distance < 3 and coreLoaded and not inProgress then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("inventory:client:SetCurrentStash", "storage"..zone)
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "storage"..zone, {
                                maxweight = 4000000,
                                slots = 500,
                            })
                        end
                    end
                    PantCore.Functions.DrawText3D(storageCoord.x, storageCoord.y, storageCoord.z, text.."Warehouse")
                end
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        for name, tableCoord in pairs(tableCoord) do
            local distance = #(tableCoord - playerCoords)
            if distance < 3 and coreLoaded and not inProgress then
                time = 1
                local text = ""
                if distance < 1.2 then
                    text = "[E] "
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent("inventory:client:SetCurrentStash", "table"..zone)
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "table"..zone, {
                            maxweight = 4000000,
                            slots = 500,
                        })
                    end
                end
                PantCore.Functions.DrawText3D(tableCoord.x, tableCoord.y, tableCoord.z, text.."Workbench")
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        for name, tableCoord1 in pairs(tableCoord1) do
            local distance = #(tableCoord1 - playerCoords)
            if distance < 3 and coreLoaded and not inProgress then
                time = 1
                local text = ""
                if distance < 1.2 then
                    text = "[E] "
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent("inventory:client:SetCurrentStash", "table-2"..zone)
                        TriggerServerEvent("inventory:server:OpenInventory", "stash", "table-2"..zone, {
                            maxweight = 4000000,
                            slots = 500,
                        })
                    end
                end
                PantCore.Functions.DrawText3D(tableCoord1.x, tableCoord1.y, tableCoord1.z, text.."Workbench-2")
            end
        end
        Citizen.Wait(time)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0, 167) and PlayerData.job then
            local haveJob = false
            for job, data in pairs(blips) do
                if PlayerData.job.name == job then
                    haveJob = true
                    break
                end
            end

            if haveJob then
                PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'foodMenu', {
                    title    = 'İşletme Menüsü',
                    align    = 'left',
                    elements = {
                        {label = "Fatura Kes", value = "bill"},
                        {label = "Paketle", value = "packet"}
                    }
                }, function(data, menu)
                    menu.close()
                    if data.current.value == "bill" then
                        PantCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
                            title = "Toplam Kesilecek Para Cezanın Miktarı"
                        }, function(data2, menu2)
                            local amount = tonumber(data2.value)
                            if amount == nil or amount < 0 then
                                PantCore.Functions.Notify("Incorrect Value")
                            else
                                local closestPlayer, closestDistance = PantCore.Functions.GetClosestPlayer()
                                if closestPlayer == -1 or closestDistance > 3.0 then
                                    PantCore.Functions.Notify("No One Near", "error")
                                else
                                    menu2.close()
                                    PantCore.Functions.Notify(amount ..'$ Invoice with Value Sent to Person!')
                                    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), PlayerData.job.name, PlayerData.charinfo.firstname.. " " ..PlayerData.charinfo.lastname, amount)
                                end
                            end
                        end, function(data2, menu2)
                            menu2.close()
                        end)

                    elseif data.current.value == "packet" then
                        TriggerServerEvent("ld-company:packet")
                    end
                end,function(data, menu)
                    menu.close()
                end)
            end
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 500
        if coreLoaded and PlayerData.job and PlayerData.job.name == zone and PlayerData.job.boss then
            for name, bossCoords in pairs(bossCoord) do
                local distance = #(bossCoords - playerCoords)
                if distance < 3 then
                    time = 1
                    local text = ""
                    if distance < 1.2 then
                        text = "[E] "
                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent("bb-bossmenu:server:openMenu")
                        end
                    end
                    PantCore.Functions.DrawText3D(bossCoords.x, bossCoords.y, bossCoords.z, text.."Boss Actions")
                end
            end
        end
        Citizen.Wait(time)
    end
end)