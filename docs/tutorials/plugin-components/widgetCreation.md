# Widget Creation

The Plugin Components library make creating widgets very easy with the `Widget` component.

Here's an example of a plugin widget:

```lua
local Fusion = require(someFolder.Fusion)
local Scope = Fusion:scoped()

local WidgetComponent = require(PluginEssentials.PluginComponents.Widget)
local Widget = WidgetComponent(Scope)

local newWidget = Widget {
	Name = "Tools",
	InitialDockTo = Enum.InitialDockState.Float,
	InitialEnabled = false,
	ForceInitialEnabled = false,
	FloatingSize = Vector2.new(720, 710),
	MinimumSize = Vector2.new(720, 710),
}
```

To create a new basic widget, you use the `Widget()` function with the syntax in the above example. All components like `Widget` will accept a properties table that you can use to define properties or even children.

-----

With the introduction of `Scope`s in Fusion 0.3, all components must now be initialized with a `Scope` first, and then using the returned component function, you can create an instance of that component.

!!! info
    It is recommended to use the same Scope for the same use-case components. Creating a new Scope after every component is strongly not recommended.

-----


## Adding Children

Like it has been mentioned above, you can add children to a `Widget`, or any other component. Components accept properties and children in the same way as normal Fusion objects do.

```lua
local Fusion = require(someFolder.Fusion)
local Scope = Fusion:scoped()

local WidgetComponent = require(PluginEssentials.PluginComponents.Widget)
local BackgroundComponent = require(PluginEssentials.StudioComponents.Background)

local Widget = WidgetComponent(Scope)
local Background = BackgroundComponent(Scope)

local newWidget = Widget {
	Name = "Tools",
	InitialDockTo = Enum.InitialDockState.Float,
	InitialEnabled = false,
	ForceInitialEnabled = false,
	FloatingSize = Vector2.new(720, 710),
	MinimumSize = Vector2.new(720, 710),

    [Children] = {
        Scope:New "TextLabel" {
            Text = "Hello!",
            TextScaled = true,
            Position = UDim2.fromScale(0.5, 0.5),
        },
        Background {
            [Children] = {
                Scope:New "TextLabel" {
                    Text = "Goodbye!",
                    TextScaled = true,
                    Position = UDim2.fromScale(0.5, 0.5),
                },
            }
        }
    }
}
```

Like in the example above, all components can have a children table, and their children can be of Fusion objects.

