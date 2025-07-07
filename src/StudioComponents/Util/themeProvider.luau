-- Written by @TenebrisNoctua
-- Handles the theme colors of the components.

local Studio = settings().Studio
local Plugin = script:FindFirstAncestorWhichIsA("Plugin")

local External = require(script.Parent.Parent.Parent.External)
local Fusion = External.getLibrary("Fusion") :: Fusion

local ComponentTypes = script.Parent.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

local unwrap = require(script.Parent.unwrap)

local themeProvider = {
	Theme = {} :: Value<string>,
	ThemeColors = {} :: {[Enum.StudioStyleGuideColor]: {[Enum.StudioStyleGuideModifier]: Value<Color3>}},
	IsDark = {} :: Value<boolean>,
	Scope = {} :: Scope,
	ItemScope = {} :: Scope,
	Fonts = {
		Default = Enum.Font.SourceSans,
		SemiBold = Enum.Font.SourceSansSemibold,
		Bold = Enum.Font.SourceSansBold,
		Black = Enum.Font.GothamBlack,
		Mono = Enum.Font.Code,
	},
}

type State<T> = Types.State<T>
type Value<T> = Types.Value<T>
type Computed<T> = Types.Computed<T>

type Scope = Types.Scope
type Use = Types.Use
type Fusion = Types.Fusion

type StyleGuideColor = Value<Enum.StudioStyleGuideColor> | Enum.StudioStyleGuideColor
type StyleGuideModifier = Value<Enum.StudioStyleGuideModifier> | Enum.StudioStyleGuideModifier

type themeProvider = typeof(themeProvider)

--// Local Functions

local function getValue(value: Value<any> | any): (any, "State" | "Enum" | "Nil")
	if typeof(value) == "table" and value.type == "State" then
		return unwrap(value), "State"
	elseif value then
		return value, "Enum"
	else
		return nil, "Nil"
	end 
end

local function isCorrectEnum(value: EnumItem | any, desiredEnum: Enum)
	assert(typeof(value) == "EnumItem" and value.EnumType == desiredEnum, "Incorrect type.")
end

local function updateTheme()
	for studioStyleGuideColor, styleGuideModifiers in themeProvider.ThemeColors do
		for studioStyleGuideModifier, valueState in styleGuideModifiers do
			valueState:set(Studio.Theme:GetColor(studioStyleGuideColor, studioStyleGuideModifier))
		end
	end

	themeProvider.Theme:set(Studio.Theme.Name)

	local _, _, v = Studio.Theme:GetColor(Enum.StudioStyleGuideColor.MainBackground):ToHSV()
	themeProvider.IsDark:set(v <= 0.6)
end

--// Main Functions

function themeProvider.GetColor(self: themeProvider, styleGuideColor: StyleGuideColor, styleGuideModifier: StyleGuideModifier, force: boolean?): Computed<Color3>
	local StyleGuideColor, SGCValueType = getValue(styleGuideColor)
	local StyleGuideModifier, SGMValueType = getValue(styleGuideModifier)
	
	local function evaluate(): State<Color3>
		StyleGuideColor, SGCValueType = getValue(styleGuideColor)
		StyleGuideModifier, SGMValueType = getValue(styleGuideModifier)

		isCorrectEnum(StyleGuideColor, Enum.StudioStyleGuideColor)

		if SGMValueType == "Nil" then 
			StyleGuideModifier = Enum.StudioStyleGuideModifier.Default
		else
			isCorrectEnum(StyleGuideModifier, Enum.StudioStyleGuideModifier) 
		end
		
		if not force and self.ThemeColors[StyleGuideColor] and self.ThemeColors[StyleGuideColor][StyleGuideModifier] then
			return self.ThemeColors[StyleGuideColor][StyleGuideModifier]
		else
			local newThemeColor = Studio.Theme:GetColor(StyleGuideColor, StyleGuideModifier)
			local newThemeColorState = self.ItemScope:Value(newThemeColor)

			if not self.ThemeColors[StyleGuideColor] then self.ThemeColors[StyleGuideColor] = {} end
			self.ThemeColors[StyleGuideColor][StyleGuideModifier] = newThemeColorState

			return newThemeColorState
		end
	end

	return self.Scope:Computed(function(use: Use, innerScope: Scope)  
		if SGCValueType == "State" then use(styleGuideColor) end
		if SGMValueType == "State" then use(styleGuideModifier) end

		return unwrap(evaluate(), use)
	end)
end

function themeProvider.GetFont(self: themeProvider, fontName: (string | State<string>)): Computed<Enum.Font>
	return self.Scope:Computed(function(use: Use, innerScope: Scope)  
		local givenFontName = unwrap(fontName, use)
		local fontToGet = self.Fonts.Default

		if givenFontName ~= nil and self.Fonts[givenFontName] then
			fontToGet = self.Fonts[givenFontName]
		end

		return unwrap(fontToGet, use)
	end)
end

return function(Scope: Scope): themeProvider
	if themeProvider.Scope.New then return themeProvider end
	
	themeProvider.Theme = Scope:Value(Studio.Theme.Name)
	themeProvider.IsDark = Scope:Value(false)
	themeProvider.Scope = Scope
	
	themeProvider.ItemScope = Fusion:scoped()

	local themeChangedConnection = Studio.ThemeChanged:Connect(updateTheme)
	updateTheme()

	Plugin.Unloading:Connect(function()
		themeChangedConnection:Disconnect()
		themeChangedConnection = nil
		Fusion.doCleanup(themeProvider.ItemScope)
	end)

	return themeProvider
end