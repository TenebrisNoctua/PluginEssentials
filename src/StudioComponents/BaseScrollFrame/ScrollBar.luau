-- Writen by @boatbomber
-- Modified by @mvyasu
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

-- Scoped components
local ScrollArrowComponent = require(script.Parent.ScrollArrow)
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)

local getModifierUtil = require(StudioComponentsUtil.getModifier)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local COMPONENT_ONLY_PROPERTIES = {
	"VerticalScrollBarPosition",
	"ScrollBarThickness",
	"CanvasPosition",
	"AbsoluteCanvasSize",
	"BarVisibility",
	"AbsoluteSize",
	"WindowSize",
	"IsVertical",
	"BorderMode",
}

type ScrollBarProperties = Types.ScrollBarProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: ScrollBarProperties) -> ImageButton
	local themeProvider = themeProviderComponent(Scope)
	local ScrollArrow = ScrollArrowComponent(Scope)
	local getModifier = getModifierUtil(Scope)

	return function(props: ScrollBarProperties): ImageButton
		local scrollBarThickness = props.ScrollBarThickness
		local absoluteCanvasSize = props.AbsoluteCanvasSize
		local canvasPosition = props.CanvasPosition
		local windowSize = props.WindowSize
	
		local isHoveringHandle = Scope:Value(false)
		local isPressingHandle = Scope:Value(false)
	
		local frameBorderMode = props.BorderMode or Enum.BorderMode.Inset
		local childborderMode = Enum.BorderMode.Outline
		local borderSize = 1
	
		local scrollBarOffset = Scope:Computed(function(use, scope)
			local allVisible = true
			for _, visibleState in pairs(props.BarVisibility) do
				if not unwrap(visibleState, use) then
					allVisible = false
					break
				end
			end

			local isInsetBorder = unwrap(frameBorderMode, use) == Enum.BorderMode.Inset
			return if allVisible then -(unwrap(scrollBarThickness, use) or 0) + (if isInsetBorder then borderSize else 0) else 0
		end)

		local scrollBarHandleOffset = Scope:Computed(function(use, scope)
			local offsetSize = unwrap(scrollBarOffset, use)
			local size = (unwrap(props.AbsoluteSize, use) or Vector2.zero) + (Vector2.one * (unwrap(scrollBarOffset, use) or Vector2.zero))
			local scrollbarThickness = unwrap(scrollBarThickness, use) or 0
			local isInsetBorder = unwrap(frameBorderMode, use) == Enum.BorderMode.Inset
			return (2 * scrollbarThickness + (if isInsetBorder then -borderSize * 2 else 0)) / (if props.IsVertical then size.Y else size.X)
		end)
	
		return Scope:Hydrate(Scope:New "Frame" {
			Name = (if props.IsVertical then "Vertical" else "Horizontal").."ScrollBar",
			BorderMode = frameBorderMode,
			BorderSizePixel = borderSize,
		
			Visible = Scope:Computed(function(use, scope)
				return unwrap(if props.IsVertical then props.BarVisibility.Vertical else props.BarVisibility.Horizontal, use)
			end),
		
			BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.ScrollBarBackground),
			BorderColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.Border),
		
			AnchorPoint = if props.IsVertical then Scope:Computed(function(use, scope)
				local vert = unwrap(props.VerticalScrollBarPosition, use)
				if vert == Enum.VerticalScrollBarPosition.Right then
					return Vector2.new(1, 0)
					else
					return Vector2.new(0, 0)
				end
			end) else Vector2.new(0, 1),
		
			Position = if props.IsVertical then Scope:Computed(function(use, scope)
				local vert = unwrap(props.VerticalScrollBarPosition, use)
				if vert == Enum.VerticalScrollBarPosition.Right then
					return UDim2.fromScale(1, 0)
				else
					return UDim2.fromScale(0, 0)
				end
			end) else Scope:Computed(function(use, scope)
				local vert = unwrap(props.VerticalScrollBarPosition, use)
				return UDim2.fromScale(if vert == Enum.VerticalScrollBarPosition.Left then 1 else 0, 1)
			end),
		
			Size = if props.IsVertical then Scope:Computed(function(use, scope)
				return UDim2.new(0, unwrap(scrollBarThickness, use), 1, unwrap(scrollBarOffset, use))
			end) else Scope:Computed(function(use, scope)
				local scrollBarThickness = unwrap(scrollBarThickness, use)
				return  UDim2.new(1, unwrap(scrollBarOffset, use), 0, scrollBarThickness)
			end),

			[Children] = {
				(function()
					local scrollArrows = {}
					for _, direction in pairs(if props.IsVertical then {"Up", "Down"} else {"Left", "Right"}) do
						table.insert(scrollArrows, ScrollArrow {
							Name = direction.."Arrow",
							BorderMode = childborderMode,
							BorderSizePixel = borderSize,
							ZIndex = props.ZIndex,
							Direction = direction,
							Size = UDim2.fromScale(1, 1),
							SizeConstraint = if props.IsVertical then Enum.SizeConstraint.RelativeXX else Enum.SizeConstraint.RelativeYY,
							Activated = (function()
								if direction == "Up" or direction == "Left" then
									return function()
										local p = unwrap(canvasPosition) or Vector2.zero
										canvasPosition:set(Vector2.new(
											if props.IsVertical then p.X else math.clamp(p.X-25, 0, math.huge),
											if props.IsVertical then math.clamp(p.Y-25, 0, math.huge) else p.Y
										))
									end
								elseif direction == "Down" or direction == "Right" then
									return function()
										local p = unwrap(canvasPosition) or Vector2.zero
										local window = unwrap(windowSize) or Vector2.zero
										local content = unwrap(absoluteCanvasSize) or Vector2.zero
										canvasPosition:set(Vector2.new(
											if props.IsVertical then p.X else math.clamp(p.X+25, 0, content.X-window.X),
											if props.IsVertical then math.clamp(p.Y+25, 0, content.Y-window.Y) else p.Y
										))
									end
								end
								return
							end)(),
						})
					end
					return scrollArrows
				end)(),
			
			
				Scope:New "Frame" {
					Name = "Handle",
					ZIndex = props.ZIndex,
					BorderMode = childborderMode,
					BorderSizePixel = borderSize,
					
					BorderColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.Border),
					
					BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.ScrollBar, getModifier({
						Enabled = true,
						Pressed = Scope:Computed(function(use, scope)
							return unwrap(isPressingHandle, use) or unwrap(isHoveringHandle, use)
						end),
					})),
			
					Size = Scope:Computed(function(use, scope)
						local window = unwrap(windowSize, use) or Vector2.zero
						local content = unwrap(absoluteCanvasSize, use) or Vector2.zero
						local relativeOffset = unwrap(scrollBarHandleOffset, use)
						
						return UDim2.fromScale(
							if props.IsVertical then 1 else (window.X/content.X) * (1-relativeOffset),
							if props.IsVertical then (window.Y/content.Y) * (1-relativeOffset) else 1
						)
					end),
			
					Position = Scope:Computed(function(use, scope)
						local content = unwrap(absoluteCanvasSize, use) or Vector2.zero
						local pos = unwrap(canvasPosition, use) or Vector2.zero
						local scrollBarThickness = unwrap(scrollBarThickness, use) or 0
				
						local relativeOffset = unwrap(scrollBarHandleOffset, use) or 0
						local relativePos = if props.IsVertical then (pos.Y/content.Y) else (pos.X/content.X)
				
						if props.IsVertical then
							return UDim2.new(
								0, 0,
							relativePos * (1-relativeOffset), unwrap(scrollBarThickness, use) - borderSize
							)
						else
							return UDim2.new(
								relativePos * (1-relativeOffset), unwrap(scrollBarThickness, use) - borderSize,
								0, 0
							)
						end
					end),
			
					[OnEvent "InputBegan"] = function(inputObject)
						if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							isHoveringHandle:set(true)
						elseif inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
							isPressingHandle:set(true)
						end
					end,

					[OnEvent "InputEnded"] = function(inputObject)
						if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							isHoveringHandle:set(false)
						elseif inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
							isPressingHandle:set(false)
						end
					end,
				},
			}
		})(stripProps(props, COMPONENT_ONLY_PROPERTIES)) :: ImageButton
	end
end

