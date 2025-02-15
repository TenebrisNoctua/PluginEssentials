-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

-- Scoped components
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getModifierUtil = require(StudioComponentsUtil.getModifier)
local getStateUtil = require(StudioComponentsUtil.getState)
local BoxBorderComponent = require(StudioComponents.BoxBorder)

local stripProps = require(StudioComponentsUtil.stripProps)
local constants = require(StudioComponentsUtil.constants)
local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local COMPONENT_ONLY_PROPERTIES = {
	"TextColorStyle",
	"BackgroundColorStyle",
	"BorderColorStyle",
	"Activated",
	"Enabled",
	"TextSize"
}

type styleGuideColorInput = (Enum.StudioStyleGuideColor | types.StateObject<Enum.StudioStyleGuideColor>)?

export type BaseButtonProperties = {
	Activated: (() -> nil)?,
	Enabled: (boolean | types.StateObject<boolean>)?,
	TextColorStyle: styleGuideColorInput,
	BackgroundColorStyle: styleGuideColorInput,
	BorderColorStyle: styleGuideColorInput,
	TextSize: number,
	[any]: any,
}

return function(Scope: { [any]: any }): (props: BaseButtonProperties) -> TextButton
	local getMotionState = getMotionStateUtil(Scope)
	local themeProvider = themeProviderComponent(Scope)
	local getModifier = getModifierUtil(Scope)
	local getState = getStateUtil(Scope)
	local BoxBorder = BoxBorderComponent(Scope)

	return function(props: BaseButtonProperties): TextButton
		local isEnabled = getState(props.Enabled, true)
		local isHovering = Scope:Value(false)
		local isPressed = Scope:Value(false)

		local modifier = getModifier({
			Enabled = isEnabled,
			Selected = props.Selected,
			Pressed = isPressed,
			Hovering = isHovering,
		})

		local newBaseButton = BoxBorder {
			Color = getMotionState(themeProvider:GetColor(props.BorderColorStyle or Enum.StudioStyleGuideColor.CheckedFieldBorder, modifier), "Spring", 40),

			[Children] = Scope:New "TextButton" {
				Name = "BaseButton",
				Size = UDim2.fromScale(1, 1),
				Text = "Button",
				Font = themeProvider:GetFont("Default"),
				TextSize = props.TextSize or constants.TextSize,
				TextColor3 = getMotionState(themeProvider:GetColor(props.TextColorStyle or Enum.StudioStyleGuideColor.ButtonText, modifier), "Spring", 40),
				BackgroundColor3 = getMotionState(themeProvider:GetColor(props.BackgroundColorStyle or Enum.StudioStyleGuideColor.Button, modifier), "Spring", 40),
				AutoButtonColor = false,

				[OnEvent "InputBegan"] = function(inputObject)
					if not unwrap(isEnabled) then
						return
					elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
						isHovering:set(true)
					elseif inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
						isPressed:set(true)
					end
				end,
				[OnEvent "InputEnded"] = function(inputObject)
					if not unwrap(isEnabled) then
						return
					elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
						isHovering:set(false)
					elseif inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
						isPressed:set(false)
					end
				end,
				[OnEvent "Activated"] = (function()
					if props.Activated then
						return function()
							if unwrap(isEnabled) then
								props.Activated()
							end
						end
					end
					return
				end)(),
			}
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(newBaseButton)(hydrateProps)
	end
end

