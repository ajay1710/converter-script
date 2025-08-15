Framework = {}

function Framework.Get()
    if Config.Framework == "qb" or Config.Framework == "qbox" then
        if not Framework.object then
            Framework.object = exports['qb-core']:GetCoreObject()
        end
        return Framework.object
    elseif Config.Framework == "esx" then
        if not Framework.object then
            TriggerEvent('esx:getSharedObject', function(obj) Framework.object = obj end)
        end
        return Framework.object
    end
    return nil
end

function Framework.Name()
    return Config.Framework
end

function Framework.TargetType()
    return Config.Target -- "qb" or "ox"
end

-- Debug print on resource start
Citizen.CreateThread(function()
    Wait(1000)
    print("^2[ch_converter] Detected framework:^7 " .. (Config.Framework or "none"))
    print("^2[ch_converter] Detected target system:^7 " .. (Config.Target or "none"))
end)