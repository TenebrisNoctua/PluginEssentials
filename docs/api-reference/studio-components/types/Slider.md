<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">SliderProperties</span>
</h1>

```lua
export type SliderProperties = {
	HandleSize: CanBeState<UDim2>?,
	Enabled: CanBeState<boolean>?,
	OnChange: ((newValue: number) -> nil)?,
	Value: CanBeValue<number>?,
	Min: CanBeState<number>,
	Max: CanBeState<number>,
	Step: CanBeState<number>,
	[any]: any,
}
```

The `SliderProperties` table that is given to the [`Slider()`](../members/Slider.md) function that contains data about the desired `Slider`.

----

## Properties

<h3 markdown>
	HandleSize
	<span class="api-property-type">
		: CanBeState<UDim2>?
	</span>
</h3>

Sets the size of the handle on the `Slider`. Can either be a `State` containing an `UDim2`, or an `UDim2`.

----

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets whether the `Slider` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	OnChange
	<span class="api-property-type">
		: ((newValue: number) -> nil)?
	</span>
</h3>

The callback function that will be called when the `Slider`'s value changes.

----

<h3 markdown>
	Value
	<span class="api-property-type">
		: CanBeValue<number>?
	</span>
</h3>

The initial value of the `Slider`. Can either be a `Value` containing a `number`, or a `number`.

----

<h3 markdown>
	Min
	<span class="api-property-type">
		: CanBeState<number>
	</span>
</h3>

The minimum number that the handle can be moved to. Can either be a `State` containing a `number`, or a `number`.

----

<h3 markdown>
	Max
	<span class="api-property-type">
		: CanBeState<number>
	</span>
</h3>

The maximum number that the handle can be moved to. Can either be a `State` containing a `number`, or a `number`.

----

<h3 markdown>
	Step
	<span class="api-property-type">
		: CanBeState<number>,
	</span>
</h3>

Determines how much the drag will be set to the `Slider`'s handle. Can either be a `State` containing a `number`, or a `number`.

----