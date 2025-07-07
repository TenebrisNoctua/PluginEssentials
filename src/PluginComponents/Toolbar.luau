local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local COMPONENT_ONLY_PROPERTIES = {
	"Name",
}

type ToolbarProperties = Types.ToolbarProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: ToolbarProperties) -> PluginToolbar
	return function(props: ToolbarProperties): PluginToolbar
		local newToolbar = Plugin:CreateToolbar(props.Name)

		local hydrateProps = table.clone(props)
		for _, propertyName in pairs(COMPONENT_ONLY_PROPERTIES) do
			hydrateProps[propertyName] = nil
		end

		return Scope:Hydrate(newToolbar)(hydrateProps) :: PluginToolbar
	end
end
