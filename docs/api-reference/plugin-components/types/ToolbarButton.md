<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">ToolbarButtonProperties</span>
</h1>

```lua
export type ToolbarButtonProperties = {
	Active: CanBeState<boolean>?,
	Toolbar: PluginToolbar,
	ToolTip: string,
	Image: string,
	Name: string,
	[any]: any,
}
```

The `ToolbarButtonProperties` table that is given to the [`ToolbarButton()`](../members/ToolbarButton.md) function that contains data about the desired `ToolbarButton`.

----

## Properties

<h3 markdown>
	Name
	<span class="api-property-type">
		: string
	</span>
</h3>

The name of the `ToolbarButton`.

----

<h3 markdown>
	Image
	<span class="api-property-type">
		: string
	</span>
</h3>

The Image that will be on the `ToolbarButton`.

----

<h3 markdown>
	Tooltip
	<span class="api-property-type">
		: string
	</span>
</h3>

The tooltip that will appear when the user hovers over the `ToolbarButton`.

----

<h3 markdown>
	Toolbar
	<span class="api-property-type">
		: PluginToolbar
	</span>
</h3>

The toolbar that the `ToolbarButton` will be in.

----

<h3 markdown>
	Active
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether the `ToolbarButton` will be active or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----