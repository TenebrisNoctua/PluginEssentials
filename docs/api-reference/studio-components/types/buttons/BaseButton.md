<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">BaseButtonProperties</span>
</h1>

```lua
export type BaseButtonProperties = {
	Activated: (() -> nil)?,
	Enabled: CanBeState<boolean>?,
	TextColorStyle: CanBeState<Enum.StudioStyleGuideColor>?,
	BackgroundColorStyle: CanBeState<Enum.StudioStyleGuideColor>?,
	BorderColorStyle: CanBeState<Enum.StudioStyleGuideColor>?,
	TextSize: CanBeValue<number>,
	[any]: any,
}
```

The `BaseButtonProperties` table that is given to the [`BaseButton()`](../../members/buttons/BaseButton.md) function that contains data about the desired `BaseButton`.

----

## Properties

<h3 markdown>
	Activated
	<span class="api-property-type">
		: (() -> nil)?
	</span>
</h3>

The callback function that will be called when the `BaseButton` is activated.

----

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether the `BaseButton` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	TextColorStyle
	<span class="api-property-type">
		: CanBeState&lt;Enum.StudioStyleGuideColor&gt;?
	</span>
</h3>

Sets the color style of the text to the given [`Enum`](https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideColor) or a `State` containing that `Enum`.

----

<h3 markdown>
	BackgroundColorStyle
	<span class="api-property-type">
		: CanBeState&lt;Enum.StudioStyleGuideColor&gt;?
	</span>
</h3>

Sets the color style of the background to the given [`Enum`](https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideColor) or a `State` containing that `Enum`. 

----

<h3 markdown>
	BorderColorStyle
	<span class="api-property-type">
		: CanBeState&lt;Enum.StudioStyleGuideColor&gt;?
	</span>
</h3>

Sets the color style of the border to the given [`Enum`](https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideColor) or a `State` containing that `Enum`. 

----

<h3 markdown>
	TextSize
	<span class="api-property-type">
		: CanBeValue&lt;number&gt;?
	</span>
</h3>

The size of the text that will be displayed on the `BaseButton`. Can either be a `Value` containing a `number`, or a `number`.

----