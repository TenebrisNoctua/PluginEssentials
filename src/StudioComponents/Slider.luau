-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

-- Scoped components
local BoxBorderComponent = require(StudioComponents.BoxBorder)
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getDragInputUtil = require(StudioComponentsUtil.getDragInput)
local getStateUtil = require(StudioComponentsUtil.getState)
local getModifierUtil = require(StudioComponentsUtil.getModifier)
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out

local COMPONENT_ONLY_PROPERTIES = {
	"ZIndex",
	"HandleSize",
	"OnChange",
	"Value",
	"Min",
	"Max",
	"Step",
	"Enabled",
}

type numberInput = types.CanBeState<number>?

type SliderProperties = {
	HandleSize: types.CanBeState<UDim2>?,
	Enabled: types.CanBeState<boolean>?,
	OnChange: ((newValue: number) -> nil)?,
	Value: types.CanBeState<number>?,
	Min: numberInput,
	Max: numberInput,
	Step: numberInput,
	[any]: any,
}

return function(Scope: { [any]: any }): (props: SliderProperties) -> TextButton
	local BoxBorder = BoxBorderComponent(Scope)
	local themeProvider = themeProviderComponent(Scope)
	local getDragInput = getDragInputUtil(Scope)
	local getState = getStateUtil(Scope)
	local getModifier = getModifierUtil(Scope)
	local getMotionState = getMotionStateUtil(Scope)

	return function(props: SliderProperties): TextButton
		local isEnabled = getState(props.Enabled, true)
		local isHovering = Scope:Value(false)

		local handleSize = props.HandleOffsetSize or UDim2.new(0, 12, 1, -2)

		local handleRegion = Scope:Value()
		local inputValue = getState(props.Value, 1)
		local useF = nil

		local currentValue, currentAlpha, isDragging = getDragInput({
			Instance = handleRegion,
			Enabled = isEnabled,
			Value = Scope:Value(Vector2.new(unwrap(inputValue, if useF then useF else nil), 0)),
			Min = Scope:Computed(function(use, scope)
				return Vector2.new(unwrap(props.Min, use) or 0, 0)
			end),
			Max = Scope:Computed(function(use, scope)
				return Vector2.new(unwrap(props.Max, use) or 1, 0)
			end),
			Step = Scope:Computed(function(use, scope)
				return Vector2.new(unwrap(props.Step, use) or -1, 0)
			end),
			OnChange = function(newValue: Vector2)
				if props.OnChange then
					props.OnChange(newValue.X)
				end
			end,
			getUseFunction = function()
				return useF
			end
		})

		Scope:Observer(isDragging):onChange(function()
			inputValue:set(unwrap(currentValue).X)
		end)

		Scope:Observer(inputValue):onChange(function()
			currentValue:set(Vector2.new(unwrap(inputValue), 0))
		end)

		local zIndex = Scope:Computed(function(use, scope)
			return (unwrap(props.ZIndex, use) or 0) + 1
		end)

		local mainModifier = getModifier({
			Enabled = isEnabled,
		})

		local handleModifier = getModifier({
			Enabled = isEnabled,
			Selected = isDragging,
			Hovering = isHovering,
		})

		local handleFill = themeProvider:GetColor(Enum.StudioStyleGuideColor.Button)
		local handleBorder = themeProvider:GetColor(Enum.StudioStyleGuideColor.InputFieldBorder, handleModifier)
		local barAbsSize = Scope:Value(Vector2.zero)

		local newSlider = Scope:New "Frame" {
			Name = "Slider",
			Size = UDim2.new(1, 0, 0, 22),
			ZIndex = zIndex,
			BackgroundTransparency = 1,
			[Children] = {
				BoxBorder {
					Color = themeProvider:GetColor(Enum.StudioStyleGuideColor.InputFieldBorder),
					CornerRadius = UDim.new(0, 1),

					[Children] = Scope:New "Frame" {
						Name = "Bar",
						ZIndex = zIndex,
						Position = UDim2.fromScale(.5, .5),
						AnchorPoint = Vector2.new(.5, .5),
						BorderSizePixel = 0,

						[Out "AbsoluteSize"] = barAbsSize,

						Size = Scope:Computed(function(use, scope)
							local handleSize = unwrap(handleSize, use) or UDim2.new()
							return UDim2.new(1, -handleSize.X.Offset, 0, 5)
						end),

						BackgroundColor3 = getMotionState(themeProvider:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, mainModifier), "Spring", 40),

						BackgroundTransparency = getMotionState(Scope:Computed(function(use, scope)
							return if not unwrap(isEnabled, use) then 0.4 else 0
						end), "Spring", 40),
					}
				},
				handleRegion:set(Scope:New "Frame" {
					Name = "HandleRegion",
					ZIndex = 1,
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					[Children] = BoxBorder {
						Color =  getMotionState(Scope:Computed(function(use, scope)
							return unwrap(handleBorder, use):Lerp(unwrap(handleFill, use), if not unwrap(isEnabled, use) then .5 else 0)
						end), "Spring", 40),

						[Children] = Scope:New "Frame" {
							Name = "Handle",
							BorderMode = Enum.BorderMode.Inset,
							BackgroundColor3 = handleFill,
							BorderSizePixel = 0,

							Size = handleSize,

							AnchorPoint = Vector2.new(.5, .5),

							Position = getMotionState(Scope:Computed(function(use, scope)
								useF = use
								
								local handleSize = unwrap(handleSize, use) or UDim2.new()
								local absoluteBarSize = unwrap(barAbsSize, use) or Vector2.zero
								return UDim2.new(0, (unwrap(currentAlpha, use).X * absoluteBarSize.X) + handleSize.X.Offset / 2, .5, 0)
							end), "Spring", 40),

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
						}
					}
				})
			}
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(newSlider)(hydrateProps)
	end
end

