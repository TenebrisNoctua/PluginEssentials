<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">TextInputProperties</span>
</h1>

```lua
export type TextInputProperties = {
	Enabled: CanBeState<boolean>?,
	Text: CanBeValue<string>?,
	TextXAlignment: CanBeValue<Enum.TextXAlignment>?,
	CornerRadius: CanBeState<UDim>?,
	PaddingLeft: CanBeState<UDim>?,
	PaddingRight: CanBeState<UDim>?,
	OnChange: (newText: string) -> nil,
	OnFocusLost: (newText: string) -> nil,
	Filter: (newText: string) -> boolean,
	[any]: any,
}
```

The `TextInputProperties` table that is given to the [`TextInput()`](../../members/input/TextInput.md) function that contains data about the desired `TextInput`.

----

## Properties

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether the `TextInput` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	Text
	<span class="api-property-type">
		: CanBeValue&lt;string&gt;?,
	</span>
</h3>

The default text that will be displayed on the `TextInput`. Can either be a `Value` containing a `string`, or a `string`.
This property can be changed by the end-user.

----

<h3 markdown>
	TextXAlignment
	<span class="api-property-type">
		: CanBeValue&lt;Enum.TextXAlignment&gt;?,
	</span>
</h3>

The default text alignment of the `TextInput`. Can either be a `Value` containing an `Enum`, or an `Enum`.

----


<h3 markdown>
	CornerRadius
	<span class="api-property-type">
		: CanBeState&lt;UDim&gt;?
	</span>
</h3>

Sets the corner radius of the `TextInput`. Can either be a `State` containing an `UDim`, or an `UDim`.

----

<h3 markdown>
	PaddingLeft
	<span class="api-property-type">
		: CanBeState&lt;UDim&gt;?,
	</span>
</h3>

How much padding will be applied to the descendants of the `TextInput` on the left side. Can either be a `State` containing an `UDim`, or an `UDim`.

----

<h3 markdown>
	PaddingRight
	<span class="api-property-type">
		: CanBeState&lt;UDim&gt;?,
	</span>
</h3>

How much padding will be applied to the descendants of the `TextInput` on the right side. Can either be a `State` containing an `UDim`, or an `UDim`.

----

<h3 markdown>
	OnChange
	<span class="api-property-type">
		: (newText: string) -> nil,
	</span>
</h3>

The callback function that will be called when the `Text` property changes.

----

<h3 markdown>
	OnFocusLost
	<span class="api-property-type">
		: ((newText: string) -> nil)?,
	</span>
</h3>

The callback function that will be called when the focus has been lost on the `TextInput`, when Enter has been pressed.
If the `Filter` callback function has been set, then this function will only be called after `Filter` callback function returns `true`.

----

<h3 markdown>
	Filter
	<span class="api-property-type">
		: ((newText: string) -> boolean)?,
	</span>
</h3>

The callback function that will be called when the focus has been lost on the `TextInput`, when Enter has been pressed.
This function is called first if defined, and allows you to filter the incoming text on the `TextInput`.

If this function returns `true`, then the text will be deemed filtered, and the `OnFocusLost` callback function will be called, if it exists. And the `Text` property of the `TextInput` will be set to the `newText`.

If this function returns `false`, then the `Text` property will automatically be reverted to its previous state.

----