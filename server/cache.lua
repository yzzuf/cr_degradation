local CACHE_EXPIRATION_TIME = 5
local CACHE_EXPIRATION_ITEM = 5

local cachedInventory = {}
local inventoryTimestamps = {} 

local cachedMetadata = {}
local metadataTimestamps = {}

function getUserInventoryItemsCached(source, callback)
    local _source = source

    if cachedInventory[_source] and inventoryTimestamps[_source] and os.time() - inventoryTimestamps[_source] <= CACHE_EXPIRATION_TIME then
        callback(cachedInventory[_source])
    else
        exports.vorp_inventory:getUserInventoryItems(_source, function(itemsData)
            cachedInventory[_source] = itemsData
            inventoryTimestamps[_source] = os.time()
            callback(itemsData)
        end)
    end
end

function setItemMetadataCached(source, itemId, metadata, callback)
    local _source = source

    if not cachedMetadata[itemId] or not metadataTimestamps[itemId] or os.time() - metadataTimestamps[itemId] > CACHE_EXPIRATION_ITEM then
        exports.vorp_inventory:setItemMetadata(_source, itemId, metadata, 1, function(success)
            if success then
                cachedMetadata[itemId] = metadata
                metadataTimestamps[itemId] = os.time()
            end
            callback(success)
        end)
    else
        cachedMetadata[itemId] = metadata
        metadataTimestamps[itemId] = os.time()
        callback(true) 
    end
end