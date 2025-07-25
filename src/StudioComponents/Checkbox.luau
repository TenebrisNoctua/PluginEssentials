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
local BoxBorderComponent = require(StudioComponents.BoxBorder)
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getModifierUtil = require(StudioComponentsUtil.getModifier)
local getStateUtil = require(StudioComponentsUtil.getState)

local constants = require(StudioComponentsUtil.constants)
local unwrap = require(StudioComponentsUtil.unwrap)

local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

local CheckboxOn_Dark = "rbxasset://studio_svg_textures/Shared/Utility/Dark/Standard/CheckboxOn@2x.png"
local CheckboxOn_Light = "rbxasset://studio_svg_textures/Shared/Utility/Light/Standard/CheckboxOn@2x.png"

local CheckboxOff_Dark = "rbxasset://studio_svg_textures/Shared/Utility/Dark/Standard/CheckboxOff@2x.png"
local CheckboxOff_Light = "rbxasset://studio_svg_textures/Shared/Utility/Light/Standard/CheckboxOff@2x.png"

local COMPONENT_ONLY_PROPERTIES = {
	"OnChange",
	"Alignment",
	"Enabled",
	"Value",
	"Text",
}

type CheckboxProperties = Types.CheckboxProperties
type Scope = Types.Scope
type Fusion = Types.Fusion

return function(Scope: Scope): (props: CheckboxProperties) -> Frame
	local BoxBorder = BoxBorderComponent(Scope)
	local getMotionState = getMotionStateUtil(Scope)
	local themeProvider = themeProviderComponent(Scope)
	local getModifier = getModifierUtil(Scope)
	local getState = getStateUtil(Scope)

	return function(props: CheckboxProperties): Frame
		local currentValue = getState(props.Value, true)
		local isEnabled = getState(props.Enabled, true)
		local isHovering = Scope:Value(false)

		local isIndeterminate = Scope:Computed(function(use, scope)
			return unwrap(currentValue, use) == nil
		end)

		local mainModifier = getModifier({
			Enabled = isEnabled,
			Hovering = isHovering,
		})

		local backModifier = getModifier({
			Enabled = isEnabled,
			Selected = currentValue,
		})

		local checkFieldImage = Scope:Computed(function(use, innerScope)
			local IsDark = use(themeProvider.IsDark)
			local IsIndeterminate = use(isIndeterminate)
			
			if IsDark and IsIndeterminate then
				return CheckboxOff_Dark
			elseif IsDark and not IsIndeterminate then
				return CheckboxOn_Dark
			elseif not IsDark and IsIndeterminate then
				return CheckboxOff_Light
			else
				return CheckboxOn_Light
			end
		end)

		local boxHorizontalScale = Scope:Computed(function(use, scope)
			local currentAlignment = unwrap(props.Alignment, use) or Enum.HorizontalAlignment.Left
			return if currentAlignment == Enum.HorizontalAlignment.Right then 1 else 0
		end)

		local textHorizontalScale = Scope:Computed(function(use, scope)
			return if unwrap(boxHorizontalScale, use) == 1 then 0 else 1
		end)

		local newCheckboxFrame = Scope:New "Frame" {
			Name = "Checkbox",
			Size = UDim2.new(1, 0, 0, 15),
			BackgroundTransparency = 1,

			[Children] = {
				Scope:New "TextButton" {
					Text = "",
					Active = true,
					Name = "CheckBoxInput",
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,

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
						if unwrap(isEnabled) then
							local newValue = not unwrap(currentValue)
							currentValue:set(newValue)
							if props.OnChange then
								props.OnChange(newValue)
							end
						end
					end,
				},
				BoxBorder {
					Color = getMotionState(themeProvider:GetColor(Enum.StudioStyleGuideColor.CheckedFieldBorder, mainModifier), "Spring", 40),
					CornerRadius = UDim.new(0, 4),
					
					[Children] = Scope:New "Frame" {
						Name = "Box",
						AnchorPoint = Scope:Computed(function(use, scope)
							return Vector2.new(unwrap(boxHorizontalScale, use), 0)
						end),
						Position = Scope:Computed(function(use, scope)
							return UDim2.fromScale(unwrap(boxHorizontalScale, use), 0)
						end),
						BackgroundColor3 = getMotionState(themeProvider:GetColor(Enum.StudioStyleGuideColor.CheckedFieldBackground, backModifier), "Spring", 40),
						Size = UDim2.fromOffset(15, 15),

						[Children] = Scope:New "ImageLabel" {
							AnchorPoint = Vector2.new(.5, .5),
							Visible = Scope:Computed(function(use, scope)
								return unwrap(currentValue, use) ~= false
							end),
							Name = "Indicator",
							BackgroundTransparency = 1,
							Size = UDim2.fromOffset(15, 15),
							Position = UDim2.fromScale(.5, .5),
							Image = checkFieldImage
						}
					}
				},
				Scope:Computed(function(use, scope)
					if props.Text then
						return Scope:New "TextLabel" {
							BackgroundTransparency = 1,
							AnchorPoint = Scope:Computed(function(use, scope)
								return Vector2.new(unwrap(textHorizontalScale, use), 0)
							end),
							Position = Scope:Computed(function(use, scope)
								return UDim2.fromScale(unwrap(textHorizontalScale, use), 0)
							end),
							Size = UDim2.new(1, -20, 1, 0),
							TextXAlignment = Scope:Computed(function(use, scope)
								return if unwrap(textHorizontalScale, use) == 1 then Enum.TextXAlignment.Left else Enum.TextXAlignment.Right
							end),
							TextTruncate = Enum.TextTruncate.AtEnd,
							Text = props.Text,
							Font = themeProvider:GetFont("Default"),
							TextSize = constants.TextSize,
							TextColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainText, mainModifier),
						}
					end
					return
				end)
			}
		}

		local hydrateProps = table.clone(props)
		for _, propertyIndex in pairs(COMPONENT_ONLY_PROPERTIES) do
			hydrateProps[propertyIndex] = nil
		end

		return Scope:Hydrate(newCheckboxFrame)(hydrateProps) :: Frame
	end
end