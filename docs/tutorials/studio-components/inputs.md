# Input Components

Here are the tutorials of all the input components within the Studio Components library.

-----

## TextInput

This component allows you to get input from the user.

```lua
local TextInput = require(PluginEssentials.StudioComponents.TextInput)(Scope)

local newTextInput = TextInput {
    PlaceholderText = "Write something here!",
    Enabled = true,

    OnChange = function(newText)
        print("new text: ", newText)
    end,
} -- Returns a TextBox instance.
```

This component will accept any properties that a `TextBox` instance can have.

-----

## LimitedTextInput

This component allows you to get input from the user, but there can be set limitations.

```lua
local LimitedTextInput = require(PluginEssentials.StudioComponents.LimitedTextInput)(Scope)

local newLimitedTextInput = LimitedTextInput {
    PlaceholderText = "Write something here!",
    Enabled = true,
    TextLimit = 15,
    GraphemeLimit = 15,

    OnChange = function(newText)
        print("new text: ", newText)
    end,
} -- Returns a TextBox instance.
```

This component will accept any properties that a `TextBox` instance can have.
The text entered inside this component will not exceed the set limits. This can be used to limit the amount of words/letters a user can enter.
