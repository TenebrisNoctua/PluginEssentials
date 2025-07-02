<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">CheckboxProperties</span>
</h1>

```lua
export type CheckboxProperties = {
	OnChange: ((newValue: boolean) -> nil)?,
	Alignment: CanBeState<Enum.HorizontalAlignment>?,
	Enabled: CanBeState<boolean>?,
	Text: CanBeState<string>?,
	Value: CanBeValue<boolean>?,
	[any]: any,
}
```

The `CheckboxProperties` table that is given to the [`Checkbox()`](../members/Checkbox.md) function that contains data about the desired `Checkbox`.

----

## Properties

<h3 markdown>
	OnChange
	<span class="api-property-type">
		: ((newValue: boolean) -> nil)?
	</span>
</h3>

The callback function that will be called when the `Checkbox`'s value changes.

----

<h3 markdown>
	Alignment
	<span class="api-property-type">
		: CanBeState&lt;Enum.HorizontalAlignment&gt;?
	</span>
</h3>

Determines where the `Checkbox` will be aligned to. Can either be a `State` containing the [`Enum`](https://create.roblox.com/docs/reference/engine/enums/HorizontalAlignment) or the `Enum`.

----

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether the `Checkbox` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	Text
	<span class="api-property-type">
		: CanBeState&lt;string&gt;?
	</span>
</h3>

The text that will be visible alongside the `Checkbox`. Can either be a `State` containing a `string`, or a `string`.

----

<h3 markdown>
	Value
	<span class="api-property-type">
		: CanBeValue&lt;boolean&gt;?,
	</span>
</h3>

The initial value of the `Checkbox`. If not set, then the `Checkbox` will be indeterminate. Can either be a `Value` containing a `boolean`, or a `boolean`.

----