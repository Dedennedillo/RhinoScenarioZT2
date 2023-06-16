include("scenario/scripts/misc.lua")
include("scenario/scripts/ui.lua")
include("scenario/scripts/entity.lua")
include("scenario/scripts/needs.lua")
include("scenario/scripts/economy.lua")
include("scenario/scripts/token.lua")

include("scripts/Utils.lua")

RHINO_TYPE = "RhinocerosJavan"
RHINO_IDS = "RHINO_IDS"

--- Initialises rhino ids
function initRhinoVar()
    if getglobalvar(RHINO_IDS) ~= nil then
        setRhinoVar()
    end
end

--- Sets rhino ids to global variable
function setRhinoVar()
    log.debug("setting rhino IDs to global var")
    local rhinoIds = createRhinoIdListString()
    setglobalvar(RHINO_IDS, rhinoIds)
    log.debug("rhino IDs: " .. rhinoIds)
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
    if getglobalvar(RHINO_IDS) == nil then
        return true
    end

    local storedRhinoIds = split(getglobalvar(RHINO_IDS), ",")
    local currentRhinoIds = split(createRhinoIdListString(), ",")

    return checkSubset(storedRhinoIds, currentRhinoIds)
end

--- WIP - Turns a list of entity ID strings into entities
--- @param IdList table
--- @return table
function getEntitiesFromIdList(IdList)
    for i = 1, table.getn(IdList) do
        local entityId = resolveTable(IdList[i])
        local entity findEntityByID(entityId)
    end
end