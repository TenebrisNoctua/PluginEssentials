<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">DragInputProperties</span>
</h1>

```lua
export type DragInputProperties = {
	Instance: CanBeState<GuiObject>,
	Enabled: CanBeState<boolean>?,
	OnChange: ((newValue: Vector2) -> Vector2?)?,
	getUseFunction: () -> Use?,
	Value: CanBeValue<Vector2>,
	Min: CanBeValue<Vector2>,
	Max: CanBeValue<Vector2>,
	Step: CanBeValue<Vector2>,
}
```

The `DragInputProperties` table that is given to the [`getDragInput()`](../../members/util/getDragInput.md) function that contains data about the desired values from the utility function.

----

## Properties

<h3 markdown>
    Instance
    <span class="api-property-type">
        : CanBeState<GuiObject>
    </span>
</h3>

The `Instance` the drag detection will be running on.

----

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState<boolean>?
	</span>
</h3>

Sets whether the drag input will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----

<h3 markdown>
    OnChange
    <span class="api-property-type">
        : ((newValue: Vector2) -> Vector2?)?
    </span>
</h3>

The callback function that will be called when the `Value` changes.

----

<h3 markdown>
    getUseFunction
    <span class="api-property-type">
        : () -> Use?
    </span>
</h3>

Settings this property will cause the `State`, that the returned `Use` function is from, to depend on certain internal values while the drag is happening. So when these internal values change, the `State` which the `Use` function belongs to will re-run again.

----

<h3 markdown>
	Value
	<span class="api-property-type">
		: CanBeValue<Vector2>
	</span>
</h3>

The initial value of the drag input. Can either be a `Value` containing a `Vector2`, or a `Vector2`.

----

<h3 markdown>
    Min
    <span class="api-property-type">
        : CanBeValue<Vector2>
    </span>
</h3>

The minimum position that the drag can be started from.

----

<h3 markdown>
    Max
    <span class="api-property-type">
        : CanBeValue<Vector2>
    </span>
</h3>

The maximum position that the drag can be started from.

----

<h3 markdown>
    Step
    <span class="api-property-type">
        : CanBeValue<Vector2>
    </span>
</h3>

Determines how much the `Value` will change when drag is applied.

----