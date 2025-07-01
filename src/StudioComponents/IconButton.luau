local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

-- Scoped components
local BoxBorderComponent = require(StudioComponents.BoxBorder)
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getStateUtil = require(StudioComponentsUtil.getState)
local getModifierUtil = require(StudioComponentsUtil.getModifier)
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local COMPONENT_ONLY_PROPERTIES = {
	"ImageColorStyle",
	"BackgroundColorStyle",
	"BorderColorStyle",
	"Activated",
	"Enabled",
	"Icon",
	"IconColor3"
}

type IconButtonProperties = Types.IconButtonProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: IconButtonProperties) -> TextButton
	local BoxBorder = BoxBorderComponent(Scope)
	local themeProvider = themeProviderComponent(Scope)
	local getState = getStateUtil(Scope)
	local getModifier = getModifierUtil(Scope)
	local getMotionState = getMotionStateUtil(Scope)

	return function(props: IconButtonProperties): TextButton
		local isEnabled = getState(props.Enabled, true)
		local isHovering = Scope:Value(false)
		local isPressed = Scope:Value(false)

		local modifier = getModifier({
			Enabled = props.Enabled,
			Selected = props.Selected,
			Hovering = isHovering,
			Pressed = isPressed,
		})

		local newBaseButton = BoxBorder {
			Color = getMotionState(themeProvider:GetColor(props.BorderColorStyle or Enum.StudioStyleGuideColor.CheckedFieldBorder, modifier), "Spring", 40),
			
			[Children] = Scope:New "TextButton" {
				Name = "IconButton",
				Size = UDim2.fromScale(1, 1),
				Text = "",
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
					if Activated then
						return function()
							if unwrap(isEnabled) then
								isHovering:set(false)
								isPressed:set(false)

								Activated() 
							end
						end
					end
					return nil
				end)(),

				[Children] = {
					Scope:New "ImageLabel" {
						Name = "Icon",
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(0.8, 0.8),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						ScaleType = Enum.ScaleType.Fit,
						ImageColor3 = props.IconColor3 or getMotionState(themeProvider:GetColor(props.ImageColorStyle or Enum.StudioStyleGuideColor.ButtonText, props.ImageColorModifier or Enum.StudioStyleGuideModifier.Selected), "Spring", 40),
						Image = props.Icon,
						ZIndex = props.ZIndex or 1
					},
				},
			}
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(newBaseButton)(hydrateProps) :: TextButton
	end
end