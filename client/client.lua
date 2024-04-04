Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        TriggerServerEvent("cr_degradation:degradePlayerItems")
    end
end)