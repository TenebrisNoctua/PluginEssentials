<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">Toolbar</span>
    <span class="api-type">:</span><a href="" class="api-type">function</a>
</h1>

```lua
function Toolbar(Scope: Scope): (props: ToolbarProperties) -> PluginToolbar
```
Initializes the Toolbar component and returns a new function to create an instance of the component.

## Default Syntax

```lua
local ToolbarComponent = require(...Toolbar)
local Toolbar = ToolbarComponent(Scope)
```

## Shorthand

```lua
local Toolbar = require(...Toolbar)(Scope)
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

## Returns
<span markdown>
    <div class="md-typeset__table" id="api-returns-function-table">
        <table>
            <tbody>
                <tr>
                    <h2>Parameters</h2>
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
                </tr>
            </tbody>
        </table>
    </div>
</div>