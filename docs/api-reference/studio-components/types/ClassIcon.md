<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">ClassIconProperties</span>
</h1>

```lua
export type ClassIconProperties = {
	ClassName: CanBeState<string>,
	[any]: any,
}
```

The `ClassIconProperties` table that is given to the [`ClassIcon()`](../members/ClassIcon.md) function that contains data about the desired `ClassIcon`.

----

## Properties

<h3 markdown>
	ClassName
	<span class="api-property-type">
		: CanBeState<string>
	</span>
</h3>

The class name of the desired icon. Can either be a `State` containing a `string`, or a `string`.

----