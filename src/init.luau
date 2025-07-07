-- Written by @TenebrisNoctua
-- Entry point for the PluginEssentials library.

--// Variables

local Types = require(script.ComponentTypes.Fusion)
local External = require(script.External)

local PluginEssentials = {
    PluginComponents = script.PluginComponents,
    StudioComponents = script.StudioComponents
}

--// Types

type Fusion = Types.Fusion

--// Module Functions

--[[ 
    Sets the fusion library that will be used to create the components.
    Warning: Setting the fusion library to a version higher or lower may cause major bugs. Be careful.
]]
function PluginEssentials.setFusion(fusion: Fusion)
    External.setLibrary("Fusion", fusion)
end

PluginEssentials.setFusion(script:FindFirstAncestorWhichIsA("Plugin"):FindFirstChild("Fusion", true))

return PluginEssentials