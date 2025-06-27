# PluginEssentials (For Fusion 0.3)
[![GitHub Issues](https://img.shields.io/github/issues/TenebrisNoctua/PluginEssentials.svg)](https://github.com/TenebrisNoctua/PluginEssentials/issues)
[![GitHub Stars](https://img.shields.io/github/stars/TenebrisNoctua/PluginEssentials.svg)](https://github.com/TenebrisNoctua/PluginEssentials/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A migrated version of PluginEssentials (by @mvyasu) to Fusion 0.3.

The usage is similar to the previous version, except now every component requires a Scope table to use the components.
If there are any bugs to any components, feel free to create a new issue. I'll see what I can do.

-------------------------------------------------------------------------------------------------------------

This is a repository with components that many people find essential to making plugins with [Fusion](https://github.com/Elttob/Fusion). You'll find in the src folder that there's two folders. Each one has a specific set of components which you can learn more about below.

Below is a basic documentation for the components, for more details, you can visit the full documentation site by clicking [here](https://tenebrisnoctua.github.io/PluginEssentials/latest).

### Community Usage (For Fusion 0.2)

The usage of this library can be found in a few projects by the developer community. Here are a few plugins that use this library in some shape or form:

- [Benchmarker](https://devforum.roblox.com/t/benchmarker-plugin-compare-function-speeds-with-graphs-percentiles-and-more/829912) by @boatbomber
- [LampLight](https://devforum.roblox.com/t/lamplight-global-illumination-for-roblox-new-v12/1837877) by @MrChickenRocket
- [MeshVox](https://devforum.roblox.com/t/meshvox-v10-a-powerful-3d-smooth-terrain-importstamping-tool/2576245) by @tyridge77

## PluginComponents

These components use specific properties to create their corresponding plugin object. Afterwards, they use Hydrate on the created object and return it. You don't need to use these components, but the most useful one by far is the Widget component.

| Component | Description | Returns |
| --- | --- | --- |
| [Widget](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/PluginComponents/Widget.luau) | A PluginGui that displays its contents inside a dockable Roblox Studio window. | DockWidgetPluginGui |
| [Toolbar](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/PluginComponents/Toolbar.luau) | An object used to create PluginToolbarButtons. | PluginToolbar |
| [ToolbarButton](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/PluginComponents/ToolbarButton.luau) | An object that allows the user to initiate a single, one-off action in Roblox Studio through the Click event. | PluginToolbarButton |

## StudioComponents

This is a Fusion port of [StudioComponents](https://github.com/sircfenner/StudioComponents) by sircfenner. This is by no means a 1-1 port, but it's close enough to where you should be able to port over a plugin that uses StudioComponents with ease. There is bound to be mistakes, but hopefully those can be ironed out in the future.

| Component | Description | Returns |
| --- | --- | --- |
| [Background](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Background.luau) | A borderless Frame with a background color that matches the user's current theme. | Frame |
| [Label](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Label.luau) | A simple text label following Studio style guidelines for body text. | TextLabel |
| [Title](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Title.luau) | A simple text label following Studio style guidelines for title text. | TextLabel |
| [BaseButton](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/BaseButton.luau) | A TextButton that reacts to different states like hover, press, and disabled. | TextButton |
| [Button](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Button.luau) | BaseButton, but with a different name. | TextButton |
| [MainButton](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/MainButton.luau) | BaseButton, but uses the style of a main button, which is usually a blue background color. | TextButton |
| [IconButton](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/IconButton.luau) | A button with an image on it instead of text. | TextButton |
| [Checkbox](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Checkbox.luau) | A checkbox that reacts to different states like hover, checked, indeterminate, and disabled. | Frame |
| [ClassIcon](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/ClassIcon.luau) | An image of a given ClassName from the user's installed Studio icon set. | ImageLabel |
| [Shadow](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Shadow.luau) | A subtle shadow positioned on the side of your choosing. | ImageLabel |
| [Loading](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Loading.luau) | An animated component to display whilst something else loads. | Frame |
| [Dropdown](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Dropdown/init.luau) | A button that shows the selected item and a list of items in a dropdown when clicking on it. | Frame |
| [ColorPicker](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/ColorPicker.luau) | An HSV color picker that uses a value slider. | Frame |
| [BaseScrollFrame](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/BaseScrollFrame/init.luau) | A custom scrolling frame that uses Roblox's ScrollingFrame for input and padding. | Frame |
| [ScrollFrame](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/ScrollFrame.luau) | Same as BaseScrollFrame, but has properties that will determine the CanvasSize for the BaseScrollFrame. | Frame |
| [Slider](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/Slider.luau) | A slider that reacts to being dragged. | TextButton |
| [ProgressBar](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/ProgressBar.luau) | A bar that fills up with an accent color. | TextBox |
| [TextInput](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/TextInput.luau) | A TextBox that reacts to states like hover, focus, and disabled. | TextBox |
| [LimitedTextInput](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/LimitedTextInput.luau) | TextInput, but contains properties for limiting the length of input to the TextBox. | TextBox |
| [VerticalExpandingList](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/VerticalExpandingList.luau) | A Frame that uses AutomaticSize for the Y axis and contains a UIListLayout. | Frame |
| [VerticalCollapsibleSection](https://github.com/TenebrisNoctua/PluginEssentials/blob/main/src/StudioComponents/VerticalCollapsibleSection.luau) | A frame that contains a header and a content frame. The content frame can be collapsed by clicking on the header.  | Frame |
