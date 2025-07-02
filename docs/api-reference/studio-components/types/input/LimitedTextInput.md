<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">LimitedTextInputProperties</span>
</h1>

```lua
export type LimitedTextInputProperties = TextInputProperties & {
	GraphemeLimit: CanBeState&lt;number&gt;,
	TextLimit: CanBeState&lt;number&gt;,
}
```

The `LimitedTextInputProperties` table that is given to the [`LimitedTextInput()`](../../members/input/LimitedTextInput.md) function that contains data about the desired `LimitedTextInput`.

This type is also an extension of the [`TextInputProperties`](TextInput.md) type.

----

## Properties

<h3 markdown>
	GraphemeLimit
	<span class="api-property-type">
		: CanBeState&lt;number&gt;
	</span>
</h3>

Sets the [grapheme](https://en.wikipedia.org/wiki/Grapheme) limit for the `LimitedTextInput`. Can either be a `State` containing a `number`, or a `number`.

----

<h3 markdown>
	TextLimit
	<span class="api-property-type">
		: CanBeState&lt;number&gt;
	</span>
</h3>

Sets the text limit for the `LimitedTextInput`. Can either be a `State` containing a `number`, or a `number`.

----