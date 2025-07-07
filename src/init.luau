-- Written by @TenebrisNoctua
-- Entry point for the PluginEssentials library.

--// Variables

local Types = require(script.ComponentTypes.Fusion)
local External = require(script.External)

local PluginEssentials = {
    PluginComponents = script.PluginComponents,
    StudioComponents = script.StudioComponents
}

local FoundFusion = script:FindFirstAncestorWhichIsA("Plugin"):FindFirstChild("Fusion", true)

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

-- If we find a Fusion library that already exists within the Plugin, we use that by default.
if FoundFusion then
    local IsValidFusion = require(FoundFusion)
    if IsValidFusion and IsValidFusion.version and IsValidFusion.version.minor == 3 then
        PluginEssentials.setFusion(IsValidFusion)
    end
end

return PluginEssentials