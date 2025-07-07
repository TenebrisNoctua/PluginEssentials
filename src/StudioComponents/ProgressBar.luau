-- Written by @boatbomber
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local External = require(script.Parent.Parent.External)
local Fusion = External.getLibrary("Fusion") :: Fusion

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

-- Scoped components
local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local constants = require(StudioComponentsUtil.constants)

local Children = Fusion.Children

local COMPONENT_ONLY_PROPERTIES = {
	"Progress",
	"MaximumProgress"
}

type ProgressProperties = Types.ProgressProperties
type Scope = Types.Scope
type Fusion = Types.Fusion

return function(Scope: Scope): (props: ProgressProperties) -> Frame
	local themeProvider = themeProviderComponent(Scope)
	local getMotionState = getMotionStateUtil(Scope)

	return function(props: ProgressProperties): Frame
		local frame = Scope:New "Frame" {
			Name = "ProgressBar",
			BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground),
			Size = props.Size or UDim2.new(0, constants.TextSize * 6, 0, constants.TextSize),
			ClipsDescendants = true,

			[Children] = {
				Scope:New "UICorner" {
					CornerRadius = constants.CornerRadius,
				},
				Scope:New "Frame" {
					Name = "Fill",
					BackgroundColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.DialogMainButton),

					Size = getMotionState(Scope:Computed(function(use, scope)
						local Progress = unwrap(props.Progress, use) :: number
						local MaximumProgress = unwrap(props.MaximumProgress, use) :: number
						
						assert(Progress <= MaximumProgress, "The progress property cannot have a number more than the MaximumProgress property.")

						return UDim2.fromScale(Progress / MaximumProgress, 1)
					end), "Spring", 40),

					[Children] = Scope:New "UICorner" {
						CornerRadius = constants.CornerRadius,
					}
				},
			}
		}

	    local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)
	    return Scope:Hydrate(frame)(hydrateProps) :: Frame
	end
end

