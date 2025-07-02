<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">VerticalCollapsibleSectionProperties</span>
</h1>

```lua
export type VerticalCollapsibleSectionProperties = VerticalExpandingListProperties & {
	Text: CanBeState<string>?,
	TextColor3: CanBeState<Color3>?,
	Collapsed: CanBeValue<boolean>?,
	[any]: any,
}
```

The `VerticalCollapsibleSectionProperties` table that is given to the [`VerticalCollapsibleSection()`](../members/VerticalCollapsibleSection.md) function that contains data about the desired `VerticalCollapsibleSection` component.

This type is also an extension of the [`VerticalExpandingListProperties`](../types/VerticalExpandingList.md) type.

----

## Properties

<h3 markdown>
	Text
	<span class="api-property-type">
		: CanBeState<string>?
	</span>
</h3>

The text that will be displayed on the `VerticalCollapsibleSection`. Can either be a `State` containing a `string`, or a `string`.

----

<h3 markdown>
	TextColor3
	<span class="api-property-type">
		: CanBeState<Color3>?
	</span>
</h3>

The color of the text on the `VerticalCollapsibleSection`. Can either be a `State` containing a `Color3`, or a `Color3`. Setting this property is not recommended, as it will overwrite the default color defined by the theme of the Studio.

----

<h3 markdown>
	Collapsed
	<span class="api-property-type">
		: CanBeValue<boolean>?
	</span>
</h3>

Sets whether or not the `VerticalCollapsibleSection` is collapsed. Can either be a `Value` containing a `number`, or a `number`.

----

<h4>This component name sure is long...</h4>