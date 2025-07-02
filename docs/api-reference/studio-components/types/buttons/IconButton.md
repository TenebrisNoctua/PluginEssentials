<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">IconButtonProperties</span>
</h1>

```lua
export type IconButtonProperties = BaseButtonProperties & {
	ImageColorStyle: CanBeState<Enum.StudioStyleGuideColor>?,
	ImageColorModifier: CanBeState<Enum.StudioStyleGuideModifier>?,
	IconColor3: CanBeState<Color3>?,
	TextSize: nil,
	[any]: any,
}
```

The `IconButtonProperties` table that is given to the [`IconButton()`](../../members/buttons/IconButton.md) function that contains data about the desired `IconButton`.

This type is also an extension of the [`BaseButtonProperties`](BaseButton.md) type.

----

## Properties

<h3 markdown>
	ImageColorStyle
	<span class="api-property-type">
		: CanBeState&lt;Enum.StudioStyleGuideColor&gt;?
	</span>
</h3>

Sets the color style of the image to the given [`Enum`](https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideColor) or a `State` containing that `Enum`.

----

<h3 markdown>
	ImageColorModifier
	<span class="api-property-type">
		: CanBeState&lt;Enum.StudioStyleGuideModifier&gt;?
	</span>
</h3>

Sets the color style modifier of the image to the given [`Enum`](https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideModifier) or a `State` containing that `Enum`.

----

<h3 markdown>
	IconColor3
	<span class="api-property-type">
		: CanBeState&lt;Color3&gt;?
	</span>
</h3>

The color of the icon on the `IconButton`. Can either be a `State` containing a `Color3`, or a `Color3`. Setting this property is not recommended, as it will overwrite the default color defined by the theme of the Studio.

----