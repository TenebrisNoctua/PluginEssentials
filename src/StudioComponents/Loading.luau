-- Written by @boatbomber
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

-- Scoped components
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getStateUtil = require(StudioComponentsUtil.getState)
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local constants = require(StudioComponentsUtil.constants)

local Children = Fusion.Children

local COMPONENT_ONLY_PROPERTIES = {
	"Enabled",
}

type LoadingProperties = Types.LoadingProperties
type Scope = Types.Scope

local cos = math.cos
local clock = os.clock
local pi4 = 12.566370614359172 -- 4 * pi

return function(Scope: Scope): (props: LoadingProperties) -> Frame
	local themeProvider = themeProviderComponent(Scope)
	local getState = getStateUtil(Scope)
	local getMotionState = getMotionStateUtil(Scope)

	return function(props: LoadingProperties): Frame
		local isEnabled = getState(props.Enabled, true)
		local time = Scope:Value(0)

		local animThread = nil

		local function startMotion()
			if not unwrap(isEnabled) then return end

			if animThread then
				task.cancel(animThread)
				animThread = nil
			end

			animThread = task.defer(function()
				local startTime = clock()
				while unwrap(isEnabled) do
					time:set(clock() - startTime)
					task.wait(1/25) -- Springs will smooth out the motion so we needn't bother with high refresh rate here
				end
			end)
		end
		startMotion()
		
		local observeDisconnect = Scope:Observer(isEnabled):onChange(startMotion)

		table.insert(Scope, function() 
			observeDisconnect()
			if animThread then
				task.cancel(animThread)
				animThread = nil
			end
		end)

		local light = themeProvider:GetColor(Enum.StudioStyleGuideColor.Light, Enum.StudioStyleGuideModifier.Default)
		local accent = themeProvider:GetColor(Enum.StudioStyleGuideColor.DialogMainButton, Enum.StudioStyleGuideModifier.Default)

		local alphaA = Scope:Computed(function(use, scope)
			local t = (unwrap(time, use) + 0.25) * pi4
			return (cos(t)+1)/2
		end)
		local alphaB = Scope:Computed(function(use, scope)
			local t = unwrap(time, use) * pi4
			return (cos(t)+1)/2
		end)

		local colorA = getMotionState(Scope:Computed(function(use, scope)
			return unwrap(light):Lerp(unwrap(accent, use), unwrap(alphaA, use))
		end), "Spring", 40)

		local colorB = getMotionState(Scope:Computed(function(use, scope)
			return unwrap(light):Lerp(unwrap(accent, use), unwrap(alphaB, use))
		end), "Spring", 40)

		local sizeA = getMotionState(Scope:Computed(function(use, scope)
			local alpha = unwrap(alphaA, use)
			return UDim2.fromScale(
				0.2,
				0.5 + alpha*0.5
			)
		end), "Spring", 40)

		local sizeB = getMotionState(Scope:Computed(function(use, scope)
			local alpha = unwrap(alphaB, use)
			return UDim2.fromScale(
				0.2,
				0.5 + alpha*0.5
			)
		end), "Spring", 40)

		local frame = Scope:New "Frame" {
			Name = "Loading",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, constants.TextSize * 4, 0, constants.TextSize * 1.5),
			Visible = isEnabled,
			ClipsDescendants = true,
			[Children] = {
				Scope:New "Frame" {
					Name = "Bar1",
					BackgroundColor3 = colorA,
					Size = sizeA,
					Position = UDim2.fromScale(0.02, 0.5),
					AnchorPoint = Vector2.new(0,0.5),
				},
				Scope:New "Frame" {
					Name = "Bar2",
					BackgroundColor3 = colorB,
					Size = sizeB,
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5,0.5),
				},
				Scope:New "Frame" {
					Name = "Bar3",
					BackgroundColor3 = colorA,
					Size = sizeA,
					Position = UDim2.fromScale(0.98, 0.5),
					AnchorPoint = Vector2.new(1,0.5),
				},
			}
		}

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
		return Scope:Hydrate(frame)(hydrateProps) :: Frame
	end
end

