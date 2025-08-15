Config = {}

-- Framework selection: "qb" for QB-Core, "qbox" for Qbox, "esx" for esx
Config.Framework = "qb" -- Set to "qb", "qbox", or "qtarget"

-- Target system selection: "qb" for qb-target, "ox" for ox_target
Config.Target = "qb" -- Set to "qb" or "ox"

Config.RequiredItem = "phone"
Config.CatalyticItem = "catalytic_converter"
Config.BlowtorchDurability = 15 -- Maximum number of uses for the blowtorch

-- Reward configuration
Config.Rewards = {
    cash = {
        enabled = true, -- Enable/disable cash reward
        min = 500, -- Minimum amount of cash
        max = 700 -- Maximum amount of cash
    },
    black_money = {
        enabled = false, -- Enable/disable black money reward
        min = 1, -- Minimum amount of black money
        max = 3 -- Maximum amount of black money
    },
    itema = {
        enabled = false, -- Enable/disable itema reward
        item = "itema", -- Item name
        min = 1, -- Minimum amount of itema
        max = 2 -- Maximum amount of itema
    },
    markedbills = {
        enabled = true, -- Enable/disable markedbills reward (QB-Core/Qbox only)
        min = 500, -- Minimum worth of markedbills
        max = 1000 -- Maximum worth of markedbills
    }
}

Config.CheckDuration = 7000 -- Duration of checking catalytic converter in milliseconds
Config.CutDuration = 10000 -- Duration of cutting in milliseconds
Config.MaxPlayerCuts = 6 -- Max cuts before cooldown
Config.PlayerCooldownMinutes = 30 -- Cooldown duration in minutes

Config.ExchangePed = {
    model = "s_m_y_xmech_02",
    coords = vector4(326.75, -805.9, 28.27, 255.87),
    interactDist = 2.0
}

Config.ExchangeAnimation = {
    dict = "mp_common",
    anim = "givetake1_a",
    duration = 2000
}

-- Add this to the end of config.lua
Config.AlertFunction = function(vehicle)
    exports['ps-dispatch']:vehicletampering(vehicle)
end

-- Minigame settings for NumberSlide
Config.Minigame = {
    Enabled = true, -- Set to false to disable the minigame
    MinValue = 1, -- Minimum value for NumberSlide
    MaxValue = 45, -- Maximum value for NumberSlide
    Difficulty = 6 -- Difficulty/step parameter for NumberSlide
}
