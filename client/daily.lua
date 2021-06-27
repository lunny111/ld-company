local npcPos = vector4(233.91046142578, -562.49584960938, 42.278728485107, 260.0)
local lastOsTime = GetGameTimer()

Citizen.CreateThread(function()
    local label = "Yemekci Kocatürk"
    local blip = AddBlipForCoord(vector3(npcPos.x, npcPos.y, npcPos.z))
    SetBlipSprite(blip, 268)
    SetBlipScale(blip, 0.5)
    SetBlipColour(blip, 47)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)

    exports["pant-base"]:pedcreate("yemekci", `csb_burgerdrug`, npcPos.x,  npcPos.y,  npcPos.z,  npcPos.w)
    exports["pant-base"]:addNotif("E", label, 3, 2, vector3(npcPos.x, npcPos.y, npcPos.z))
end)

RegisterNetEvent('companyDaiylKeybindGeneral')
AddEventHandler('companyDaiylKeybindGeneral', function()
    if #(vector3(npcPos.x, npcPos.y, npcPos.z) - GetEntityCoords(PlayerPedId())) < 2 then
        if GetGameTimer() > lastOsTime then
            TriggerServerEvent("ld-company:daily")
            lastOsTime = GetGameTimer() + 1000000000000000000000
        else
            PantCore.Functions.Notify("Wait a little!", "error")
        end
    end
end)