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

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)

local Children = Fusion.Children
local Cleanup = Fusion.doCleanup

local COMPONENT_ONLY_PROPERTIES = {
	"ZIndex",
	"Enabled",
	"OnChange",
	"ListDisplayMode",
	"Value",
	"Step",
}

type ColorPickerProperties = {
	ListDisplayMode: (Enum.ListDisplayMode | types.StateObject<Enum.ListDisplayMode>)?,
	Enabled: (boolean | types.StateObject<boolean>)?,
	OnChange: (newColor: Color3) -> nil,
	Value: (Color3 | types.Value<Color3>)?,
	Step: (Vector2 | types.Value<Vector2>)?,
	[any]: any,
}

return function(Scope: { [any]: any }): (props: ColorPickerProperties) -> Frame
	local BoxBorder = BoxBorderComponent(Scope)
	local themeProvider = themeProviderComponent(Scope)
	local getDragInput = getDragInputUtil(Scope)
	local getState = getStateUtil(Scope)

	return function(props: ColorPickerProperties): Frame
		local listDisplayMode = getState(props.ListDisplayMode, Enum.ListDisplayMode.Horizontal)

		local isEnabled = getState(props.Enabled, true)

		local isHorizontalList = Scope:Computed(function(use, scope)
			return unwrap(listDisplayMode, use) == Enum.ListDisplayMode.Horizontal
		end)

		local regionRef = Scope:Value()
		local sliderRef = Scope:Value()

		local currentRegionInput = getDragInput({
			Enabled = isEnabled,
			Instance = regionRef,
			Value = Scope:Value(Vector2.new()),
		})

		local currentSliderInput = getDragInput({
			Enabled = isEnabled,
			Instance = sliderRef,
			Value = Scope:Value(Vector2.new()),
		})

		local inputColor = getState(props.Value, Color3.new(1, 1, 1))
		local function updateCurrentInput()
			local hue, sat, val = unwrap(inputColor):ToHSV()
			currentRegionInput:set(Vector2.new(1-hue, 1-sat))
			currentSliderInput:set(if unwrap(isHorizontalList) then Vector2.new(0, 1-val) else Vector2.new(val, 0))
		end

		updateCurrentInput()

		local currentColor = Scope:Computed(function(use, scope)
			local regionInput = unwrap(currentRegionInput, use)
			local sliderInput = unwrap(currentSliderInput, use)
			return Color3.fromHSV(
				math.max(0.0001, 1 - regionInput.X),
				math.max(0.0001, 1 - regionInput.Y),
				math.max(0.0001, 1 - if unwrap(isHorizontalList) then sliderInput.Y else 1 - sliderInput.X)
			)
		end)

		local function roundNumber(number: number)
			return if (1-number) < .01 or number < .01 then math.round(number) else number
		end

		local lastUpdatedColor = nil
		local cleanupInputColorObserver = Scope:Observer(inputColor):onChange(updateCurrentInput)
		local cleanupCurrentColorObserver = Scope:Observer(currentColor):onChange(function()
			local newColor = unwrap(currentColor)
			if props.OnChange then
				local roundedColor = Color3.new(
					roundNumber(newColor.R),
					roundNumber(newColor.G),
					roundNumber(newColor.B)
				)

				if lastUpdatedColor ~= roundedColor then
					lastUpdatedColor = roundedColor
					-- to prevent dependency issues
					task.spawn(function()
						-- due to the math.max earlier, I need to round to the nearest whole number just in case
						props.OnChange(roundedColor)
					end)
				end
			end
		end)

		local childZIndex = Scope:Computed(function(use, scope)
			return (unwrap(props.ZIndex, use) or 0) + 1
		end)

		local function cleanUp() -- Add a better way to call this.
			cleanupInputColorObserver()
			cleanupCurrentColorObserver()
		end

		local newColorPicker = Scope:New "Frame" {
			Name = "ColorPicker",
			Size = UDim2.new(1, 0, 0, 150),
			BackgroundTransparency = 1,
			[Children] = {
				BoxBorder {
					[Children] = sliderRef:set(Scope:New "TextButton" {
						Name = "Slider",
						ZIndex = childZIndex,
						Active = false,
						AutoButtonColor = false,
						Text = "",
						Size = Scope:Computed(function(use, scope)
							if unwrap(isHorizontalList, use) then
								return UDim2.new(0, 14, 1, 0)
							end
							return UDim2.new(1, 0, 0, 14)
						end),
						AnchorPoint = Scope:Computed(function(use, scope)
							if unwrap(isHorizontalList, use) then
								return Vector2.new(1, 0)
							end
							return Vector2.new(0, 1)
						end),
						Position = Scope:Computed(function(use, scope)
							if unwrap(isHorizontalList, use) then
								return UDim2.new(1, -6, 0, 0)
							end
							return UDim2.new(0, 0, 1, -6)
						end),
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),

						[Children] = {
							Scope:New "UIGradient" {
								Name = "Gradient",
								Color = Scope:Computed(function(use, scope)
									local isEnabled = unwrap(isEnabled, use)
									local hue, sat, val = unwrap(currentColor, use):ToHSV()
									return ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromHSV(hue, sat, if isEnabled then 1 else .5))
								end),
								Rotation = Scope:Computed(function(use, scope)
									if unwrap(isHorizontalList, use) then
										return -90
									end
									return 0
								end),
							},
							Scope:New "ImageLabel" {
								Name = "Arrow",
								ZIndex = childZIndex,
								AnchorPoint = Scope:Computed(function(use, scope)
									if unwrap(isHorizontalList, use) then
										return Vector2.new(0, .5)
									end
									return Vector2.new(.5, 0)
								end),
								Size = UDim2.fromOffset(5, 9),
								Rotation = Scope:Computed(function(use, scope)
									if unwrap(isHorizontalList, use) then
										return 0
									end
									return 90
								end),
								Position = Scope:Computed(function(use, scope)
									local scale = 1 - select(3, unwrap(currentColor, use):ToHSV())
									if unwrap(isHorizontalList, use) then
										return UDim2.new(1, 1, scale, 0)
									end
									return UDim2.new(1 - scale, 0, 1, 1)
								end),
								BackgroundTransparency = 1,
								Image = "rbxassetid://7507468017",
								ImageColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.TitlebarText),
							}
						}
					})
				},
				BoxBorder {
					[Children] = regionRef:set(Scope:New "ImageButton" {
						Name = "Region",
						ZIndex = childZIndex,
						Active = false,
						AutoButtonColor = false,
						Size = Scope:Computed(function(use, scope)
							if unwrap(isHorizontalList, use) then
								return UDim2.new(1, -30, 1, 0)
							end
							return UDim2.new(1, 0, 1, -30)
						end),
						Image = "rbxassetid://2752294886",
						ImageColor3 = Scope:Computed(function(use, scope)
							return Color3.fromHSV(0, 0, if unwrap(isEnabled, use) then 1 else .5)
						end),
						ClipsDescendants = true,
						BorderSizePixel = 0,

						[Children] = Scope:New "Frame" {
							Name = "Indicator",
							ZIndex = childZIndex,
							AnchorPoint = Vector2.new(0.5, 0.5),
							Position = Scope:Computed(function(use, scope)
								local hue, sat, val = unwrap(currentColor, use):ToHSV()
								return UDim2.new(1 - hue, 1, 1 - sat, 0)
							end),
							Size = UDim2.fromOffset(19, 19),
							BackgroundTransparency = 1,

							[Children] = {
								Scope:New "Frame" {
									Name = "Vertical",
									ZIndex = childZIndex,
									Position = UDim2.fromOffset(8, 0),
									Size = UDim2.new(0, 2, 1, 0),
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								},
								Scope:New "Frame" {
									Name = "Horizontal",
									ZIndex = childZIndex,
									Position = UDim2.fromOffset(0, 8),
									Size = UDim2.new(1, 0, 0, 2),
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(0, 0, 0),
								}
							}
						}
					})
				},
			}
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(newColorPicker)(hydrateProps)
	end
end

