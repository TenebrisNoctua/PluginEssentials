--!strict

-- Written by @TenebrisNoctua
-- Types for the components.

--// Require the fusion types

local FusionTypes = require(script.Parent.Fusion)

--// General Use Types

type Set<T> = {[T]: any}
type StyleGuideColorInput = (Enum.StudioStyleGuideColor | StateObject<Enum.StudioStyleGuideColor>)
type NumberInput = (number | StateObject<number>)

--// Fusion Types

type StateObject<T> = FusionTypes.StateObject<T>
type CanBeState<T> = StateObject<T> | T

export type State<T> = StateObject<T>
export type Value<T> = FusionTypes.Value<T>
export type Computed<T> = FusionTypes.Computed<T>
export type Scope = FusionTypes.Scope<FusionTypes.Fusion>
export type Use = FusionTypes.Use

--// Plugin Component Types

export type ToolbarProperties = {
	Name: string,
	[any]: any,
}

export type ToolbarButtonProperties = {
	Active: CanBeState<boolean>?,
	Toolbar: PluginToolbar,
	ToolTip: string,
	Image: string,
	Name: string,
	[any]: any,
}

export type WidgetProperties = {
	Id: string,
	Name: string,
	InitialDockTo: string | Enum.InitialDockState,
	InitialEnabled: boolean,
	ForceInitialEnabled: boolean,
	FloatingSize: Vector2,
	MinimumSize: Vector2,
	[any]: any,
}

--// Util Types

export type DragInputProperties = {
	Instance: GuiObject,
	Enabled: (boolean | StateObject<boolean>)?,
	OnChange: ((newValue: Vector2) -> Vector2?)?,
	getUseFunction: () -> ((state: any) -> ())?,
	Value: (Vector2 | Value<Vector2>),
	Min: (Vector2 | Value<Vector2>),
	Max: (Vector2 | Value<Vector2>),
	Step: (Vector2 | Value<Vector2>),
}

export type ModifierInput = {
	Enabled: CanBeState<boolean>?,
	Hovering: CanBeState<boolean>?,
	Selected: CanBeState<boolean>?,
	Pressed: CanBeState<boolean>?,
	Otherwise: CanBeState<Enum.StudioStyleGuideModifier>?,
}

export type GetSelectedStateProperties = {
	Value: Value<any>?,
	Options: CanBeState<{any}>?,
	OnSelected: ((selectedOption: any, use: Use?) -> nil)?,
}

--// Studio Component Types

-- ScrollFrames

export type BaseScrollFrameProperties = {
	ScrollBarBorderMode: CanBeState<Enum.BorderMode>?,
	CanvasSize: CanBeState<UDim2>?,
	ScrollingEnabled: CanBeState<boolean>?,
	ScrollBarThickness: CanBeState<number>?,
	VerticalScrollBarPosition: CanBeState<Enum.VerticalScrollBarPosition>?,
	VerticalScrollBarInset: CanBeState<Enum.ScrollBarInset>?,
	CornerRadius: UDim,
	[any]: any,
}

export type ScrollFrameProperties = BaseScrollFrameProperties & {
	CanvasScaleConstraint: CanBeState<Enum.ScrollingDirection?>?,
	UIPadding: UIPadding?,
	UILayout: UILayout?,
}

export type ScrollArrowProperties = {
	Enabled: CanBeState<boolean>?,
	Direction: CanBeState<string>,
	Activated: () -> nil,
	[any]: any,
}

export type ScrollBarProperties = {
	VerticalScrollBarPosition: CanBeState<Enum.VerticalScrollBarPosition>?,
	BorderMode: CanBeState<Enum.BorderMode>?,
	CanvasPosition: CanBeState<UDim2>,
	AbsoluteSize: CanBeState<Vector2>,
	AbsoluteCanvasSize: CanBeState<Vector2>,
	WindowSize: CanBeState<Vector2>,
	ScrollBarThickness: CanBeState<number>,
	BarVisibility: {
		Horizontal: CanBeState<boolean>,
		Vertical: CanBeState<boolean>,
	},
	IsVertical: boolean,
	[any]: any,
}

-- Dropdown

export type DropdownProperties = {
	Enabled: CanBeState<boolean>?,
	Value: CanBeState<any>?,
	Options: CanBeState<{any}>,
	MaxVisibleItems: CanBeState<number>?,
	HideDropdownWhenMouseLeaves: CanBeState<boolean>?,
	OnSelected: (selectedOption: any) -> nil,
	[any]: any,
}

export type DropdownItemProperties = {
	OnSelected: (selectedOption: any) -> nil,
	Item: any,
	[any]: any,
}

-- Background

export type BackgroundProperties = {
	StudioStyleGuideColor: CanBeState<Enum.StudioStyleGuideColor>?,
	StudioStyleGuideModifier: CanBeState<Enum.StudioStyleGuideModifier>?,
	[any]: any,
}

-- Buttons

export type BaseButtonProperties = {
	Activated: (() -> nil)?,
	Enabled: (boolean | StateObject<boolean>)?,
	TextColorStyle: StyleGuideColorInput?,
	BackgroundColorStyle: StyleGuideColorInput?,
	BorderColorStyle: StyleGuideColorInput?,
	TextSize: number,
	[any]: any,
}

export type IconButtonProperties = {
	Activated: (() -> nil)?,
	Enabled: (boolean | StateObject<boolean>)?,
	TextColorStyle: StyleGuideColorInput,
	BackgroundColorStyle: StyleGuideColorInput,
	BorderColorStyle: StyleGuideColorInput,
	IconColor3: Color3?,
	[any]: any,
}

-- Boxes

export type BoxBorderProperties = {
	Color: CanBeState<Color3>?,
	Thickness: CanBeState<number>?,
	CornerRadius: CanBeState<UDim>?,
	[FusionTypes.Child]: GuiObject,
}

export type CheckboxProperties = {
	OnChange: ((newValue: boolean) -> nil)?,
	Alignment: (Enum.HorizontalAlignment | StateObject<Enum.HorizontalAlignment>)?,
	Enabled: (boolean | StateObject<boolean>)?,
	Text: (string | StateObject<string>)?,
	Value: (boolean | Value<boolean>)?,
	[any]: any,
}

-- ClassIcon

export type ClassIconProperties = {
	ClassName: string | StateObject<string>,
	[any]: any,
}

-- ColorPicker

export type ColorPickerProperties = {
	ListDisplayMode: (Enum.ListDisplayMode | StateObject<Enum.ListDisplayMode>)?,
	Enabled: (boolean | StateObject<boolean>)?,
	OnChange: (newColor: Color3) -> nil,
	Value: (Color3 | Value<Color3>)?,
	Step: (Vector2 | Value<Vector2>)?,
	[any]: any,
}

-- Label

export type LabelProperties = {
	Enabled: (boolean | StateObject<boolean>)?,
	[any]: any,
}

-- Inputs

export type TextInputProperties = {
	Enabled: (boolean | StateObject<boolean>)?,
	OnChange: (newText: string) -> nil,
	[any]: any,
}

export type LimitedTextInputProperties = TextInputProperties & {
	Text: (string | Value<string>)?,
	GraphemeLimit: NumberInput,
	TextLimit: NumberInput,
}

-- Loading

export type LoadingProperties = {
	Enabled: CanBeState<boolean>?,
	[any]: any,
}

-- ProgressBar

export type ProgressProperties = {
	Progress: (number | StateObject<number>)?,
	[any]: any,
}

-- Shadow

export type ShadowProperties = {
    Side: string,
	Transparency: number?,
	[any]: any,
}

-- Slider

export type SliderProperties = {
	HandleSize: CanBeState<UDim2>?,
	Enabled: CanBeState<boolean>?,
	OnChange: ((newValue: number) -> nil)?,
	Value: CanBeState<number>?,
	Min: NumberInput,
	Max: NumberInput,
	Step: NumberInput,
	[any]: any,
}

-- VerticalExpandingList

export type VerticalExpandingListProperties = {
	Enabled: (boolean | StateObject<boolean>)?,
	Padding: (UDim | StateObject<UDim>)?,
	[any]: any,
}

-- VerticalCollapsibleSection

export type VerticalCollapsibleSectionProperties = VerticalExpandingListProperties & {
	Text: (string | StateObject<string>)?,
	TextColor3: (Color3 | StateObject<Color3>)?,
	Collapsed: (boolean | Value<boolean>)?,
	[any]: any,
}

return nil