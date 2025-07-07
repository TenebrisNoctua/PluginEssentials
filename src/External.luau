-- Written by @TenebrisNoctua
-- Handles the external libraries used within PluginEssentials.

--// Variables

local Types = require(script.Parent.ComponentTypes.Fusion)

local Libraries = {} :: {Fusion: Fusion}
local AllowedLibraries = {"Fusion"}
local External = {}

--// Types

type Fusion = Types.Fusion
type LibraryName = "Fusion" | string

--// Module Functions

function External.setLibrary(library: LibraryName, source: any)
    if not table.find(AllowedLibraries, library) then 
        error("Given library cannot be added to the libraries.") 
    end

    Libraries[library] = source
end

function External.getLibrary(library: LibraryName)
    local Found = Libraries[library]
    if Found then return Found else error("Could not retrieve the requested library because it doesn't exist.") end
end

return External
