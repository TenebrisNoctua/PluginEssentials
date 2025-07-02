<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">Title</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function Title(Scope: Scope): (props: LabelProperties) -> TextLabel
```
Initializes the component and returns a new function to create that component, which is a simple text label following Studio style guidelines for title text.

## Default Syntax

```lua
local TitleComponent = require(StudioComponents.Title)
local Title = TitleComponent(Scope)
```

## Shorthand

```lua
local Title = require(StudioComponents.Title)(Scope)
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
                    <td class="api-param-highlight">props: <a href="../../types/Label">LabelProperties</a></td>
                    <td>The table which contains the properties of the component that will be created.</td>
                </tr>
            </tbody>
        </table>
        <h2 style="margin: 1.1em 0 .64em">Returns</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a href="https://create.roblox.com/docs/reference/engine/classes/TextLabel">TextLabel</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>