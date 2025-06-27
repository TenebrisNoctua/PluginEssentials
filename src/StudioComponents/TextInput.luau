-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

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
local constants = require(StudioComponentsUtil.constants)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local OnChange = Fusion.OnChange
local Out = Fusion.Out

local PLACEHOLDER_TEXT_COLOR = Color3.fromRGB(102, 102, 102)

local COMPONENT_ONLY_PROPERTIES = {
	"Enabled",
	"ClearTextOnFocus"
}

type TextInputProperties = Types.TextInputProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: TextInputProperties) -> TextBox
	local BoxBorder = BoxBorderComponent(Scope)
	local themeProvider = themeProviderComponent(Scope)
	local getModifier = getModifierUtil(Scope)
	local getState = getStateUtil(Scope)
	local getMotionState = getMotionStateUtil(Scope)

	return function(props: TextInputProperties): TextBox
		local isEnabled = getState(props.Enabled, true)
		local isHovering = Scope:Value(false)
		local isFocused = Scope:Value(false)

		local mainModifier = getModifier({
			Enabled = isEnabled,
		})

		local borderModifier = getModifier({
			Enabled = isEnabled,
			Selected = isFocused,
			Hovering = isHovering,
		})

		local currentTextBounds = Scope:Value(Vector2.zero)
		local absoluteTextBoxSize = Scope:Value(Vector2.zero)

		local newTextBox = BoxBorder {
			Color = getMotionState(themeProvider:GetColor(Enum.StudioStyleGuideColor.InputFieldBorder, borderModifier), "Spring", 40),

			[Children] = Scope:New "TextBox" {
				Name = "TextInput",
				Size = UDim2.new(1, 0, 0, 25),
				Text = "",
				TextSize = constants.TextSize,
				PlaceholderColor3 = PLACEHOLDER_TEXT_COLOR,
				ClipsDescendants = true,

				Font = themeProvider:GetFont("Default"),
				BackgroundColor3 = getMotionState(themeProvider:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, mainModifier), "Spring", 40),
				BackgroundTransparency = props.BackgroundTransparency or 0,
				
				TextColor3 = props.TextColor3 or getMotionState(themeProvider:GetColor(Enum.StudioStyleGuideColor.MainText, mainModifier), "Spring", 40),
				TextEditable = isEnabled,

				TextXAlignment = Scope:Computed(function(use, scope)
					local bounds = (unwrap(currentTextBounds, use) or Vector2.zero).X + 5 -- because of padding
					local pixels = (unwrap(absoluteTextBoxSize, use) or Vector2.zero).X
					return if bounds >= pixels then Enum.TextXAlignment.Right else Enum.TextXAlignment.Left
				end),

				ClearTextOnFocus = Scope:Computed(function(use, scope)
					local clearTextOnFocus = (unwrap(props.ClearTextOnFocus, use) or false)
					local isEnabled = unwrap(isEnabled, use)
					return clearTextOnFocus and isEnabled
				end),

				[Out "TextBounds"] = currentTextBounds,
				[Out "AbsoluteSize"] = absoluteTextBoxSize,

				[OnEvent "Focused"] = function() isFocused:set(true) end,
				[OnEvent "FocusLost"] = function() isFocused:set(false) end,

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

				[OnChange "Text"] = props.OnChange,

				[Children] = Scope:New "UIPadding" {
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
				},
			}
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(newTextBox)(hydrateProps) :: TextBox
	end
end

