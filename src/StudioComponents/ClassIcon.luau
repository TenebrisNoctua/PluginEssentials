-- Written by @boatbomber
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local StudioService = game:GetService("StudioService")
local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)

local COMPONENT_ONLY_PROPERTIES = {
	"ClassName",
}

type ClassIconProperties = Types.ClassIconProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: ClassIconProperties) -> ImageLabel
	return function(props: ClassIconProperties): ImageLabel
		local image = Scope:Computed(function(use, scope)
			local class = unwrap(props.ClassName, use)
			return StudioService:GetClassIcon(class)
		end)

		local hydrateProps = stripProps(props, COMPONENT_ONLY_PROPERTIES)

		return Scope:Hydrate(Scope:New("ImageLabel") {
			Name = "ClassIcon:" .. (if typeof(props.ClassName) == "string" then props.ClassName else ""),
			Size = UDim2.fromOffset(16, 16),
			BackgroundTransparency = 1,
			Image = Scope:Computed(function(use, scope)
				return unwrap(image, use).Image
			end),
			ImageRectOffset = Scope:Computed(function(use, scope)
				return unwrap(image, use).ImageRectOffset
			end),
			ImageRectSize = Scope:Computed(function(use, scope)
				return unwrap(image, use).ImageRectSize
			end),
		})(hydrateProps) :: ImageLabel
	end
end
