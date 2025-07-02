<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">getDragInput</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function getDragInput(Scope: Scope): (props: DragInputProperties) -> (Value<Vector2>, Computed<Vector2>, Value<boolean>)
```
Initializes the utility component and returns a new function to create values from that component, which are used to get dragging input from a certain area on the screen.

## Default Syntax

```lua
local getDragInputUtility = require(StudioComponents.Util.getDragInput)
local getDragInput = getDragInputUtility(Scope)
```

## Shorthand

```lua
local getDragInput = require(StudioComponents.Util.getDragInput)(Scope)
```

-----

## Parameters
<span markdown>
    <div class="md-typeset__table">
        <table>
            <tbody>
                <tr>
                    <td class="api-param-highlight">Scope: <a href="">Scope</a></td>
                    <td>The <code>Scope</code> the utility function will be initialized in.</td>
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
                    <td class="api-param-highlight">props: <a href="../../../types/util/getDragInput">DragInputProperties</a></td>
                    <td>The table which contains the properties of the component that will be created.</td>
                </tr>
            </tbody>
        </table>
        <h2 style="margin: 1.1em 0 .64em">Returns</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a href="https://create.roblox.com/docs/luau/tuples">(Value&lt;Vector2&gt;, Computed&lt;Vector2&gt;, Value&lt;boolean&gt;)</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>