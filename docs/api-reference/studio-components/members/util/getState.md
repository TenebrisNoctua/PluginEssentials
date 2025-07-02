<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">getState</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function getState(Scope: Scope): (inputValue: CanBeState<any>, defaultValue: CanBeState<any>, mustBeKind: string?) -> CanBeState<any>
```

This utility function ensures that you get the correct Fusion object type at all costs.

* If the input type is a `State`, and the `mustBeKind` is also set to "State", then the `inputValue` will be returned.
* If the input type is a `State`, but the `mustBeKind` is set to something else, then the utility function will create a new object from the kind set in the `mustBeKind`, with the value from the `inputValue`, and return it.
* If both of these are false, but the `defaultValue` is a `State`, then the `defaultValue` will be returned.
* If all of the above are false, but the `defaultValue` still exists, then the utility function will create a new object from the kind either set in the `mustBeKind`, or the kind "Value" by default, with the value from the `defaultValue` and return it.


## Default Syntax

```lua
local getStateUtility = require(StudioComponents.Util.getState)
local getState = getStateUtility(Scope)
```

## Shorthand

```lua
local getState = require(StudioComponents.Util.getState)(Scope)
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
                    <td class="api-param-highlight">inputValue: <a href="">CanBeState<any></a></td>
                    <td>The input value to be checked.</td>
                </tr>
                <tr>
                    <td class="api-param-highlight">defaultValue: <a href="">CanBeState<any></a></td>
                    <td>If the input value is not provided or not valid, then this value will be used.</td>
                </tr>
                <tr>
                    <td class="api-param-highlight">mustBeKind: <a href="">string?</a></td>
                    <td>This parameter ensures that the provided values must be a certain Fusion type.</td>
                </tr>
            </tbody>
        </table>
        <h2 style="margin: 1.1em 0 .64em">Returns</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a><code>CanBeState<any></code></a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>