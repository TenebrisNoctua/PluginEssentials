local External = require(script.Parent.Parent.Parent.External)
local Fusion = External.getLibrary("Fusion") :: Fusion

local StudioComponents = script.Parent.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

-- Scoped components
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getStateUtil = require(StudioComponentsUtil.getState)
local getModifierUtil = require(StudioComponentsUtil.getModifier)

local unwrap = require(StudioComponentsUtil.unwrap)
local constants = require(StudioComponentsUtil.constants)
local dropdownConstants = require(script.Parent.Constants)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local COMPONENT_ONLY_PROPERTIES = {
	"OnSelected",
	"Enabled",
	"Item",
}

type DropdownItemProperties = Types.DropdownItemProperties
type Scope = Types.Scope
type Fusion = Types.Fusion

return function(Scope: Scope): (props: DropdownItemProperties) -> TextButton
	local themeProvider = themeProviderComponent(Scope)
	local getModifier = getModifierUtil(Scope)
	local getState = getStateUtil(Scope)

	return function(props: DropdownItemProperties): TextButton
		local isEnabled = getState(props.Enabled, true)
		local isHovering = Scope:Value(false)

		local modifier = getModifier({
			Enabled = isEnabled,
			Hovering = isHovering,
		})

		local newDropdownItem = Scope:New "TextButton" {
			AutoButtonColor = false,
			Name = "DropdownItem",
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.EmulatorBar, modifier),
			BorderSizePixel = 0,
			Font = themeProvider:GetFont("Default"),
			Text = tostring(props.Item),
			TextSize = constants.TextSize,
			TextColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainText, modifier),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,

			[OnEvent "InputBegan"] = function(inputObject)
				if not unwrap(isEnabled) then
					return
				elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
					isHovering:set(true)
				end
			end,
			[OnEvent "InputEnded"] = function(inputObject)
				if not unwrap(isEnabled) then
					return
				elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
					isHovering:set(false)
				end
			end,
			[OnEvent "Activated"] = function()
				props.OnSelected(props.Item)
			end,

			[Children] = {
				Scope:New "UIPadding" {
					PaddingLeft = UDim.new(0, dropdownConstants.TextPaddingLeft - 1),
					PaddingRight = UDim.new(0, dropdownConstants.TextPaddingRight),
				},
				Scope:Computed(function(use, scope)
					if unwrap(constants.CurvedBoxes) then
						return scope:New "UICorner" {
							CornerRadius = constants.CornerRadius,
						}
					end
					return
				end),
			},
		}

		local hydrateProps = table.clone(props)
		for _, propertyIndex in pairs(COMPONENT_ONLY_PROPERTIES) do
			hydrateProps[propertyIndex] = nil
		end

		return Scope:Hydrate(newDropdownItem)(hydrateProps) :: TextButton
	end
end
