# Basic Components

The Studio Components library provide many useful components to make your plugin development experience easier.<br>
Here are tutorials on how you can use certain basic ones.

-----

## Background

This component will create an already stylized background frame. Like other components, you can configure its properties to change it to whatever you like.

```lua
local Background = require(PluginEssentials.StudioComponents.Background)(Scope)

local newBackground = Background {
	Name = "Menu",
	ClipsDescendants = false,
	Size = UDim2.new(0, 50, 0, 50),
} -- Returns a Frame instance.
```

The Background component accepts any properties that a `Frame` instance can have.

-----

## Shadow 

This component creates a shadow image. It can be used to create shadows for your other components, or objects.

```lua
local Shadow = require(PluginEssentials.StudioComponents.Shadow)(Scope)

local newShadow = Shadow {
	Side = "right"  -- Can be: "right", "left", "bottom", "top"
} -- Returns an ImageLabel instance.
```

The Shadow component will not accept any properties other than `Side`, `Transparency`, and `LayoutOrder`.

-----

## BoxBorder

This component creates a box border around your UI objects. It can be used around buttons, or to make checkboxes.

```lua
local BoxBorder = require(PluginEssentials.StudioComponents.BoxBorder)(Scope)

local newBoxBorder = BoxBorder {
	Color = Color3.fromRGB(255, 255, 255), -- If not set, it will automatically be determined depending on your Studio theme.
    Thickness = 1,
    CornerRadius = UDim.new(0, 2),

    [Children] = {
        Scope:New "Frame" { -- The border will be created around this Frame
            Size = UDim2.new(0, 50, 0, 50)
        }
    } 
} 
```

The BoxBorder component will not accept any properties other than `Color`, `Thickness`, and `CornerRadius`.<br>
If the `Color` property is not given, then the color will be determined based on your Studio theme. It will also automatically update when the theme is changed, so it is recommended to not set this property.

-----

## ClassIcon

This component allows you to easily create an image with the icon of the given class name.

```lua
local ClassIcon = require(PluginEssentials.StudioComponents.ClassIcon)(Scope)

local newClassIcon = ClassIcon {
	ClassName = "Part"
} -- Returns an ImageLabel instance.
```

The ClassIcon component will not accept any properties other than `ClassName`.

-----

## ScrollFrame

This component allows you to easily create a scrolling frame. Special properties such as `UILayout` and `UIPadding` allows you to control
the layout and the padding between the object within the scrolling frame.

```lua
local ScrollFrame = require(PluginEssentials.StudioComponents.ScrollFrame)(Scope)

local newScrollFrame = ScrollFrame {
	UILayout = Scope:New "UIListLayout" {},
    UIPadding = Scope:New "UIPadding" {},
    CanvasScaleConstraint = Enum.ScrollingDirection.X,
} -- Returns a Frame instance.
```

This component will accept any properties that a `ScrollingFrame` instance can have.

-----

## Label

This component allows you to create a text label.

```lua
local Label = require(PluginEssentials.StudioComponents.Label)(Scope)

local newLabel = Label {
    Text = "Hello!",
    TextSize = 24,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextColorStyle = Enum.StudioStyleGuideColor.MainText, -- Allows you to change the color of the text without having to modify the TextColor3 property. This property is recommended to use if you want to modify the color.
    Enabled = true,
} -- Returns a TextLabel instance.
```

This component will accept any properties that a `TextLabel` instance can have.
If the `TextColor3` property is not given, then the color will be determined based on your Studio theme. It will also automatically update when the theme is changed, so it is recommended to not set this property.

-----

## Title

This component allows you to create a big text label, meant for titles and text that is supposed to appear big.

```lua
local Title = require(PluginEssentials.StudioComponents.Title)(Scope)

local newTitle = Title {
    Text = "Hello!",
    TextSize = 24,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextColorStyle = Enum.StudioStyleGuideColor.MainText, -- Allows you to change the color of the text without having to modify the TextColor3 property. This property is recommended to use if you want to modify the color.
    Enabled = true,
} -- Returns a TextLabel instance.
```

This component will accept any properties that a `TextLabel` instance can have.
If the `TextColor3` property is not given, then the color will be determined based on your Studio theme. It will also automatically update when the theme is changed, so it is recommended to not set this property.

-----

!!! info
    All given properties can also be states due to Fusion. This allows you to create reactive components that has properties that will immediately update whenever a change occurs to that state's value.

