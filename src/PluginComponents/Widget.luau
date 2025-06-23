local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local COMPONENT_ONLY_PROPERTIES = {
	"Id",
	"InitialDockTo",
	"InitialEnabled",
	"ForceInitialEnabled",
	"FloatingSize",
	"MinimumSize",
	"Plugin",
}

type WidgetProperties = Types.WidgetProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: WidgetProperties) -> DockWidgetPluginGui
	return function(props: WidgetProperties): DockWidgetPluginGui
		local initialDockState = if typeof(props.InitialDockTo) == "string" then Enum.InitialDockState[props.InitialDockTo] else props.InitialDockTo
		
		local newWidget = Plugin:CreateDockWidgetPluginGui(props.Id,
			DockWidgetPluginGuiInfo.new(
				initialDockState,
				props.InitialEnabled,
				props.ForceInitialEnabled,
				props.FloatingSize.X,
				props.FloatingSize.Y,
				props.MinimumSize.X,
				props.MinimumSize.Y
			)
		)

		for _, propertyName in pairs(COMPONENT_ONLY_PROPERTIES) do
			props[propertyName] = nil
		end

		props.Title = props.Name

		if typeof(props.Enabled) == "table" and props.Enabled.kind == "Value" then
			props.Enabled:set(newWidget.Enabled)
		end

		return Scope:Hydrate(newWidget)(props) :: DockWidgetPluginGui
	end
end
