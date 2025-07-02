<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">DropdownItemProperties</span>
</h1>

```lua
export type DropdownItemProperties = {
	OnSelected: (selectedOption: any) -> nil,
	Item: any,
    Text: CanBeState<string>?,
    ZIndex: CanBeState<number>?,
	[any]: any,
}
```

The `DropdownItemProperties` table that is given to the [`DropdownItem()`](../../members/dropdown/DropdownItem.md) function that contains data about the desired `DropdownItem`.

----

## Properties

<h3 markdown>
	OnSelected
	<span class="api-property-type">
		: (selectedOption: any) -> nil
	</span>
</h3>

The callback function that will be called when the option has been selected.

----

<h3 markdown>
	Item
	<span class="api-property-type">
		: any
	</span>
</h3>

The item that will be used for setting the `Text` property of the `DropdownItem`.

----

<h3 markdown>
	Text
	<span class="api-property-type">
		: CanBeState<string>?
	</span>
</h3>

Sets the `Text` property of the `DropdownItem`. Setting this property is not recommended, as if the `Item` property is set, then it may get overwritten.

----

<h3 markdown>
	ZIndex
	<span class="api-property-type">
		: CanBeState<number>?
	</span>
</h3>

Sets the `ZIndex` property of the `DropdownItem`.

----