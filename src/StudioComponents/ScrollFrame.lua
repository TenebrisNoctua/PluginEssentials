-- Written by @boatbomber
-- Modified by @mvyasu
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

-- Scoped components
local BaseScrollFrameComponent = require(StudioComponents.BaseScrollFrame)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)

local Children = Fusion.Children
local Out = Fusion.Out

local COMPONENT_ONLY_PROPERTIES = {
	"CanvasScaleConstraint",
	"UIPadding",
	"UILayout",
}

-- if you're using this component with the default sizes of the other components
-- you'll need to have CanvasScaleConstraint set to Enum.ScrollingDirection.X
export type ScrollFrameProperties = BaseScrollFrameComponent.BaseScrollFrameProperties & {
	CanvasScaleConstraint: types.CanBeState<Enum.ScrollingDirection?>?,
	UIPadding: UIPadding?,
	UILayout: UILayout?,
}

return function(Scope: { [any]: any }): (props: ScrollFrameProperties) -> Frame
	local BaseScrollFrame = BaseScrollFrameComponent(Scope)

	return function(props: ScrollFrameProperties): Frame
		local contentSize = Scope:Value(Vector2.zero)
		local contentPadding = {
			Bottom = Scope:Value(UDim.new()),
			Top = Scope:Value(UDim.new()),
			Left = Scope:Value(UDim.new()),
			Right = Scope:Value(UDim.new()),
		}

		if props.UILayout then
			Scope:Hydrate(props.UILayout)({
				[Out "AbsoluteContentSize"] = contentSize,
			})
		end

		if props.UIPadding then
			Scope:Hydrate(props.UIPadding)({
				[Out "PaddingBottom"] = contentPadding.Bottom,
				[Out "PaddingTop"] = contentPadding.Top,
				[Out "PaddingLeft"] = contentPadding.Left,
				[Out "PaddingRight"] = contentPadding.Right,
			})
		end

		local scrollFrameProps = table.clone(props)
		scrollFrameProps[Children] = {props.UIPadding, props.UILayout, props[Children]}

		for index, value in pairs {
			CanvasSize = Scope:Computed(function(use, scope)
				local contentSize = unwrap(contentSize, use) or Vector2.zero
				local currentPadding = {}

				for index, value in pairs(contentPadding) do
					currentPadding[index] = unwrap(value, use) or UDim.new()
				end

				local scaleConstraint = unwrap(props.CanvasScaleConstraint, use)
				local isXConstrained = if scaleConstraint then table.find({"XY", "X"}, scaleConstraint.Name) ~= nil else false
				local isYConstrained = if scaleConstraint then table.find({"XY", "Y"}, scaleConstraint.Name) ~= nil else false
				
				return UDim2.new(
					if isXConstrained then 0 else currentPadding.Left.Scale + currentPadding.Right.Scale, 
					if isXConstrained then 0 else contentSize.X + currentPadding.Left.Offset + currentPadding.Right.Offset,
					if isYConstrained then 0 else currentPadding.Top.Scale + currentPadding.Bottom.Scale, 
					if isYConstrained then 0 else contentSize.Y + currentPadding.Top.Offset + currentPadding.Bottom.Offset
				)
			end),
		} do
			if scrollFrameProps[index] == nil then
				scrollFrameProps[index] = value
			end
		end

		return BaseScrollFrame(stripProps(scrollFrameProps, COMPONENT_ONLY_PROPERTIES))
	end
end

