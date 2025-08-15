local function AddVehicleTarget()
    local targetType = Framework.TargetType()

    if targetType == "qb" then
       
        exports['qb-target']:AddGlobalVehicle({
            options = {
                {
                    label = "Check Catalytic Converter",
                    icon = "fas fa-car-battery",
                    action = function(entity)
                        TriggerEvent('ch_converter:CheckCatalyticConverter', entity)
                    end
                },
                {
                    label = "Cut Catalytic Converter",
                    icon = "fas fa-car-battery",
                    action = function(entity)
                        TriggerEvent('ch_converter:attemptTheft', entity)
                    end
                }
            },
            distance = 2.0
        })
        print("[ch_converter] qb-target vehicle option registered")

    elseif targetType == "ox" then
       
        exports.ox_target:addGlobalVehicle({
            {
                name = "steal_catalytic_converter",
                icon = "fas fa-car-battery",
                label = "Steal Catalytic Converter",
                distance = 2.0,
                onSelect = function(data)
                    TriggerEvent('ch_converter:attemptTheft', data.entity)
                end
            }
        })
        print("[ch_converter] ox_target vehicle option registered")
    else
        print("[ch_converter] No supported target system found!")
    end
end


Citizen.CreateThread(function()
    Wait(2000)
    AddVehicleTarget()
end)



RegisterNetEvent('ch_converter:CheckCatalyticConverter', function(vehicle)
    local label = "Checking Catalytic Converter..."
    local duration = Config.CutDuration or 10000

 
    ShowProgressWithAnim(label, duration, function(success)
        if success then
          
            if Framework.Name() == "qb" or Framework.Name() == "qbox" then
                TriggerEvent('QBCore:Notify', "You checked the catalytic converter!", "success")
            elseif Framework.Name() == "esx" then
                TriggerEvent('esx:showNotification', "You checked the catalytic converter!")
            end
        else
            if Framework.Name() == "qb" or Framework.Name() == "qbox" then
                TriggerEvent('QBCore:Notify', "You stopped checking.", "error")
            elseif Framework.Name() == "esx" then
                TriggerEvent('esx:showNotification', "Checking cancelled.")
            end
        end
    end)
end)



RegisterNetEvent('ch_converter:attemptTheft', function(vehicle)
    Inventory.HasRequiredItem(function(hasItem, durability)
        if not hasItem then
            if Framework.Name() == "qb" or Framework.Name() == "qbox" then
                TriggerEvent('QBCore:Notify', "You need a blowtorch!", "error")
            elseif Framework.Name() == "esx" then
                TriggerEvent('esx:showNotification', "You need a blowtorch!")
            end
            return
        end

        -- Optional: Let user know about durability
        if durability and durability <= 0 then
            TriggerEvent('QBCore:Notify', "Your blowtorch is broken!", "error")
            return
        end

        local label = "Cutting Catalytic Converter..."
        local duration = Config.CutDuration or 10000

        ShowProgressWithAnim(label, duration, function(success)
            if success then
               
                if Framework.Name() == "qb" or Framework.Name() == "qbox" then
                    TriggerEvent('QBCore:Notify', "You cut the catalytic converter!", "success")
                elseif Framework.Name() == "esx" then
                    TriggerEvent('esx:showNotification', "You cut the catalytic converter!")
                end
                TriggerServerEvent('ch_converter:reduceBlowtorch')
            else
                if Framework.Name() == "qb" or Framework.Name() == "qbox" then
                    TriggerEvent('QBCore:Notify', "You stopped cutting.", "error")
                elseif Framework.Name() == "esx" then
                    TriggerEvent('esx:showNotification', "Cutting cancelled.")
                end
            end
        end)
    end)
end)





