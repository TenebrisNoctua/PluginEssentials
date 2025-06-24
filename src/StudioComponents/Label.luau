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
local getModifierUtil = require(StudioComponentsUtil.getModifier)
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getStateUtil = require(StudioComponentsUtil.getState)
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local constants = require(StudioComponentsUtil.constants)

local COMPONENT_ONLY_PROPERTIES = {
	"Enabled",
	"TextColorStyle",
	"TextColor3",
	"TextSize",
}

type LabelProperties = Types.LabelProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: LabelProperties) -> TextLabel
	local themeProvider = themeProviderComponent(Scope)
	local getState = getStateUtil(Scope)
	local getModifier = getModifierUtil(Scope)
	local getMotionState = getMotionStateUtil(Scope)
	
	return function(props: LabelProperties): TextLabel
		local isEnabled = getState(props.Enabled, true)
		local textSize = props.TextSize or constants.TextSize

		local mainModifier = getModifier({
			Enabled = isEnabled
		})

		local newLabel = Scope:New "TextLabel" {
			Name = "Label",
			Position = UDim2.fromScale(0, 0),
			AnchorPoint = Vector2.new(0, 0),
			Text = "Label",
			TextSize = textSize,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderMode = Enum.BorderMode.Inset,

			Font = themeProvider:GetFont("Default"),
			TextColor3 = props.TextColor3 or getMotionState(themeProvider:GetColor(props.TextColorStyle or Enum.StudioStyleGuideColor.MainText, mainModifier), "Spring", 40),

			Size = Scope:Computed(function(use, scope)
				return UDim2.new(1, 0, 0, unwrap(textSize, use))
			end),
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(newLabel)(hydrateProps) :: TextLabel
	end
end


