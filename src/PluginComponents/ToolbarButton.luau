local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local PluginComponents = script.Parent
local StudioComponents = PluginComponents.Parent:FindFirstChild("StudioComponents")
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = PluginComponents.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)

local Observer = Fusion.Observer

local COMPONENT_ONLY_PROPERTIES = {
	"ToolTip",
	"Name",
	"Image",
	"Toolbar",
	"Active",
}

type ToolbarButtonProperties = Types.ToolbarButtonProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: ToolbarButtonProperties) -> PluginToolbarButton
	return function(props: ToolbarButtonProperties): PluginToolbarButton
		local toolbarButton = props.Toolbar:CreateButton(props.Name, props.ToolTip, props.Image)

		if props.Active ~= nil then
			toolbarButton:SetActive(unwrap(props.Active))
			if unwrap(props.Active) ~= props.Active then
				Plugin.Unloading:Connect(Observer(props.Active):onChange(function()
					toolbarButton:SetActive(unwrap(props.Active))
				end))
			end
		end

		local hydrateProps = table.clone(props)
		for _, propertyName in pairs(COMPONENT_ONLY_PROPERTIES) do
			hydrateProps[propertyName] = nil
		end

		return Scope:Hydrate(toolbarButton)(hydrateProps) :: PluginToolbarButton
	end
end
