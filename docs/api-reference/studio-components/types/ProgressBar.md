<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">ProgressProperties</span>
</h1>

```lua
export type ProgressProperties = {
	Progress: CanBeState<number>,
	MaximumProgress: CanBeState<number>,
	[any]: any,
}
```

The `ProgressProperties` table that is given to the [`ProgressBar()`](../members/ProgressBar.md) function that contains data about the desired `ProgressBar`.

----

## Properties

<h3 markdown>
	Progress
	<span class="api-property-type">
		: CanBeState&lt;number&gt;
	</span>
</h3>

Sets the progress for the `ProgressBar`. Can either be a `State` containing a `number`, or a `number`.

----

<h3 markdown>
	MaximumProgress
	<span class="api-property-type">
		: CanBeState&lt;number&gt;
	</span>
</h3>

Sets the maximum number that the `Progress` property can reach for the `ProgressBar`. Can either be a `State` containing a `number`, or a `number`.

----