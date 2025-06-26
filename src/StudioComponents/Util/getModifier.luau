local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local ComponentTypes = script.Parent.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local unwrap = require(script.Parent.unwrap)

type ModifierInput = Types.ModifierInput

type Computed<T> = Types.Computed<T>
type Scope = Types.Scope
type Use = Types.Use

return function(Scope: Scope): (modifierInput: ModifierInput) -> Computed<any>
	return function(modifierInput: ModifierInput): Computed<any>
		local isEnabled = modifierInput.Enabled
		local isHovering = modifierInput.Hovering
		local isSelected = modifierInput.Selected
		local isPressed = modifierInput.Pressed

		return Scope:Computed(function(use: Use, scope: Scope)
			local isDisabled = if isEnabled ~= nil then not unwrap(isEnabled, use) else false
			local isHovering = unwrap(isHovering, use)
			local isSelected = unwrap(isSelected, use)
			local isPressed = unwrap(isPressed, use)

			if isDisabled then
				return Enum.StudioStyleGuideModifier.Disabled
			elseif isSelected then
				return Enum.StudioStyleGuideModifier.Selected
			elseif isPressed then
				return Enum.StudioStyleGuideModifier.Pressed
			elseif isHovering then
				return Enum.StudioStyleGuideModifier.Hover
			end

			return unwrap(modifierInput.Otherwise, use) or Enum.StudioStyleGuideModifier.Default
		end)
	end
end