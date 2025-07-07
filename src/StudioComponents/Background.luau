local External = require(script.Parent.Parent.External)
local Fusion = External.getLibrary("Fusion") :: Fusion

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local stripProps = require(StudioComponentsUtil.stripProps)

local COMPONENT_ONLY_PROPERTIES = {
	"StudioStyleGuideColor",
	"StudioStyleGuideModifier",
}

type BackgroundProperties = Types.BackgroundProperties
type Scope = Types.Scope
type Fusion = Types.Fusion

return function(Scope: Scope): (props: BackgroundProperties) -> Frame
	return function(props: BackgroundProperties): Frame
		local themeProvider = require(StudioComponentsUtil.themeProvider)(Scope)
		
		return Scope:Hydrate(Scope:New "Frame" {
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0, 0),
			AnchorPoint = Vector2.new(0, 0),
			LayoutOrder = 0,
			ZIndex = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = themeProvider:GetColor(props.StudioStyleGuideColor or Enum.StudioStyleGuideColor.MainBackground, props.StudioStyleGuideModifier),
		})(stripProps(props, COMPONENT_ONLY_PROPERTIES)) :: Frame
	end
end
