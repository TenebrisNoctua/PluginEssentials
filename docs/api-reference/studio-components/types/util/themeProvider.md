<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">themeProvider</span>
</h1>

```lua
export type themeProvider = {
	Theme: Value<string>,
	ThemeColors: {[Enum.StudioStyleGuideColor]: {[Enum.StudioStyleGuideModifier]: Value<Color3>}},
	IsDark: Value<boolean>,
	Scope: Scope,
	ItemScope: Scope,
	Fonts: {
		Default: Enum.Font,
		SemiBold: Enum.Font,
		Bold: Enum.Font,
		Black: Enum.Font,
		Mono: Enum.Font,
	},
    GetColor: (self: themeProvider, styleGuideColor: CanBeValue<Enum.StudioStyleGuideColor>, styleGuideModifier: CanBeValue<Enum.StudioStyleGuideModifier>, force: boolean?) -> Computed<Color3>,
	GetFont: (self: themeProvider, fontName: CanBeState<string>) -> Computed<Enum.Font>
}
```

The type of the `themeProvider` table that is returned from the [`themeProvider()`](../../members/util/themeProvider.md) function that contains data about the returned `themeProvider` API.

----

## Properties

<h3 markdown>
	Theme
	<span class="api-property-type">
		: Value&lt;string&gt;
	</span>
</h3>

The current theme that is set on the Studio. *(Should only be read.)*

----

<h3 markdown>
	ThemeColors
	<span class="api-property-type">
		: {[Enum.StudioStyleGuideColor]: {[Enum.StudioStyleGuideModifier]: Value&lt;Color3&gt;}}
	</span>
</h3>

The theme colors used by the components within Plugin Essentials. Directly modifying this table is *strongly not recommended*, as this table stores all the `StudioStyleGuideColor`s and the `StudioStyleGuideModifier`s given by the components, and it will most likely cause bugs if overwritten.

----

<h3 markdown>
	IsDark
	<span class="api-property-type">
		: Value&lt;boolean&gt;
	</span>
</h3>

Indicates if the current Studio theme is dark. This is calculated through the background color of the current theme of the Studio. 
*(Should only be read.)*

----

<h3 markdown>
	Scope
	<span class="api-property-type">
		: Scope
	</span>
</h3>

The `Scope` in which the Fusion objects will be created in the `themeProvider`.
*(Should only be read.)*

----

<h3 markdown>
	ItemScope
	<span class="api-property-type">
		: Scope
	</span>
</h3>

The `Scope` in which the item objects will be created in the `themeProvider`. Directly modifying this table is *strongly not recommended*, as it is used only internally, so modifications to this table ***will cause bugs.***

----

<h3 markdown>
	Fonts
	<span class="api-property-type">
		: {...: Enum.Font}
	</span>
</h3>

The default fonts stored within the `themeProvider`. *(Should only be read.)*

----

<h3 markdown>
	GetColor
	<span class="api-property-type">
		: (self: themeProvider, styleGuideColor: CanBeValue&lt;Enum.StudioStyleGuideColor&gt;, styleGuideModifier: CanBeValue&lt;Enum.StudioStyleGuideModifier&gt;, force: boolean?) -> Computed&lt;Color3&gt;
	</span>
</h3>

This function takes in a `StudioStyleGuideColor`, and a `StudioStyleGuideModifier`, and using these values, calculates a matching color.
This color is returned within a `Computed`, so when the theme of the Studio updates, or when the `ThemeColors` table properties are updated, the colors are re-calculated. The colors will also be re-calculated, if the given values are `Value`s, when they are updated.

----

<h3 markdown>
	GetFont
	<span class="api-property-type">
		: (self: themeProvider, fontName: CanBeState&lt;string&gt;) -> Computed&lt;Enum.Font&gt;
	</span>
</h3>

This function will return the matching `Font` from the `Fonts` table, with the given `fontName` parameter. This `Font` is returned within a `Computed`, so when the `fontName` parameter is updated, if it is a `State`, the `Font` to be returned will be re-calculated.

----