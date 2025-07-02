<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">ScrollFrameProperties</span>
</h1>

```lua
export type ScrollFrameProperties = BaseScrollFrameProperties & {
	CanvasScaleConstraint: CanBeState<Enum.ScrollingDirection>?,
	UIPadding: UIPadding?,
	UILayout: UILayout?,
}
```

The `ScrollFrameProperties` table that is given to the [`ScrollFrame()`](../../members/scrollframe/ScrollFrame.md) function that contains data about the desired `ScrollFrame`.

This type is also an extension of the [`BaseScrollFrameProperties`](BaseScrollFrame.md) type.

----

## Properties

<h3 markdown>
	CanvasScaleConstraint
	<span class="api-property-type">
		: CanBeState&lt;Enum.ScrollingDirection&gt;?
	</span>
</h3>

Constraints the `CanvasScale` property of the `ScrollFrame` by the set scrolling direction. Can either be a `State` containing the [`Enum`](https://create.roblox.com/docs/reference/engine/enums/ScrollingDirection), or the `Enum`.

----

<h3 markdown>
	UIPadding
	<span class="api-property-type">
		: UIPadding?
	</span>
</h3>

The `UIPadding` instance that will be applied to the `ScrollFrame`. 

----

<h3 markdown>
	UILayout
	<span class="api-property-type">
		: UILayout?
	</span>
</h3>

The `UILayout` instance that will be applied to the `ScrollFrame`. 

----