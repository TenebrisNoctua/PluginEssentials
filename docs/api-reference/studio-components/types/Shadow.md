<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">ShadowProperties</span>
</h1>

```lua
export type ShadowProperties = {
    Side: string,
	Transparency: number?,
	[any]: any,
}
```

The `ShadowProperties` table that is given to the [`Shadow()`](../members/Shadow.md) function that contains data about the desired `Shadow` component.

----

## Properties

<h3 markdown>
	Side
	<span class="api-property-type">
		: string
	</span>
</h3>

Sets the side in which the `Shadow` will be visible on. Can be set to `"left"`, `"right"`, `"top"`, or `"bottom"`.

----

<h3 markdown>
	Transparency
	<span class="api-property-type">
		: number?
	</span>
</h3>

Sets the transparency of the `Shadow`.

----