<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">Shadow</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function Shadow(Scope: Scope): (props: ShadowProperties) -> ImageLabel
```
Initializes the component and returns a new function to create that component, which is a subtle shadow positioned on the side of your choosing.

## Default Syntax

```lua
local ShadowComponent = require(StudioComponents.Shadow)
local Shadow = ShadowComponent(Scope)
```

## Shorthand

```lua
local Shadow = require(StudioComponents.Shadow)(Scope)
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
                    <td class="api-param-highlight">props: <a href="../../types/Shadow">ShadowProperties</a></td>
                    <td>The table which contains the properties of the component that will be created.</td>
                </tr>
            </tbody>
        </table>
        <h2 style="margin: 1.1em 0 .64em">Returns</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a href="https://create.roblox.com/docs/reference/engine/classes/ImageLabel">ImageLabel</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>