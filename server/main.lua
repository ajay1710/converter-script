Inventory = {}

function Inventory.HasRequiredItem(cb)
    local fw = Framework.Name()
    local itemName = Config.RequiredItem

    if fw == "qb" or fw == "qbox" then
        local playerData = Framework.Get().Functions.GetPlayerData()
        local hasItem = false

        if playerData and playerData.items then
            for _, item in pairs(playerData.items) do
                if item and item.name == itemName and (item.amount or 0) > 0 then
                    hasItem = true
                    break
                end
            end
        end

        if hasItem then
            cb(true, Config.BlowtorchDurability)
        else
            cb(false, nil)
        end

    elseif fw == "esx" then
        local xPlayer = Framework.Get().GetPlayerData()
        local hasItem = false
        if xPlayer and xPlayer.inventory then
            for _, i in pairs(xPlayer.inventory) do
                if i.name == itemName and i.count > 0 then
                    hasItem = true
                    break
                end
            end
        end

        if hasItem then
            cb(true, Config.BlowtorchDurability)
        else
            cb(false, nil)
        end
    end
end
