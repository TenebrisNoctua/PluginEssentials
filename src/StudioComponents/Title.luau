-- Written by @boatbomber
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

-- Scoped components
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getStateUtil = require(StudioComponentsUtil.getState)

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

	return function(props: LabelProperties): TextLabel
		local isEnabled = getState(props.Enabled, true)
		local textSize = props.TextSize or constants.TextSize * 1.3

		local newLabel = Scope:New "TextLabel" {
			Name = "Label",
			Position = UDim2.fromScale(0, 0),
			AnchorPoint = Vector2.new(0, 0),
			Text = "Label",
			Font = themeProvider:GetFont("Bold"),
			TextSize = textSize,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			BorderMode = Enum.BorderMode.Inset,

			Size = Scope:Computed(function(use, scope)
				return UDim2.new(1, 0, 0, unwrap(textSize, use))
			end),

			TextColor3 = props.TextColor3 or themeProvider:GetColor(props.TextColorStyle or Enum.StudioStyleGuideColor.MainText, Scope:Computed(function(use, scope)
				if not unwrap(isEnabled, use) then
					return Enum.StudioStyleGuideModifier.Disabled
				end
				return Enum.StudioStyleGuideModifier.Default
			end)),
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(newLabel)(hydrateProps) :: TextLabel
	end
end

