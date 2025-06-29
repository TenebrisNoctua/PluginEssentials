<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">ColorPickerProperties</span>
</h1>

```lua
export type ColorPickerProperties = {
	ListDisplayMode: CanBeState<Enum.ListDisplayMode>?,
	Enabled: CanBeState<boolean>?,
	OnChange: (newColor: Color3) -> nil,
	Value: CanBeValue<Color3>?,
	Step: CanBeValue<Vector2>?,
	[any]: any,
}
```

The `ColorPickerProperties` table that is given to the [`ColorPicker()`](../members/ColorPicker.md) function that contains data about the desired `ColorPicker`.

----

## Properties

<h3 markdown>
	ListDisplayMode
	<span class="api-property-type">
		: CanBeState<Enum.ListDisplayMode>?
	</span>
</h3>

The display mode of the `ColorPicker`. Can either be a `State` containing the [`Enum`](https://create.roblox.com/docs/reference/engine/enums/ListDisplayMode), or the `Enum`.

----

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets whether the `ColorPicker` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	OnChange
	<span class="api-property-type">
		: (newColor: Color3) -> nil
	</span>
</h3>

The callback function that will be called when the `ColorPicker`'s value changes.

----

<h3 markdown>
	Value
	<span class="api-property-type">
		: CanBeValue<Color3>?,
	</span>
</h3>

The initial value of the `ColorPicker`. Can either be a `Value` containing a `Color3`, or a `Color3`.

----

<h3 markdown>
	Step
	<span class="api-property-type">
		: CanBeValue<Vector2>?,
	</span>
</h3>

Determines how much the drag will be set to the `ColorPicker`'s arrow. Can either be a `Value` containing a `Vector2`, or a `Vector2`.

----