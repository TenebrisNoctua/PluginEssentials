-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local StudioComponents = script.Parent
local ComponentTypes = StudioComponents.Parent.ComponentTypes

local Types = require(ComponentTypes.Types)

-- Scoped components
local ButtonComponent = require(StudioComponents.Button)

local baseProperties = {
	TextColorStyle = Enum.StudioStyleGuideColor.DialogMainButtonText,
	BackgroundColorStyle = Enum.StudioStyleGuideColor.DialogMainButton,
	BorderColorStyle = Enum.StudioStyleGuideColor.ButtonBorder,
	Name = "MainButton",
}

type BaseButtonProperties = Types.BaseButtonProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: BaseButtonProperties) -> TextButton
	local Button = ButtonComponent(Scope)

	return function(props: BaseButtonProperties): TextButton
		for index, value in pairs(baseProperties) do
			if props[index] == nil then
				props[index] = value
			end
		end
		return Button(props)
	end
end
