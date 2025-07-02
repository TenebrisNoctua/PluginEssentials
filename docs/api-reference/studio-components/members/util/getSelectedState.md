<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">getSelectedState</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function getSelectedState(props: GetSelectedStateProperties): (use: Use, innerScope: Scope) -> any
```
This utility function is used to select an option from an options list. It returns a callback function generally meant to be used within `Computed`s. This function also keeps track of the given values, and if they change, re-calculates the result. 

## Default Syntax

```lua
local getSelectedState = require(StudioComponents.Util.getSelectedState)
local returnedFunction = Scope:Computed(getSelectedState(props))
```

-----

## Parameters
<span markdown>
    <div class="md-typeset__table">
        <table>
            <tbody>
                <tr>
                    <td class="api-param-highlight">props: <a href="../../types/util/getSelectedState.md">GetSelectedStateProperties</a></td>
                    <td>The table which contains the properties that will be used within the returned callback function.</td>
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
                    <td class="api-param-highlight">use: <a href="">Use</a></td>
                    <td>The use function that will be given automatically.</td>
                </tr>
                <tr>
                    <td class="api-param-highlight">innerScope: <a href="">Scope</a></td>
                    <td>The inner scope that will be given automatically.</td>
                </tr>
            </tbody>
        </table>
        <h2 style="margin: 1.1em 0 .64em">Returns</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a href="">any</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>