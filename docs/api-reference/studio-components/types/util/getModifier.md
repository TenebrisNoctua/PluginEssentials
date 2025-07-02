<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">ModifierInput</span>
</h1>

```lua
export type ModifierInput = {
	Enabled: CanBeState<boolean>?,
	Hovering: CanBeState<boolean>?,
	Selected: CanBeState<boolean>?,
	Pressed: CanBeState<boolean>?,
	Otherwise: CanBeState<Enum.StudioStyleGuideModifier>?,
}
```

The `ModifierInput` table that is given to the [`getModifier()`](../../members/util/getModifier.md) function that contains data about the desired value from the utility function.

----

## Properties

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets whether or not the component for the modifier is enabled.

----

<h3 markdown>
	Hovering
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets whether or not the component for the modifier is hovering.


----

<h3 markdown>
	Selected
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets whether or not the component for the modifier is selected.

----

<h3 markdown>
	Pressed
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets whether or not the component for the modifier is pressed.

----

<h3 markdown>
	Otherwise
	<span class="api-property-type">
		: CanBeState<Enum.StudioStyleGuideModifier>?
	</span>
</h3>

If none of the above properties are satisfied, then this property will be used.<br>
For example:
* If the component is enabled, but not hovered, selected, or pressed.

If this property is not set, then the default modifier will be applied.

----