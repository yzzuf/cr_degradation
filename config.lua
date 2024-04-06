Config = {}

Config.UseSpoiledItem = false -- set to true to use itemSpoiled, or it will only be removed from inventory

Config.ItemsToDegradation = {
    {item = "apple", itemSpoiled = "applespoiled", label = "Apple", degradation_rate = 30 --[[ Degradation in minutes. ]]},
    {item = "milk", itemSpoiled = "milkspoiled", label = "Milk", degradation_rate = 60 --[[ Degradation in minutes. ]]},
}