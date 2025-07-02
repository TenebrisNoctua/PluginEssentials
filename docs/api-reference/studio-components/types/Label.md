<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">LabelProperties</span>
</h1>

```lua
export type LabelProperties = {
	Enabled: CanBeState<boolean>?,
	Text: CanBeState<string>?,
	TextColor3: CanBeState<Color3>?,
	TextColorStyle: CanBeState<Enum.StudioStyleGuideColor>?,
	TextSize: CanBeState<number>?,
	[any]: any,
}
```

The `LabelProperties` table that is given to the [`Label()`](../members/Label.md) function that contains data about the desired `Label`.

----

## Properties

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether the `Label` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	Text
	<span class="api-property-type">
		: CanBeState&lt;string&gt;?
	</span>
</h3>

The text that will be displayed on the `Label`. Can either be a `State` containing a `string`, or a `string`.

----

<h3 markdown>
	TextColor3
	<span class="api-property-type">
		: CanBeState&lt;Color3&gt;?
	</span>
</h3>

The color of the text on the `Label`. Can either be a `State` containing a `Color3`, or a `Color3`. Setting this property is not recommended, as it will overwrite the default color defined by the theme of the Studio.

----

<h3 markdown>
	TextColorStyle
	<span class="api-property-type">
		: CanBeState&lt;Enum.StudioStyleGuideColor&gt;?
	</span>
</h3>

Sets the color style of the text to the given [`Enum`](https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideColor) or a `State` containing that `Enum`. This property is recommended to use if you want to modify the color of the text while making it consistent with the theme of the Studio.

----

<h3 markdown>
	TextSize
	<span class="api-property-type">
		: CanBeState&lt;number&gt;?
	</span>
</h3>

The size of the text that will be displayed on the `Label`. Can either be a `State` containing a `number`, or a `number`.

----