<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">TextInputProperties</span>
</h1>

```lua
export type TextInputProperties = {
	Enabled: CanBeState<boolean>?,
	Text: CanBeValue<string>?,
	OnChange: (newText: string) -> nil,
	[any]: any,
}
```

The `TextInputProperties` table that is given to the [`TextInput()`](../../members/input/TextInput.md) function that contains data about the desired `TextInput`.

----

## Properties

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets whether the `TextInput` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	Text
	<span class="api-property-type">
		: CanBeValue<string>?,
	</span>
</h3>

The default text that will be displayed on the `TextInput`. Can either be a `Value` containing a `string`, or a `string`.
This property can be changed by the end-user.

----

<h3 markdown>
	OnChange
	<span class="api-property-type">
		: (newText: string) -> nil,
	</span>
</h3>

The callback function that will be called when the `Text` property changes.

----