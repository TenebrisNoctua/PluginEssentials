<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">VerticalExpandingListProperties</span>
</h1>

```lua
export type VerticalExpandingListProperties = {
	Enabled: CanBeState<boolean>?,
	Padding: CanBeState<UDim>?,
	[any]: any,
}
```

The `VerticalExpandingListProperties` table that is given to the [`VerticalExpandingList()`](../members/VerticalExpandingList.md) function that contains data about the desired `VerticalExpandingList` component.

----

## Properties

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether the `VerticalExpandingList` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	Padding
	<span class="api-property-type">
		: CanBeState&lt;UDim&gt;?
	</span>
</h3>

The padding between instances inside the `VerticalExpandingList`. Can either be a `State` containing an `UDim`, or an `UDim`.

----