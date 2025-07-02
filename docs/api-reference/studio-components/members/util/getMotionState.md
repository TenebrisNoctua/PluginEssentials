<h1 class="api-header" markdown>
    <span class="api-icon" markdown>:octicons-workflow-24:</span>
    <span class="api-title">getMotionState</span>
    <span class="api-type">:</span><a href="https://create.roblox.com/docs/luau/functions" class="api-type">function</a>
</h1>

```lua
function getMotionState(Scope: Scope): (goalState: State<any>, motionStateType: string, ...any) -> CanBeState<any>
```
Initializes the utility component and returns a new function to create a `State` from that component, which is used to easily create a motion from it. This provides an easy way of calling certain animations within Fusion, such as `Spring`.


## Default Syntax

```lua
local getMotionStateUtility = require(StudioComponents.Util.getMotionState)
local getMotionState = getMotionStateUtility(Scope)
```

## Shorthand

```lua
local getMotionState = require(StudioComponents.Util.getMotionState)(Scope)
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
                    <td class="api-param-highlight">goalState: <a href="">State&lt;any&gt;</a></td>
                    <td>The goal state to be reached.</td>
                </tr>
                <tr>
                    <td class="api-param-highlight">motionStateType: <a href="">string</a></td>
                    <td>The type of the motion function. Can either be "Tween" or "Spring".</td>
                </tr>
                <tr>
                    <td class="api-param-highlight">...<a href="">any</a></td>
                    <td>The other arguments to be passed to the motion function.</td>
                </tr>
            </tbody>
        </table>
        <h2 style="margin: 1.1em 0 .64em">Returns</h2>
        <table>
            <tbody>
                <tr>
                    <td class="api-return-box"><a>CanBeState&lt;any&gt;</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>