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
local constants = require(StudioComponentsUtil.constants)
local unwrap = require(StudioComponentsUtil.unwrap)

local SideData = {
	top = {
		image = "rbxassetid://6528009956",
	},
	bottom = {
		image = "rbxassetid://6185927567",
	},
	left = {
		image = "rbxassetid://6978297327",
	},
	right = {
		image = "rbxassetid://6441569774",
	},
}

type ShadowProperties = Types.ShadowProperties
type Scope = Types.Scope

return function(Scope: Scope): (props: ShadowProperties) -> ImageLabel
	local themeProvider = themeProviderComponent(Scope)
	SideData = {
		top = {
			image = "rbxassetid://6528009956",
			size = Scope:Computed(function(use, scope)
				return UDim2.new(1,0,0, constants.TextSize)
			end),
			position = Scope:Computed(function(use, scope)
				return UDim2.new(0,0,0, constants.TextSize)
			end)
		},
		bottom = {
			image = "rbxassetid://6185927567",
			size = Scope:Computed(function(use, scope)
				return UDim2.new(1,0,0,constants.TextSize)
			end),
			position = Scope:Computed(function(use, scope)
				return UDim2.new(0,0,1,0)
			end)
		},
		left = {
			image = "rbxassetid://6978297327",
			size = Scope:Computed(function(use, scope)
				return UDim2.new(0,constants.TextSize,1,0)
			end),
			position = Scope:Computed(function(use, scope)
				return UDim2.new(0,constants.TextSize,0,0)
			end)
		},
		right = {
			image = "rbxassetid://6441569774",
			size = Scope:Computed(function(use, scope)
				return UDim2.new(0,constants.TextSize,1,0)
			end),
			position = Scope:Computed(function(use, scope)
				return UDim2.new(1,0,0,0)
			end)
		},
	}

	return function(props: ShadowProperties): ImageLabel
		local Side = SideData[string.lower(props.Side or "right")]

		return Scope:New "ImageLabel" {
			Name = "Shadow",
			BackgroundTransparency = 1,
			LayoutOrder = props.LayoutOrder or 10000,
			Image = Side.image,
			ImageTransparency = Scope:Computed(function(use, scope)
				if not unwrap(themeProvider.IsDark, use) then
					-- Softer shadows on light themes
					return ((props.Transparency or 0) * 0.55) + 0.45
				else
					return props.Transparency or 0
				end
			end),

			Size = Side.size,
			Position = Side.position,
		} :: ImageLabel
	end
end


