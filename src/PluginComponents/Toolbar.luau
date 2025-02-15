local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local COMPONENT_ONLY_PROPERTIES = {
	"Name",
}

type ToolbarProperties = {
	Name: string,
	[any]: any,
}

return function(Scope: { [any]: any }): (props: ToolbarProperties) -> PluginToolbar
	return function(props: ToolbarProperties): PluginToolbar
		local newToolbar = Plugin:CreateToolbar(props.Name)

		local hydrateProps = table.clone(props)
		for _, propertyName in pairs(COMPONENT_ONLY_PROPERTIES) do
			hydrateProps[propertyName] = nil
		end

		return Scope:Hydrate(newToolbar)(hydrateProps)
	end
end
