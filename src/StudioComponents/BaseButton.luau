-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local External = require(script.Parent.Parent.External)
local Fusion = External.getLibrary("Fusion") :: Fusion

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

-- Scoped components
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getModifierUtil = require(StudioComponentsUtil.getModifier)
local getStateUtil = require(StudioComponentsUtil.getState)
local BoxBorderComponent = require(StudioComponents.BoxBorder)

local stripProps = require(StudioComponentsUtil.stripProps)
local constants = require(StudioComponentsUtil.constants)
local unwrap = require(StudioComponentsUtil.unwrap)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local COMPONENT_ONLY_PROPERTIES = {
	"TextColorStyle",
	"BackgroundColorStyle",
	"BorderColorStyle",
	"Activated",
	"Enabled",
	"TextSize",
	"CornerRadius",
	"Timeout"
}

type BaseButtonProperties = Types.BaseButtonProperties
type Scope = Types.Scope
type Fusion = Types.Fusion

return function(Scope: Scope): (props: BaseButtonProperties) -> TextButton
	local getMotionState = getMotionStateUtil(Scope)
	local themeProvider = themeProviderComponent(Scope)
	local getModifier = getModifierUtil(Scope)
	local getState = getStateUtil(Scope)
	local BoxBorder = BoxBorderComponent(Scope)

	return function(props: BaseButtonProperties): TextButton
		local isEnabled = getState(props.Enabled, true)
		local isHovering = Scope:Value(false)
		local isPressed = Scope:Value(false)
		local timeout = getState(props.Timeout, 0)

		local modifier = getModifier({
			Enabled = isEnabled,
			Selected = props.Selected,
			Pressed = isPressed,
			Hovering = isHovering,
		})

		local newBaseButton = BoxBorder {
			CornerRadius = props.CornerRadius,
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
					local Activated = props.Activated
					if not Activated then return end 

					return function()
						if not unwrap(isEnabled) then return end 
						Activated()

						local timeout = unwrap(timeout)
						if typeof(timeout) ~= "number" then return end

						isPressed:set(false)
						isHovering:set(false)

						if isEnabled.kind ~= "Value" then return end
						
						isEnabled:set(false)
						task.wait(timeout)
						isEnabled:set(true)
					end
				end)(),
			}
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(newBaseButton)(hydrateProps) :: TextButton
	end
end

