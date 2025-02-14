-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

-- Scoped components
local ButtonComponent = require(StudioComponents.Button)

local baseProperties = {
	TextColorStyle = Enum.StudioStyleGuideColor.DialogMainButtonText,
	BackgroundColorStyle = Enum.StudioStyleGuideColor.DialogMainButton,
	BorderColorStyle = Enum.StudioStyleGuideColor.ButtonBorder,
	Name = "MainButton",
}

return function(Scope: { [any]: any }): (props: ButtonComponent.ButtonProperties) -> TextButton
	local Button = ButtonComponent(Scope)

	return function(props: ButtonComponent.ButtonProperties): TextButton
		for index, value in pairs(baseProperties) do
			if props[index] == nil then
				props[index] = value
			end
		end
		return Button(props)
	end
end
