<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">DropdownProperties</span>
</h1>

```lua
export type DropdownProperties = {
	Enabled: CanBeState<boolean>?,
	Value: CanBeState<any>?,
	Options: CanBeState<{any}>,
	MaxVisibleItems: CanBeState<number>?,
	HideDropdownWhenMouseLeaves: CanBeState<boolean>?,
	OnSelected: (selectedOption: any) -> nil,
	[any]: any,
}
```

The `DropdownProperties` table that is given to the [`Dropdown()`](../../members/dropdown/Dropdown.md) function that contains data about the desired `Dropdown` component.

----

## Properties

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether the `Dropdown` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	Value
	<span class="api-property-type">
		: CanBeState&lt;any&gt;?
	</span>
</h3>

The selected option value of the `Dropdown`. Can either be a `State` that contains anything, or just anything.

----

<h3 markdown>
	Options
	<span class="api-property-type">
		: CanBeState&lt;{any}&gt;?
	</span>
</h3>

The options within the `Dropdown`. Can either be a `State` that contains a table with anything, or just a table with anything.

* If a value within this table is an `Instance`, or an `EnumItem`, then its name will be used as the option.
* If a value within this table is a table, and it has one of these properties: `Label`, `Name`, `Title`; then one of them will be used as the option.
* If a value within this table is a `string` or something that can be turned into a `string`, then that `string` will be used.

The found options will then be turned into a [`DropdownItem`](../../members/dropdown/DropdownItem.md) component to be used within the `Dropdown`.

----

<h3 markdown>
	MaxVisibleItems
	<span class="api-property-type">
		: CanBeState&lt;number&gt;?
	</span>
</h3>

The maximum amount of items that will be visible in the `Dropdown`. Can either be a `State` containing a `number`, or a `number`.

----

<h3 markdown>
	HideDropdownWhenMouseLeaves
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether or not the `Dropdown` will be hidden when the mouse leaves. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	OnSelected
	<span class="api-property-type">
		: (selectedOption: any) -> nil
	</span>
</h3>

The callback function that will be called when an option has been selected from the `Dropdown`.

----
