<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">LoadingProperties</span>
</h1>

```lua
export type LoadingProperties = {
	Enabled: CanBeState<boolean>?,
	[any]: any,
}
```

The `LoadingProperties` table that is given to the [`Loading()`](../members/Loading.md) function that contains data about the desired `Loading` component.

----

## Properties

<h3 markdown>
	Enabled
	<span class="api-property-type">
		: CanBeState&lt;boolean&gt;?
	</span>
</h3>

Sets whether the `Loading` will be enabled or not. Can either be a `State` containing a `boolean`, or a `boolean`.

----