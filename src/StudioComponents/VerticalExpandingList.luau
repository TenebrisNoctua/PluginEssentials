-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

-- Scoped components
local BoxBorderComponent = require(StudioComponents.BoxBorder)
local BackgroundComponent = require(StudioComponents.Background)

local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)

local Children = Fusion.Children
local Out = Fusion.Out

local COMPONENT_ONLY_PROPERTIES = {
	"Padding",
	"AutomaticSize",
}

type VerticalExpandingListProperties = {
	Padding: (UDim | types.StateObject<UDim>)?,
	[any]: any,
}

return function(Scope: { [any]: any }): (props: VerticalExpandingListProperties) -> Frame
	local BoxBorder = BoxBorderComponent(Scope)
	local Background = BackgroundComponent(Scope)

	local getMotionState = getMotionStateUtil(Scope)

	return function(props: VerticalExpandingListProperties): Frame
		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		local contentSize = Scope:Value(Vector2.new(0,0))

		return Scope:Hydrate(
			BoxBorder {
				[Children] = Background {
					ClipsDescendants = true,
					Size = getMotionState(Scope:Computed(function(use, scope)
						local mode = unwrap(props.AutomaticSize or Enum.AutomaticSize.Y, use) -- Custom autosize since engine sizing is unreliable
						if mode == Enum.AutomaticSize.Y then
							local s = unwrap(contentSize, use)
							if s then
								return UDim2.new(1,0,0,s.Y)
							else
								return UDim2.new(1,0,0,0)
							end
						else
							return props.Size or UDim2.new(1,0,0,0)
						end
					end), "Spring", 40),

					[Children] = Scope:New "UIListLayout" {
						SortOrder = Enum.SortOrder.LayoutOrder,
						FillDirection = Enum.FillDirection.Vertical,

						Padding = Scope:Computed(function(use, scope)
							return unwrap(props.Padding, use) or UDim.new(0, 10)
						end),

						[Out "AbsoluteContentSize"] = contentSize,
					}
				}
			}
		)(hydrateProps)
	end
end

