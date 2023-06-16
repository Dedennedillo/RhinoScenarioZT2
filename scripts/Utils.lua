include("scenario/scripts/misc.lua")
include("scenario/scripts/ui.lua")
include("scenario/scripts/entity.lua")
include("scenario/scripts/needs.lua")
include("scenario/scripts/economy.lua")
include("scenario/scripts/token.lua")

--- Logger class
log = {}

--- Log debug to output
--- @param message string
function log.debug(message)
    log.log(message, "DEBUG")
end

--- Log error to output
--- @param message string
function log.error(message)
    log.log(message, "ERROR")
end

--- Log info to output
--- @param message string
function log.info(message)
    log.log(message, "INFO")
end

--- Log warning to output
--- @param message string
function log.warn(message)
    log.log(message, "WARN")
end

--- Log to output
--- @param message string
--- @param loglevel string
function log.log(message, loglevel)
    if getglobalvarr("ENV_MODE") == "development" then
        print(os.date("[%Y-%m-%d %H:%M:%S] ") .. "[" .. loglevel .. "] " .. message)
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
        if getglobalvarr("ENV_MODE") == "development" then
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

--- checks of a table is a subset of another
--- @param subsetTable table
--- @param largeTable table
--- @return boolean
function checkSubset(subsetTable, largeTable)
    for element, _ in pairs(subsetTable) do
        if not largeTable[element] then
            return false
        end
    end
    return true
end
