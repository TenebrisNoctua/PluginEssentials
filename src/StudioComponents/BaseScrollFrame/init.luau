-- Written by @boatbomber
-- Modified by @mvyasu
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local BackgroundComponent = require(StudioComponents.Background)
local ScrollBarComponent = require(script.ScrollBar)

local getStateUtil = require(StudioComponentsUtil.getState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)

local Children = Fusion.Children
local OnChange = Fusion.OnChange
local Out = Fusion.Out

local DEFAULT_SCROLL_BAR_THICKNESS = 18
local COMPONENT_ONLY_PROPERTIES = {
	"ScrollingEnabled",
	"VerticalScrollBarPosition",
	"VerticalScrollBarInset",
	"ScrollBarThickness",
	"ScrollBarBorderMode",
	"CanvasSize",
	"CornerRadius",
	Children,
}

type BaseScrollFrameProperties = Types.BaseScrollFrameProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: BaseScrollFrameProperties) -> Frame
	local getState = getStateUtil(Scope)
	local Background = BackgroundComponent(Scope)
	local ScrollBar = ScrollBarComponent(Scope)

	return function(props: BaseScrollFrameProperties): Frame
		local isEnabled = getState(props.ScrollingEnabled, true)
		local vertPos = getState(props.VerticalScrollBarPosition, Enum.VerticalScrollBarPosition.Right)
		local vertInset = getState(props.VerticalScrollBarInset, Enum.ScrollBarInset.ScrollBar)

		local barVisibility = {
			Vertical = Scope:Value(false),
			Horizontal = Scope:Value(false),
		}

		local scrollBarThickness = Scope:Value(unwrap(props.ScrollBarThickness) or DEFAULT_SCROLL_BAR_THICKNESS)

		local canvasPosition = Scope:Value(Vector2.zero)
		local absCanvasSize = Scope:Value(Vector2.zero)
		local windowSize = Scope:Value(Vector2.zero)
		local absSize = Scope:Value(Vector2.zero)

		local scrollFrame = Scope:Value(nil)
		local function computeShowBar()
			local scrollFrame = unwrap(scrollFrame)
			if scrollFrame == nil then
				barVisibility.Vertical:set(false)
				barVisibility.Horizontal:set(false)
				return
			end

			--apparently there's decimals included with these sizes
			--so we need to round the sizes to the nearest pixel so
			--the scrollbar padding/inset matches what is visually shown
			local windowSize = scrollFrame.AbsoluteWindowSize
			local canvasSize = scrollFrame.AbsoluteCanvasSize
			barVisibility.Vertical:set(math.round(windowSize.Y) < math.round(canvasSize.Y))
			barVisibility.Horizontal:set(math.round(windowSize.X) < math.round(canvasSize.X))
		end

		local zIndex = props.ZIndex or 1
		local childZIndex = Scope:Computed(function(use, scope)
			return unwrap(zIndex, use) + 10
		end)
		
		local containerFrame = Background {
			Name = "BaseScrollFrame",

			[Children] = {
				Scope:New "UICorner" {
					Name = "UICorner",
					CornerRadius = props.CornerRadius or UDim.new(),
				},

				ScrollBar {
					ZIndex = childZIndex,

					IsVertical = true,
					BorderMode = props.ScrollBarBorderMode,
					BarVisibility = barVisibility,
					VerticalScrollBarPosition = vertPos,
					CanvasPosition = canvasPosition,
					AbsoluteCanvasSize = absCanvasSize,
					AbsoluteSize = absSize,
					WindowSize = windowSize,
					ScrollBarThickness = scrollBarThickness,
				},
				ScrollBar {
					ZIndex = childZIndex,

					IsVertical = false,
					BorderMode = props.ScrollBarBorderMode,
					BarVisibility = barVisibility,
					VerticalScrollBarPosition = vertPos,
					CanvasPosition = canvasPosition,
					AbsoluteCanvasSize = absCanvasSize,
					AbsoluteSize = absSize,
					WindowSize = windowSize,
					ScrollBarThickness = scrollBarThickness,
				},
				scrollFrame:set(Scope:New "ScrollingFrame" {
					Name = "Canvas",
					Size = UDim2.fromScale(1, 1),
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					ScrollingEnabled = isEnabled,
					ScrollBarThickness = props.ScrollBarThickness or DEFAULT_SCROLL_BAR_THICKNESS,
					VerticalScrollBarPosition = vertPos,
					HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
					VerticalScrollBarInset = vertInset,
					ScrollBarImageTransparency = 1,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,

					ZIndex = zIndex,

					CanvasSize = props.CanvasSize,

					CanvasPosition = canvasPosition,
					[Out "CanvasPosition"] = canvasPosition,
					[Out "AbsoluteCanvasSize"] = absCanvasSize,
					[Out "AbsoluteWindowSize"] = windowSize,
					[Out "AbsoluteSize"] = absSize,
					[Out "ScrollBarThickness"] = scrollBarThickness,

					[OnChange "AbsoluteWindowSize"] = computeShowBar,
					[OnChange "AbsoluteCanvasSize"] = computeShowBar,

					[Children] = {
						props[Children],
					},
				}),
			},
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(containerFrame)(hydrateProps) :: Frame
	end
end
