return {PluginComponents = script.PluginComponents, StudioComponents = script.StudioComponents}

-- Updated types
-- ColorPicker now properly uses the Step property
-- make the other pages (from VerticalCollapsibleSection)
-- update the member pages to contain links to the type pages
-- update the member pages to contain a bit more info about the components here and there.
-- also fix the CanBeState<type> not showing the type in between the brackets, probably html issue with treating them as elements instead of words lol.
-- then check some other components in Studio to see if they work (Dropdown, ColorPicker, ProgressBar), if they don't work, fix them and update to 1.3.0 along with other changes to the types.