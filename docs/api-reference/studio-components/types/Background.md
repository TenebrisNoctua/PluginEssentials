<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-note-24:</span>
    <span class="api-title">BackgroundProperties</span>
</h1>

```lua
export type BackgroundProperties = {
	StudioStyleGuideColor: CanBeState<Enum.StudioStyleGuideColor>?,
	StudioStyleGuideModifier: CanBeState<Enum.StudioStyleGuideModifier>?,
	[any]: any,
}
```

The `BackgroundProperties` table that is given to the [`Background()`](../members/Background.md) function that contains data about the desired `Background`.

----

## Properties

<h3 markdown>
    StudioStyleGuideColor
    <span class="api-property-type">
        : CanBeState&lt;Enum.StudioStyleGuideColor&gt;?
    </span>
</h3>

The [`Enum.StudioStyleGuideColor`](https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideColor) that will be used to calculate the color of the `Background`. Can either be a `State` containing the `Enum` or the `Enum`.

----

<h3 markdown>
    StudioStyleGuideModifier
    <span class="api-property-type">
        : CanBeState&lt;Enum.StudioStyleGuideModifier&gt;?
    </span>
</h3>

The [`Enum.StudioStyleGuideModifier`](https://create.roblox.com/docs/reference/engine/enums/StudioStyleGuideModifier) that will be used to calculate the color of the `Background`. Can either be a `State` containing the `Enum` or the `Enum`.

----