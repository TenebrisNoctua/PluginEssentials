<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">getSelectedStateProperties</span>
</h1>

```lua
export type GetSelectedStateProperties = {
	Value: CanBeValue<any>?,
	Options: CanBeState<{any}>?,
	OnSelected: ((selectedOption: any, use: Use?) -> nil)?,
}
```

The `getSelectedStateProperties` table that is given to the [`getSelectedState()`](../../members/util/getSelectedState.md) function that contains data about the desired value from the utility function.

----

## Properties

<h3 markdown>
	Value
	<span class="api-property-type">
		: CanBeValue&lt;any&gt;?
	</span>
</h3>

The selected option value from the component. Can either be a `Value` that contains anything, or just anything.

----

<h3 markdown>
	Options
	<span class="api-property-type">
		: CanBeState&lt;{any}&gt;?
	</span>
</h3>

The options table from the component. Can either be a `State` that contains a table with anything, or just a table with anything.

----

<h3 markdown>
	OnSelected
	<span class="api-property-type">
		: ((selectedOption: any, use: Use?) -> nil)?
	</span>
</h3>

The callback function that will be called when an option has been selected from the component.

----