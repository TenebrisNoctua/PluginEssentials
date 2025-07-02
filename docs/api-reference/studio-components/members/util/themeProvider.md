<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">themeProvider</span>
    <span class="api-type">:</span><a href="" class="api-type">themeProvider</a>
</h1>

```lua
function themeProvider(Scope: Scope): themeProvider
```
Initializes themeProvider and returns a table containing its methods and properties.

## Default Syntax

```lua
local themeProviderUtility = require(StudioComponents.Util.themeProvider)
local themeProvider = themeProviderUtility(Scope)
```

## Shorthand

```lua
local themeProvider = require(StudioComponents.themeProvider)(Scope)
```

-----

## Parameters
<span markdown>
    <div class="md-typeset__table">
        <table>
            <tbody>
                <tr>
                    <td class="api-param-highlight">Scope: <a href="">Scope</a></td>
                    <td>The <code>Scope</code> the utility will be initialized in.</td>
                </tr>
            </tbody>
        </table>
    </div>
</span>

## Returns
<span markdown>
    <div class="md-typeset__table">
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a href="../../types/util/themeProvider.md">themeProvider</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>