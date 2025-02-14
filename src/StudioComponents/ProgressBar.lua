-- Written by @boatbomber
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

-- Scoped components
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)
local constants = require(StudioComponentsUtil.constants)

local Children = Fusion.Children

local COMPONENT_ONLY_PROPERTIES = {
	"Progress",
}

type ProgressProperties = {
	Progress: (number | types.StateObject<number>)?,
	[any]: any,
}

return function(Scope: { [any]: any }): (props: ProgressProperties) -> Frame
	local themeProvider = themeProviderComponent(Scope)
	local getMotionState = getMotionStateUtil(Scope)

	return function(props: ProgressProperties): Frame
		local frame = Scope:New "Frame" {
			Name = "Loading",
			BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.ScrollBarBackground),
			Size = UDim2.new(0,constants.TextSize*6, 0, constants.TextSize),
			ClipsDescendants = true,

			[Children] = {
				Scope:New "UICorner" {
					CornerRadius = constants.CornerRadius,
				},
				Scope:New "Frame" {
					Name = "Fill",
					BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.DialogMainButton),

					Size = getMotionState(Scope:Computed(function(use, scope)
						return UDim2.fromScale(unwrap(props.Progress, use), 1)
					end), "Spring", 40),

					[Children] = Scope:New "UICorner" {
						CornerRadius = constants.CornerRadius,
					}
				},
			}
		}

	    local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
	    return Scope:Hydrate(frame)(hydrateProps)
	end
end

