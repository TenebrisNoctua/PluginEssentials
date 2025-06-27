# Button Components

Here are the tutorials of all the button components within the Studio Components library.

-----

## Button

This component allows you to create an already stylized button.

```lua
local Button = require(PluginEssentials.StudioComponents.Button)(Scope)

local newButton = Button {
	BackgroundColorStyle = Enum.StudioStyleGuideColor.Default,
	BorderColorStyle = Enum.StudioStyleGuideColor.Default,

    Text = "Hello!",
    TextSize = 24,
    TextColorStyle = Enum.StudioStyleGuideColor.Default,

    Enabled = true,

    Activated = function()
        print("Activated!")
    end,
} -- Returns a TextButton instance.
```

This component will accept any properties that a `TextButton` instance can have.
`...ColorStyle` properties allow you to change the color of certain parts of the button without having to directly modify the `TextColor3` property. This ensures the colors get dynamically updated if the Studio theme ever changes.

-----

## IconButton

This component allows you to create a button with only an icon.

```lua
local IconButton = require(PluginEssentials.StudioComponents.IconButton)(Scope)

local newIconButton = IconButton {
	BackgroundColorStyle = Enum.StudioStyleGuideColor.Default,
	BorderColorStyle = Enum.StudioStyleGuideColor.Default,

    Icon = "",
    Enabled = true,

    Activated = function()
        print("Activated!")
    end,
} -- Returns a TextButton instance.
```

This component will accept any properties that a `TextButton` instance can have.

-----

## MainButton

This component allows you to create a Button component with certain properties already set. This component can be used for dialog options.

```lua
local MainButton = require(PluginEssentials.StudioComponents.MainButton)(Scope)

local newMainButton = MainButton {
    Text = "MainButton",

    Activated = function()
        print("Activated!")
    end,
} -- Returns a TextButton instance.
```

This component will accept any properties that a `TextButton` instance can have.



