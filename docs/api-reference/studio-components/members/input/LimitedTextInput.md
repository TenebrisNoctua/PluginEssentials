<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">LimitedTextInput</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function LimitedTextInput(Scope: Scope): (props: LimitedTextInputProperties) -> Frame
```
Initializes the component and returns a new function to create that component, which is a TextInput, but contains properties for limiting the length of input to the TextBox.

## Default Syntax

```lua
local LimitedTextInputComponent = require(StudioComponents.LimitedTextInput)
local LimitedTextInput = LimitedTextInputComponent(Scope)
```

## Shorthand

```lua
local LimitedTextInput = require(StudioComponents.LimitedTextInput)(Scope)
```

-----

## Parameters
<span markdown>
    <div class="md-typeset__table">
        <table>
            <tbody>
                <tr>
                    <td class="api-param-highlight">Scope: <a href="">Scope</a></td>
                    <td>The <code>Scope</code> the component will be initialized in.</td>
                </tr>
            </tbody>
        </table>
    </div>
</span>

## Returns Function
<span markdown>
    <div class="md-typeset__table" id="api-returns-function-table">
        <h2 style="margin: 1.1em 0 .64em">Parameters</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-param-highlight">props: <a href="../../../types/input/LimitedTextInput">LimitedTextInputProperties</a></td>
                    <td>The table which contains the properties of the component that will be created.</td>
                </tr>
            </tbody>
        </table>
        <h2 style="margin: 1.1em 0 .64em">Returns</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a href="https://create.roblox.com/docs/reference/engine/classes/TextBox">TextBox</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>