<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">TextInput</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function TextInput(Scope: Scope): (props: TextInputProperties) -> TextBox
```
Initializes the component and returns a new function to create that component, which is a TextBox that reacts to states like hover, focus, and disabled.

## Default Syntax

```lua
local TextInputComponent = require(StudioComponents.TextInput)
local TextInput = TextInputComponent(Scope)
```

## Shorthand

```lua
local TextInput = require(StudioComponents.TextInput)(Scope)
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
                    <td class="api-param-highlight">props: <a href="../../../types/input/TextInput">TextInputProperties</a></td>
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