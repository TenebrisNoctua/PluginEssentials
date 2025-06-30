<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">WidgetProperties</span>
</h1>

```lua
export type WidgetProperties = {
	Id: string,
	Name: string,
	InitialDockTo: string | Enum.InitialDockState,
	InitialEnabled: boolean,
	ForceInitialEnabled: boolean,
	FloatingSize: Vector2,
	MinimumSize: Vector2,
	[any]: any,
}
```

The `WidgetProperties` table that is given to the [`Widget()`](../members/Widget.md) function that contains data about the desired `Widget`.

----

## Properties

<h3 markdown>
	Name
	<span class="api-property-type">
		: string
	</span>
</h3>

The name of the `Widget`.

----

<h3 markdown>
	Id
	<span class="api-property-type">
		: string
	</span>
</h3>

A unique and consistent identifier used to storing the `Widget`'s dock state and other internal details.

----

<h3 markdown>
	InitialDockTo
	<span class="api-property-type">
		: string | Enum.InitialDockState
	</span>
</h3>

Describes the initial docking state of a `Widget`. Can either be a `string` or an [Enum](https://create.roblox.com/docs/reference/engine/enums/InitialDockState).

----

<h3 markdown>
	InitialEnabled
	<span class="api-property-type">
		: boolean
	</span>
</h3>

The enabled state of the `Widget` if it does not have a saved state from a previous session.

----

<h3 markdown>
	ForceInitialEnabled
	<span class="api-property-type">
		: boolean
	</span>
</h3>

If true, will override any saved enabled state with the `InitialEnabled` value.

----

<h3 markdown>
	FloatingSize
	<span class="api-property-type">
		: Vector2
	</span>
</h3>

The initial pixel width and height of the `Widget` when floating.

----

<h3 markdown>
	MinimumSize
	<span class="api-property-type">
		: Vector2
	</span>
</h3>

The minimum pixel width and height of the `Widget`.

----