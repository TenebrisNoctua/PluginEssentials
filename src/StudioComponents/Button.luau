-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local BaseButtonComponent = require(StudioComponents.BaseButton)

type ButtonProperties = Types.BaseButtonProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: ButtonProperties) -> TextButton
	local BaseButton = BaseButtonComponent(Scope)

	return function(props: ButtonProperties): TextButton
		if not props.Name then
			props.Name = "Button"
		end

		local newButton = BaseButton(props)
		return newButton
	end
end
