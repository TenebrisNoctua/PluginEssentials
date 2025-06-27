# Advanced Components

Here are the tutorials of all the components within the Studio Components library that are considered a little bit advanced over the others.

-----

## Checkbox

This component creates an already stylized checkbox. This can be used to create a settings system.

```lua
local Checkbox = require(PluginEssentials.StudioComponents.Checkbox)(Scope)

local newCheckbox = Checkbox {
    Alignment = Enum.HorizontalAlignment.Left,
	Text = "Check me!"
	Value = false,

    OnChange = function(newValue)
        print("new value: ", newValue)
    end,
} -- Returns a Frame instance.
```

The checkbox component accepts any properties that a `Frame` instance can have.

-----

## ColorPicker

This component creates a color picker frame that allows the user to pick a color.

```lua
local ColorPicker = require(PluginEssentials.StudioComponents.ColorPicker)(Scope)

local newColorPicker = ColorPicker {
    ListDisplayMode = Enum.ListDisplayMode.Vertical,
	OnChange = function(newColor)
	    print("Color:", "#"..newColor:ToHex())
	end,
} -- Returns a Frame instance.
```

The color picker component accepts any properties that a `Frame` instance can have.

-----

## Loading

This component plays a loading animation on the screen.

```lua
local Loading = require(PluginEssentials.StudioComponents.Loading)(Scope)

local newLoading = Loading {
    Enabled = true
} -- Returns a Frame instance.
```

The loading component accepts any properties that a `Frame` instance can have.

-----

## ProgressBar

This component displays a progress bar. 

```lua
local ProgressBar = require(PluginEssentials.StudioComponents.ProgressBar)(Scope)

local newProgressBar = ProgressBar {
    Progress = 0.5 -- From 0 to 1
} -- Returns a Frame instance.
```

The progress bar component accepts any properties that a `Frame` instance can have.

-----

## Slider

This component creates a slider that the user can slide to interact with.

```lua
local Slider = require(PluginEssentials.StudioComponents.Slider)(Scope)

local newSlider = Slider {
    Value = 5, -- The current value the slider will be on by default.
	Min = 1, -- The minimum value the slider can go to.
	Max = 20, -- The maximum value the slider can go to.
	Step = 1, -- How much the value will increase when slider moves.
	Size = UDim2.new(0, 100, 0, 25), -- The size of the slider frame.
	Position = UDim2.fromScale(0.2, 0.2), -- The position of the slider frame.

	OnChange = function(newValue)
        print("new value: ", newValue)
    end,
} -- Returns a Frame instance.
```

The slider component accepts any properties that a `Frame` instance can have.

-----

## VerticalCollapsibleSection

This component creates a section that is collapsible and expandable. It can be used as different option menus.

```lua
local VerticalCollapsibleSection = require(PluginEssentials.StudioComponents.VerticalCollapsibleSection)(Scope)

local newVCS =  VerticalCollapsibleSection {
    Text = "Checkbox Components",
    [Children] = {
        Checkbox {
            Value = Scope:Value(nil),
            Text = "Indeterminate"
        },
        Checkbox {
            Text = "Checked",
        },
        Checkbox {
            Text = "Unchecked",
            Value = false
        },
        Checkbox {
            Text = "Checked Disabled",
            Value = true,
            Enabled = Scope:Value(false),
            OnChange = function(currentValue)
                print("Toggled: ", currentValue)
            end,
        },
        Checkbox {
            Text = "Disabled Unchecked",
            Enabled = false,
            Value = false
        },
        Checkbox {
            Text = "Right Alignment",
            Alignment = Enum.HorizontalAlignment.Right,
        },
    }
},-- Returns a Frame instance.
```

The vertical collapsible section component accepts any properties that a `Frame` instance can have, and special properties such as `Text`, `Padding` and `Collapsed`.

-----

## VerticalExpandingList 

This component creates an expanding vertical component list.

```lua
local VerticalExpandingList = require(PluginEssentials.StudioComponents.VerticalExpandingList)(Scope)

local newVEL =  VerticalExpandingList {
    [Children] = {
        Checkbox {
            Value = Scope:Value(nil),
            Text = "Indeterminate"
        },
        Checkbox {
            Text = "Checked",
        },
        Checkbox {
            Text = "Unchecked",
            Value = false
        },
        Checkbox {
            Text = "Checked Disabled",
            Value = true,
            Enabled = Scope:Value(false),
            OnChange = function(currentValue)
                print("Toggled: ", currentValue)
            end,
        },
        Checkbox {
            Text = "Disabled Unchecked",
            Enabled = false,
            Value = false
        },
        Checkbox {
            Text = "Right Alignment",
            Alignment = Enum.HorizontalAlignment.Right,
        },
    }
},-- Returns a Frame instance.
```

The vertical expanding list component accepts any properties that a `Frame` instance can have, and special properties such as `Padding` and `AutomaticSize`.





