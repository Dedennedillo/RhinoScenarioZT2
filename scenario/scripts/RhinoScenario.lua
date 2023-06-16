include("scenario/scripts/misc.lua")
include("scenario/scripts/ui.lua")
include("scenario/scripts/entity.lua")
include("scenario/scripts/needs.lua")
include("scenario/scripts/economy.lua")
include("scenario/scripts/token.lua")
include("scripts/RhinoUtils.lua")

function debugSetup()
    -- Add testing scripts here for debugging
end

--- Main scenario evaluation
--- @return number
function rhinoMain(scenario)
    setglobalvar("ENV_MODE", "development") -- development | production

    try (function()
        
        if getglobalvarr("ENV_MODE") == "development" then
            debugSetup()
        end

        initRhinoVar()

        -- Rest of scenario goes here

    end)
end