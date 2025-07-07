<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">setFusion</span>
    <span class="api-type">:</span><a href="" class="api-type">void</a>
</h1>

```lua
function PluginEssentials.setFusion(fusion: Fusion): ()
```
Sets the reference for the Fusion library that will be used to create the components.

!!! warning
    Setting the Fusion version to a higher or a lower version than the intended version (0.3) may cause bugs.

## Default Syntax

```lua
local PluginEssentials = require(...pluginessentials)
PluginEssentials.setFusion(fusionModuleLocation)
```

-----

## Parameters
<span markdown>
    <div class="md-typeset__table">
        <table>
            <tbody>
                <tr>
                    <td class="api-param-highlight">fusion: <a href="">Fusion</a></td>
                    <td>The <code>Fusion</code> library that will be used.</td>
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
                    <td class="api-return-box"><a href="">void</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>