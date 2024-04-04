local VORPInv = exports.vorp_inventory:vorp_inventoryApi()
local VORPCore = exports.vorp_core:GetCore()

local function degradeItems(itemsToDegrade)
    for _, itemToDegrade in ipairs(itemsToDegrade) do
        local item = itemToDegrade.item
        local itemData = itemToDegrade.itemData
        local meta = itemData.metadata

        local _source = source
        local currentTime = os.time()

        if not meta.added_at or not meta.quality then
            meta.added_at = currentTime
            exports.vorp_inventory:setItemMetadata(_source, itemData.id, { quality = 100, added_at = currentTime }, 1, function(success)
                if not success then
                    print("Failed to set metadata for item:", itemData.id)
                end
            end)
        else
            local timeDifference = currentTime - meta.added_at
            local degradationTime = item.degradation_rate - (timeDifference / 60)

            if degradationTime <= 0 and meta.quality > 95 then
                exports.vorp_inventory:setItemMetadata(_source, itemData.id, { quality = 100, added_at = os.time() }, 1, function(success)
                    if not success then
                        print("Failed to set metadata for item:", itemData.id)
                    end
                end)
            end

            if degradationTime <= 0 then
                VORPCore.NotifyAvanced(_source, item.label.." ~COLOR_MENU_ITEM_ATTENTION~spoiled.", "blips", "blip_supplies_food", "COLOR_PURE_WHITE", 3000)

                VORPInv.subItemID(_source, itemData.id)
                if Config.UseSpoiledItem then
                    VORPInv.addItem(_source, item.itemSpoiled, 1, { description = item.label.." spoiled", quality = 0, added_at = meta.added_at })
                end

            else
                local degradationAmount = (100 / item.degradation_rate) * (timeDifference / 60)

                if meta.quality <= 0 then
                    VORPCore.NotifyAvanced(_source, item.label.." ~COLOR_MENU_ITEM_ATTENTION~spoiled.", "blips", "blip_supplies_food", "COLOR_PURE_WHITE", 3000)
                    VORPInv.subItemID(_source, itemData.id)
                    
                    if Config.UseSpoiledItem then
                        VORPInv.addItem(_source, item.itemSpoiled, 1, { description = item.label.." spoiled", quality = 0, added_at = meta.added_at })
                    end
                else
                    setItemMetadataCached(_source, itemData.id, { quality = math.max(0, meta.quality - degradationAmount), added_at = meta.added_at }, function(success)
                        if not success then
                            --print("Failed to set metadata for item:", itemData.id)
                        end
                    end)
                end
            end
        end
    end
end

RegisterServerEvent("cr_degradation:degradePlayerItems")
AddEventHandler("cr_degradation:degradePlayerItems", function()
    local _source = source

    getUserInventoryItemsCached(_source, function(itemsData)
        local itemsToDegrade = {} 

        for _, itemData in ipairs(itemsData) do
            for _, item in ipairs(Config.ItemsToDegradation) do
                if itemData.name == item.item then
                    table.insert(itemsToDegrade, { item = item, itemData = itemData })
                    break 
                end
            end
        end

        degradeItems(itemsToDegrade)
    end)
end)