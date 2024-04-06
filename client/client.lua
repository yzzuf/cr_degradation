local VORPCore = exports.vorp_core:GetCore()
local itemsToDegrade = {}
local currentTime = 0

RegisterNetEvent("cr_degradation:getItemsToDegrade")
AddEventHandler("cr_degradation:getItemsToDegrade", function(degrade)
    itemsToDegrade = degrade
end)

RegisterNetEvent("cr_degradation:getServerTime")
AddEventHandler("cr_degradation:getServerTime", function(time)
    currentTime = time
end)

local lastId = 0

local function degradeItems(itemsToDegrade)
    if next(itemsToDegrade) == nil then
        return
    end

    for _, itemToDegrade in ipairs(itemsToDegrade) do
        local item = itemToDegrade.item
        local itemData = itemToDegrade.itemData
        local meta = itemData.metadata

        local notificationSent = false
        local _source = source

        if item ~= nil then
            if not meta.added_at then
                Wait(500)
                TriggerServerEvent("cr_degradation:setItemMetadata", itemData, { added_at = currentTime })
            else
                local timeDifference = currentTime - meta.added_at
                local degradationTime = item.degradation_rate - (timeDifference / 60)

                if degradationTime <= 0 then
                    if lastId ~= itemData.id then
                        VORPCore.NotifyAvanced(item.label.." ~COLOR_MENU_ITEM_ATTENTION~spoiled.", "blips", "blip_supplies_food", "COLOR_PURE_WHITE", 1000)
                        lastId = itemData.id
                    end
                    
                    TriggerServerEvent("cr_degradation:removeItem", item, itemData)
                end
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerServerEvent("cr_degradation:getInventory")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        degradeItems(itemsToDegrade)
    end
end)