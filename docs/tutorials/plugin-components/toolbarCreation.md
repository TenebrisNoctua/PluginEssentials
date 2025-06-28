# Toolbar Creation

To configure our `Widget` from the Studio Ribbon, we must create a `Toolbar`, and buttons within that `Toolbar`.
Fortunately, like `Widget`, there are components called `Toolbar` and `ToolbarButton` that allow you to do exactly this.

Here's an example on how you can create a toolbar and a toolbar button:

```lua
local Fusion = require(someFolder.Fusion)
local Scope = Fusion:scoped()

local WindowComponent = require(PluginEssentials.PluginComponents.Window)
local ToolbarComponent = require(PluginEssentials.PluginComponents.Toolbar)
local ToolbarButtonComponent = require(PluginEssentials.PluginComponents.ToolbarButton)

local Window = WindowComponent(Scope)
local Toolbar = ToolbarComponent(Scope)
local ToolbarButton = ToolbarButtonComponent(Scope)

local pluginToolbar = Toolbar {
	Name = "Tools Toolbar"
}

local enableButton = ToolbarButton {
	Toolbar = pluginToolbar,

	ClickableWhenViewportHidden = true,

	Name = "Tools",
	ToolTip = "Show or hide the Tools window",
	Image = "",
}
```

In the example above, we created a new toolbar called "Tools Toolbar" with the "Tools" button.

!!! warning
    Creating a `Toolbar` in Studio with the Next Gen Ribbon enabled will do nothing as the behavior for it has not been implemented yet.

## Configuring a Window with Toolbar Buttons

Now that we have created our toolbar button, it is time to connect it to a `Window`, so it can be used to enable or disable it.

```lua
local Fusion = require(someFolder.Fusion)
local Scope = Fusion:scoped()

local WindowComponent = require(PluginEssentials.PluginComponents.Window)
local ToolbarComponent = require(PluginEssentials.PluginComponents.Toolbar)
local ToolbarButtonComponent = require(PluginEssentials.PluginComponents.ToolbarButton)

local Window = WindowComponent(Scope)
local Toolbar = ToolbarComponent(Scope)
local ToolbarButton = ToolbarButtonComponent(Scope)

local widgetsEnabled = Scope:Value(false)

local pluginToolbar = Toolbar {
	Name = "Tools Toolbar"
}

local enableButton = ToolbarButton {
	Toolbar = pluginToolbar,

	ClickableWhenViewportHidden = true,

	Name = "Tools",
	ToolTip = "Show or hide the Tools window",
	Image = "",

    [OnEvent "Click"] = function()
		widgetsEnabled:set(not Fusion.peek(widgetsEnabled))
	end,
}

local newWidget = Widget {
	Name = "Tools",
    
	InitialDockTo = Enum.InitialDockState.Float,
	InitialEnabled = false,
	ForceInitialEnabled = false,
	FloatingSize = Vector2.new(720, 710),
	MinimumSize = Vector2.new(720, 710),

	Enabled = widgetsEnabled,

	[OnChange "Enabled"] = function(isEnabled)
		widgetsEnabled:set(isEnabled)
	end,
}
```

In the example above, we created a toolbar, a toolbar button and a widget to display. We also created a value to check and set if the widget is enabled or not. Since Fusion is a state-based UI library, whenever the `widgetsEnabled` state changes, automatically the `Widget` will set its visibility depending on the value of the state.

!!! info
    To create components easier, you can directly require and call a component with a `Scope`, like below.
    ```lua
    local Fusion = require(someFolder.Fusion)
    local Scope = Fusion:scoped()

    -- More efficient and easier to write!
    local Window = require(PluginEssentials.PluginComponents.Window)(Scope)
    local Toolbar = require(PluginEssentials.PluginComponents.Toolbar)(Scope)
    local ToolbarButton = require(PluginEssentials.PluginComponents.ToolbarButton)(Scope)
    ```

