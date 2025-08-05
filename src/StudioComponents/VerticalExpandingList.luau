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
local BackgroundComponent = require(StudioComponents.Background)

local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)

local Children = Fusion.Children
local Out = Fusion.Out

local COMPONENT_ONLY_PROPERTIES = {
	"Padding",
	"AutomaticSize",
	"SizeX"
}

type VerticalExpandingListProperties = Types.VerticalExpandingListProperties
type Scope = Types.Scope
type Fusion = Types.Fusion

return function(Scope: Scope): (props: VerticalExpandingListProperties) -> Frame
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
						local sizeX = unwrap(props.SizeX, use) or 1

						if mode == Enum.AutomaticSize.Y then
							local s = unwrap(contentSize, use)
							if s then
								return UDim2.new(sizeX, 0, 0, s.Y)
							else
								return UDim2.new(sizeX, 0, 0, 0)
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
		)(hydrateProps) :: Frame
	end
end

