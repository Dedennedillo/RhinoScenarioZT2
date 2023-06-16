include("scenario/scripts/misc.lua")
include("scenario/scripts/ui.lua")
include("scenario/scripts/entity.lua")
include("scenario/scripts/needs.lua")
include("scenario/scripts/economy.lua")
include("scenario/scripts/token.lua")

ENV_MODE = "development" -- development | production
RHINO_TYPE = "RhinocerosJavan"

function debugSetup()
    -- Add testing scripts here for debugging
end

--- Main scenario evaluation
--- @return number
function rhinoMain(scenario)
    try {function()
        if ENV_MODE == "development" then
            debugSetup()
        end

        checkRhinoVar()
    end}
end

--- Initialises rhino ids
function checkRhinoVar()
    if getglobalvar("RHINO_IDS") ~= nil then
        setRhinoVar()
    end
end

--- Sets rhino ids to global variable
function setRhinoVar()
    local rhinoIds = createRhinoIdListString()
    setglobalvar("RHINO_IDS", rhinoIds)
end

--- Creates a new string containing all rhino ids
--- @return string
function createRhinoIdListString()
    local rhinoIds = ""
    local rhinos = findType(RHINO_TYPE)
    for i = 1, table.getn(rhinos) do
        local rhino = resolveTable(rhinos[i].value)
        local rhinoId = getID(rhino)

        if rhinoIds == "" then
            rhinoIds = rhinoIds .. getID(rhinoId)
        else
            rhinoIds = rhinoIds .. "," .. getID(rhinoId)
        end
    end
    return rhinoIds
end

--- Checks if all the rhinos in the global variable are still present in the game
--- @return boolean
function checkRhinosPresent()
    if getglobalvar("RHINO_IDS") == nil then
        return true
    end

    -- WIP
end

-- Utility functions

--- Logger class
log = {}

--- Log debug to output
--- @param message string
function log.debug(message)
    if ENV_MODE == "development" then
        print(os.date("[%Y-%m-%d %H:%M:%S] ") .. "[DEBUG] " .. message)
        io.flush()
    end

end

--- Log error to output
--- @param message string
function log.error(message)
    if ENV_MODE == "development" then
        print(os.date("[%Y-%m-%d %H:%M:%S] ") .. "[ERROR] " .. message)
        io.flush()
    end

end

--- Log info to output
--- @param message string
function log.info(message)
    if ENV_MODE == "development" then
        print(os.date("[%Y-%m-%d %H:%M:%S] ") .. "[INFO] " .. message)
        io.flush()
    end

end

--- Log warning to output
--- @param message string
function log.warn(message)
    if ENV_MODE == "development" then
        print(os.date("[%Y-%m-%d %H:%M:%S] ") .. "[WARN] " .. message)
        io.flush()
    end
end

--- Function for try-catching
--- @param func function
function try(func)
    -- Try
    local status, exception = pcall(func)
    -- Catch
    if not status then
        log.error(exception)
        if ENV_MODE == "development" then
            -- Show exception in the message panel in-game
            local increment = 50
            for i = 0, string.len(exception), increment do
                displayZooMessageTextWithZoom(string.sub(exception, i, i + increment - 1), 1, 30)
            end
        end
    end
end

--- splits a string by a delimiter character
--- @param stringValue string
--- @param delimiter string
--- @return table
function split(stringValue, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(stringValue, delimiter, from)
    while delim_from do
        table.insert(result, string.sub(stringValue, from, delim_from - 1))
        from = delim_to + 1
        delim_from, delim_to = string.find(stringValue, delimiter, from)
    end
    table.insert(result, string.sub(stringValue, from))
    return result
end