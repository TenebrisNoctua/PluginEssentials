<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">ToolbarButton</span>
    <span class="api-type">:</span><a href="" class="api-type">(props: ToolbarButtonProperties) -> PluginToolbarButton</a>
</h1>

```lua
function ToolbarButton(Scope: Scope): (props: ToolbarButtonProperties) -> PluginToolbarButton
```
Initializes the ToolbarButton component and returns a new function to create an instance of the component.

## Default Syntax

```lua
local ToolbarButtonComponent = require(...ToolbarButton)
local ToolbarButton = ToolbarButtonComponent(Scope)
```

## Shorthand

```lua
local ToolbarButton = require(...ToolbarButton)(Scope)
```

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

## Returns
<span markdown>
    <div class="md-typeset__table">
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a href="">ToolbarButtonCreator</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>