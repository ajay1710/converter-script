function StartCutAnim()
    local ped = PlayerPedId()
    local dict = "amb@world_human_vehicle_mechanic@male@base"
    local anim = "base"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(10) end
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
end

function StopCutAnim()
    ClearPedTasks(PlayerPedId())
end

function ShowProgressWithAnim(label, duration, cb)
    local fw = Framework.Name and Framework.Name() or "unknown"
    local animActive = true


    StartCutAnim()

    if fw == "qb" or fw == "qbox" then
        exports['progressbar']:Progress({
            name = "cat_cut",
            duration = duration,
            label = label,
            useWhileDead = false,
            canCancel = true,
            controlDisables = {disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true},
        }, function(cancelled)
            animActive = false
            StopCutAnim()
            cb(not cancelled)
        end)
    elseif fw == "esx" then
        if exports['mythic_progbar'] then
            exports['mythic_progbar']:Progress({
                name = "cat_cut",
                duration = duration,
                label = label,
                canCancel = true,
                controlDisables = {disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true},
            }, function(status)
                animActive = false
                StopCutAnim()
                cb(not status)
            end)
        else
      
            Citizen.SetTimeout(duration, function()
                animActive = false
                StopCutAnim()
                cb(true)
            end)
        end
    else
        Citizen.SetTimeout(duration, function()
            animActive = false
            StopCutAnim()
            cb(true)
        end)
    end
end