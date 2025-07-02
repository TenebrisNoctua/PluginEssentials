<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">BaseScrollFrameProperties</span>
</h1>

```lua
export type BaseScrollFrameProperties = {
	ScrollBarBorderMode: CanBeState<Enum.BorderMode>?,
	CanvasSize: CanBeState<UDim2>?,
	ScrollingEnabled: CanBeState<boolean>?,
	ScrollBarThickness: CanBeState<number>?,
	VerticalScrollBarPosition: CanBeState<Enum.VerticalScrollBarPosition>?,
	VerticalScrollBarInset: CanBeState<Enum.ScrollBarInset>?,
	CornerRadius: CanBeState<UDim>?,
	[any]: any,
}
```

The `BaseScrollFrameProperties` table that is given to the [`BaseScrollFrame()`](../../members/scrollframe/BaseScrollFrame.md) function that contains data about the desired `BaseScrollFrame`.

----

## Properties

<h3 markdown>
	ScrollBarBorderMode
	<span class="api-property-type">
		: CanBeState<Enum.BorderMode>?
	</span>
</h3>

Sets the border mode of the `BaseScrollFrame`. Can either be a `State` containing the [`Enum`](https://create.roblox.com/docs/reference/engine/enums/BorderMode), or the `Enum`.

----

<h3 markdown>
	CanvasSize
	<span class="api-property-type">
		: CanBeState<UDim2>?
	</span>
</h3>

Sets the canvas size of the `BaseScrollFrame`. Can either be a `State` containing an `UDim2`, or an `UDim2`.

----

<h3 markdown>
	ScrollingEnabled
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets the whether or not the user can scroll within the `BaseScrollFrame`. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
	ScrollBarThickness
	<span class="api-property-type">
		: CanBeState<number>?
	</span>
</h3>

Sets the thickness of the `ScrollBar` within the `BaseScrollFrame`. Can either be a `State` containing a `number`, or a `number`.

----

<h3 markdown>
	VerticalScrollBarPosition
	<span class="api-property-type">
		: CanBeState<Enum.VerticalScrollBarPosition>?
	</span>
</h3>

Sets the position of the `ScrollBar` within the `BaseScrollFrame`. Can either be a `State` containing the [`Enum`](https://create.roblox.com/docs/reference/engine/enums/VerticalScrollBarPosition), or the `Enum`.

----

<h3 markdown>
	VerticalScrollBarInset
	<span class="api-property-type">
		: CanBeState<Enum.ScrollBarInset>?
	</span>
</h3>

Sets whether the canvas should be inset by the `ScrollBarThickness` for the respective `ScrollBar` within the `BaseScrollFrame`. Can either be a `State` containing the [`Enum`](https://create.roblox.com/docs/reference/engine/enums/ScrollBarInset), or the `Enum`.

----

<h3 markdown>
	CornerRadius
	<span class="api-property-type">
		: CanBeState<UDim>?
	</span>
</h3>

Sets the canvas size of the `BaseScrollFrame`. Can either be a `State` containing an `UDim2`, or an `UDim2`.

----