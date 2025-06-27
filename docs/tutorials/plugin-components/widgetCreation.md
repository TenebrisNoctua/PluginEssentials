# Widget Creation

Plugin Essentials make creating widgets very easy, using the `Widget` component.

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

As you most likely noticed, unlike in the other version of PluginEssentials, you need to initialize the component with a `Scope` in this version. This is due to Fusion now requiring a `Scope` table to create objects. Every component will require to be initialized with a `Scope` first, then you can use the component function returned after initialization to create your component.

!!! info
    It is recommended to use the same Scope for the same use-case components. Creating a new Scope after every component is strongly not recommended.

-----

To create a new basic widget, you use the `Widget()` function with the syntax in the above example. All components like `Widget` will accept a properties table that you can use to define properties or even children.

In that example, we created a new widget with the name "Tools", and then defined the properties such as `InitialDockTo` and `InitialEnabled` to customize the widget.

## Adding Children

Like it has been mentioned above, you can add children to a `Widget` to add other components or objects to it. Like `Widget`, all components can have children, like normal Fusion objects.

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

