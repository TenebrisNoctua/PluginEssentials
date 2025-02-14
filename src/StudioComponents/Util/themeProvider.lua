-- Migrated to Fusion 0.3 by @TenebrisNoctua

local types = require(script.Parent.types)

type styleStyleGuideColor = Enum.StudioStyleGuideColor | types.StateObject<Enum.StudioStyleGuideColor>
type styleGuideModifier = Enum.StudioStyleGuideModifier | types.StateObject<Enum.StudioStyleGuideModifier>
type computedOrValue = types.Computed<Color3> | types.Value<Color3>

local Studio = settings().Studio
local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local unwrap = require(script.Parent.unwrap)

local currentTheme = {}
local themeProvider = {
	Theme = false, -- Initialize Theme, IsDark and Scope values here
	IsDark = false,
	Scope = false,
	Fonts = {
		Default = Enum.Font.SourceSans,
		SemiBold = Enum.Font.SourceSansSemibold,
		Bold = Enum.Font.SourceSansBold,
		Black = Enum.Font.GothamBlack,
		Mono = Enum.Font.Code,
	},
}

function themeProvider:GetColor(studioStyleGuideColor: styleStyleGuideColor, studioStyleGuideModifier: styleGuideModifier?, newScope: {[any]: any}?): computedOrValue
	local Scope = newScope or self.Scope
	
	local hasState = (unwrap(studioStyleGuideModifier) ~= studioStyleGuideModifier) or (unwrap(studioStyleGuideColor) ~= studioStyleGuideColor)
	
	local function isCorrectType(value, enumType)
		local unwrapped = unwrap(value)
		local isState = unwrapped ~= value and unwrapped ~= nil
		assert((value == nil or isState) or (typeof(value) == "EnumItem" and value.EnumType == enumType), "Incorrect type")
	end

	isCorrectType(studioStyleGuideColor, Enum.StudioStyleGuideColor)
	isCorrectType(studioStyleGuideModifier, Enum.StudioStyleGuideModifier)

	local unwrappedColor = unwrap(studioStyleGuideColor)
	local unwrappedModifier = unwrap(studioStyleGuideModifier)

	if not currentTheme[unwrappedColor] then
		currentTheme[unwrappedColor] = {}
	end

	local themeValue = (function()
		local styleGuideModifier = if unwrappedModifier ~= nil
			then unwrappedModifier
			else Enum.StudioStyleGuideModifier.Default

		local existingValue = currentTheme[unwrappedColor][styleGuideModifier]
		if existingValue then
			return existingValue
		end

		local newThemeValue = Scope:Value(Studio.Theme:GetColor(unwrappedColor, styleGuideModifier))
		currentTheme[unwrappedColor][styleGuideModifier] = newThemeValue

		return newThemeValue
	end)()
	
	local nScope = if hasState then Fusion:scoped() else nil
	
	return if not hasState then themeValue else Scope:Computed(function(use, scope)
		local currentColor = unwrap(studioStyleGuideColor, use)
		local currentModifier = unwrap(studioStyleGuideModifier, use)
		local currentValueState = self:GetColor(currentColor, currentModifier, nScope)
		
		return unwrap(currentValueState)
	end)
end

function themeProvider:GetFont(fontName: (string | types.StateObject<string>)?): types.Computed<Enum.Font>
	return self.Scope:Computed(function(use, scope)
		local givenFontName = unwrap(fontName, use)
		local fontToGet = self.Fonts.Default

		if givenFontName ~= nil and self.Fonts[givenFontName] then
			fontToGet = self.Fonts[givenFontName]
		end

		return unwrap(fontToGet, use)
	end)
end

local function updateTheme()
	for studioStyleGuideColor, styleGuideModifiers: { Enum.StudioStyleGuideModifier } in pairs(currentTheme) do
		for studioStyleGuideModifier, valueState in pairs(styleGuideModifiers) do
			valueState:set(Studio.Theme:GetColor(studioStyleGuideColor, studioStyleGuideModifier))
		end
	end

	themeProvider.Theme:set(Studio.Theme.Name)

	local _, _, v = Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground):ToHSV()
	themeProvider.IsDark:set(v <= 0.6)
end

return function(Scope: { [any]: any }): typeof(themeProvider)
	themeProvider.Theme = Scope:Value(Studio.Theme.Name)
	themeProvider.IsDark = Scope:Value(true)
	themeProvider.Scope = Scope

	local themeChangedConnection = Studio.ThemeChanged:Connect(updateTheme)
	updateTheme()

	Plugin.Unloading:Connect(function()
		themeChangedConnection:Disconnect()
		themeChangedConnection = nil
	end)

	return themeProvider
end