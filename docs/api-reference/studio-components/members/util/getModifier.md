<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">getModifier</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function getModifier(Scope: Scope): (props: ModifierInput) -> Computed<any>
```
Initializes the utility component and returns a new function to create a modifier state from that component, which is used to keep track of the changes that may occur in the `props` table's values. This is used to get a `StudioStyleGuideModifier` that changes depending on the given values within the `props` table.


## Default Syntax

```lua
local getModifierUtility = require(StudioComponents.Util.getModifier)
local getModifier = getModifierUtility(Scope)
```

## Shorthand

```lua
local getModifier = require(StudioComponents.Util.getModifier)(Scope)
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
                    <td class="api-param-highlight">props: <a href="../../../types/util/getModifier">ModifierInput</a></td>
                    <td>The table which contains the properties of the component that will be created.</td>
                </tr>
            </tbody>
        </table>
        <h2 style="margin: 1.1em 0 .64em">Returns</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a><code>Computed<any></code></a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>