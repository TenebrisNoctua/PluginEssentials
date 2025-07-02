<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">BoxBorderProperties</span>
</h1>

```lua
export type BoxBorderProperties = {
	Color: CanBeState<Color3>?,
	Thickness: CanBeState<number>?,
	CornerRadius: CanBeState<UDim>?,
	[FusionTypes.Child]: GuiObject,
}
```

The `BoxBorderProperties` table that is given to the [`BoxBorder()`](../members/BoxBorder.md) function that contains data about the desired `BoxBorder`.

----

## Properties

<h3 markdown>
	Color
	<span class="api-property-type">
		: CanBeState&lt;Color3&gt;?
	</span>
</h3>

The color of the border. Can either be a `State` containing a `Color3` or a `Color3`.

----

<h3 markdown>
	Thickness
	<span class="api-property-type">
		: CanBeState&lt;number&gt;?
	</span>
</h3>

The thickness of the border. Can either be a `State` containing a `number` or a `number`.

----

<h3 markdown>
	CornerRadius
	<span class="api-property-type">
		: CanBeState&lt;UDim&gt;?
	</span>
</h3>

The radius of the border. Can either be a `State` containing an `UDim` or an `UDim`.

----