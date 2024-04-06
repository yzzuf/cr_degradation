local VORPInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent("cr_degradation:setItemMetadata")
AddEventHandler("cr_degradation:setItemMetadata", function(itemData, metadata) 
    local _source = source

    if itemData == nil then 
        return
    end

    exports.vorp_inventory:setItemMetadata(_source, itemData.id, metadata, itemData.count, function(success)
        if not success then
            print("Failed to set metadata for item:", itemData.id)
        end
    end)
end)

RegisterServerEvent("cr_degradation:removeItem")
AddEventHandler("cr_degradation:removeItem", function(item, itemData) 
    local _source = source


    if item ~= nil then
        VORPInv.subItemID(_source, itemData.id)

        if Config.UseSpoiledItem then
            VORPInv.addItem(_source, item.itemSpoiled, 1, { description = item.label.." spoiled", quality = 0, added_at = meta.added_at })
        end
    end

end)

RegisterServerEvent("cr_degradation:getInventory")
AddEventHandler("cr_degradation:getInventory", function()
    local _source = source

    TriggerEvent('vorpCore:getUserInventory', _source, function(getInventory)
        local itemsToDegrade = {} 

        for _, item in ipairs(getInventory) do
            for _, itemConfig in ipairs(Config.ItemsToDegradation) do
                if item.name == itemConfig.item then
                    table.insert(itemsToDegrade, { item = itemConfig, itemData = item })
                    break
                end
            end
        end

        getInventory = nil

        TriggerClientEvent("cr_degradation:getServerTime", _source, os.time())
        TriggerClientEvent("cr_degradation:getItemsToDegrade", _source, itemsToDegrade)
    
    end)
end)