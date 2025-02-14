-- Roact version by @sircfenner
-- Ported to Fusion by @YasuYoshida
-- Migrated to Fusion 0.3 by @TenebrisNoctua

local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

-- Scoped components
local ScrollFrameComponent = require(StudioComponents.ScrollFrame)
local DropdownItemComponent = require(script.DropdownItem)
local BoxBorderComponent = require(StudioComponents.BoxBorder)

local themeProviderComponent = require(StudioComponentsUtil.themeProvider)
local getStateUtil = require(StudioComponentsUtil.getState)
local getModifierUtil = require(StudioComponentsUtil.getModifier)
local getMotionStateUtil = require(StudioComponentsUtil.getMotionState)

local getSelectedState = require(StudioComponentsUtil.getSelectedState)
local stripProps = require(StudioComponentsUtil.stripProps)
local unwrap = require(StudioComponentsUtil.unwrap)
local types = require(StudioComponentsUtil.types)
local constants = require(StudioComponentsUtil.constants)
local dropdownConstants = require(script.Constants)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local COMPONENT_ONLY_PROPERTIES = {
	"Enabled",
	"MaxVisibleItems",
	"Options",
	"Value",
	"ZIndex",
	"OnSelected",
	"HideDropdownWhenMouseLeaves",
	"Size",
}

type DropdownProperties = {
	Enabled: types.CanBeState<boolean>?,
	Value: types.CanBeState<any>?,
	Options: types.CanBeState<{any}>,
	MaxVisibleItems: types.CanBeState<number>?,
	HideDropdownWhenMouseLeaves: types.CanBeState<boolean>?,
	OnSelected: (selectedOption: any) -> nil,
	[any]: any,
}

return function (Scope: { [any]: any }): (props: DropdownProperties) -> Frame
	local BoxBorder = BoxBorderComponent(Scope)
	local ScrollFrame = ScrollFrameComponent(Scope)
	local DropdownItem = DropdownItemComponent(Scope)

	local themeProvider = themeProviderComponent(Scope)
	local getModifier = getModifierUtil(Scope)
	local getState = getStateUtil(Scope)
	local getMotionState = getMotionStateUtil(Scope)

	return function (props: DropdownProperties): Frame
		local isInputEnabled = getState(props.Enabled, true)
		local isHovering = Scope:Value(false)
		local isOpen = Scope:Value(false)
		
		local isEmpty = Scope:Computed(function(use, scope)
			return next(unwrap(props.Options or {}, use)) == nil
		end)

		local isEnabled = Scope:Computed(function(use, scope)
			local isInputEnabled = unwrap(isInputEnabled, use)
			local isEmpty = unwrap(isEmpty, use)
			return isInputEnabled and not isEmpty
		end)

		local modifier = getModifier {
			Enabled = isEnabled,
			Hovering = isHovering,
		}

		local backgroundStyleGuideColor = Scope:Computed(function(use, scope)
			local isHovering = unwrap(isHovering, use)
			local isOpen = unwrap(isOpen, use)
			if isOpen or isHovering then
				return Enum.StudioStyleGuideColor.InputFieldBackground
			end
			return Enum.StudioStyleGuideColor.MainBackground
		end)
		
		local inputValue = getState(props.Value, nil, "Value")
		local disconnectGetSelectedState = nil
		
		local selectedOption, onSelectedOption do
			onSelectedOption = function(selectedOption, use)
				isOpen:set(false)
				inputValue:set(selectedOption)
				
				if use then use(inputValue) end
				
				if props.OnSelected then
					props.OnSelected(selectedOption)
				end
			end

			selectedOption = Scope:Computed(getSelectedState {
				Value = inputValue,
				Options = props.Options,
				OnSelected = onSelectedOption,
			})
			--just in case there's never a dependency for selectedOption
			--props.OnSelected should always be ran even if there isn't a dependency
			disconnectGetSelectedState = Scope:Observer(selectedOption):onChange(function() end)
		end

		local spaceBetweenTopAndDropdown = 5
		local dropdownPadding = UDim.new(0, 2)
		local dropdownHeaderSize = Scope:Computed(function(use, scope)
			local propsSize = unwrap(props.Size, use)
			return propsSize or UDim2.new(1, 0, 0, dropdownConstants.RowHeight)
		end)

		local parentAbsoluteSize = Scope:Value(Vector2.zero)

		local dropdownHeaderAbsoluteSize = Scope:Computed(function(use, scope)
			local currentParentAbsoluteSize = unwrap(parentAbsoluteSize, use) or Vector2.zero
			local currentHeaderSize = unwrap(dropdownHeaderSize, use)

			return Vector2.new(
				currentHeaderSize.X.Offset + (currentHeaderSize.X.Scale * currentParentAbsoluteSize.X),
				currentHeaderSize.Y.Offset + (currentHeaderSize.Y.Scale * currentParentAbsoluteSize.Y)
			)
		end)

		local useableDropdownHeaderSize = Scope:Computed(function(use, scope)
			local currentHeaderAbsoluteSize = unwrap(dropdownHeaderAbsoluteSize, use)
			local currentHeaderSize = unwrap(dropdownHeaderSize, use)

			return UDim2.fromOffset(currentHeaderAbsoluteSize.X, currentHeaderAbsoluteSize.Y)
		end)

		local dropdownItems = Scope:Computed(function(use, scope)
			local itemList = {}
			local dropdownOptionList = unwrap(props.Options, use)
			if unwrap(isOpen, use) then
				for i, item in ipairs(dropdownOptionList) do
					itemList[i] = {
						OnSelected = onSelectedOption,
						LayoutOrder = i,
						Item = item,

						Size = scope:Computed(function(use, scope)
							return UDim2.new(1, 0, 0, unwrap(dropdownHeaderAbsoluteSize, use).Y)
						end),
					}
				end
			end
			return itemList
		end)

		local maxVisibleRows = Scope:Computed(function(use, scope)
			return unwrap(props.MaxVisibleItems, use) or dropdownConstants.MaxVisibleRows
		end)

		local rowPadding = 1
		local scrollHeight = Scope:Computed(function(use, scope)
			local itemSize = unwrap(dropdownHeaderAbsoluteSize, use)
			local visibleItems = math.min(unwrap(maxVisibleRows, use), #unwrap(dropdownItems, use))
			return visibleItems * (itemSize.Y) -- item heights
				+ (visibleItems - 1) * rowPadding -- row padding
				+ (dropdownPadding.Offset * 2) -- top and bottom
		end)

		local dropdownContainerSize = Scope:Computed(function(use, scope)
			local topDropdownSize = unwrap(dropdownHeaderAbsoluteSize, use)
			local dropdownHeight = unwrap(scrollHeight, use)
			
			if topDropdownSize and dropdownHeight then
				local dropdownTotalHeight = topDropdownSize.Y + dropdownHeight + spaceBetweenTopAndDropdown
				return UDim2.fromOffset(topDropdownSize.X, dropdownTotalHeight)
			end
			return UDim2.new()
		end)

		local zIndex = Scope:Computed(function(use, scope)
			return unwrap(props.ZIndex, use) or 5
		end)

		local function getOptionName(_option: any, use: any?)
			local option = unwrap(_option, use)
			if typeof(option) == "table" and (option.Label or option.Name or option.Title) then
				return tostring(option.Label or option.Name or option.Title)
			elseif typeof(option) == "Instance" or typeof(option) == "EnumItem" then
				return option.Name
			end
			return tostring(option)
		end

		local newDropdown = Scope:New "Frame" {
			Name = "Dropdown",
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			AutomaticSize = Enum.AutomaticSize.X,

			Size = Scope:Computed(function(use, scope)
				local dropdownContainerSize = unwrap(dropdownContainerSize, use)
				if unwrap(isOpen, use) then
					return dropdownContainerSize
				end
				return unwrap(useableDropdownHeaderSize, use)
			end),
			[Children] = {
				-- this frame hides the dropdown if the mouse leaves it
				-- maybe this should be done with a mouse click instead
				-- but I don't know the cleanest way to do that right now
				Scope:New "Frame" {
					Name = "DropdownHeader",
					BackgroundTransparency = 1,

					Size = useableDropdownHeaderSize,

					[OnEvent "InputBegan"] = function(inputObject)
						if not unwrap(isEnabled) then
							return
						elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							isHovering:set(true)
						elseif inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
							isOpen:set(not unwrap(isOpen))
						end
					end,
				
					[OnEvent "InputEnded"] = function(inputObject)
						if not unwrap(isEnabled) then
							return
						elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							isHovering:set(false)
						end
					end,

					[Children] = {
						BoxBorder {
							Color = themeProvider:GetColor(Enum.StudioStyleGuideColor.CheckedFieldBorder, modifier),
						
							[Children] = Scope:New "TextLabel" {
								Name = "Selected",
								Size = UDim2.fromScale(1, 1),
								TextSize = constants.TextSize,
								TextXAlignment = Enum.TextXAlignment.Left,
							
								BackgroundColor3 = getMotionState(themeProvider:GetColor(backgroundStyleGuideColor, modifier), "Spring", 40),
								TextColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.MainText, modifier),
								Font = themeProvider:GetFont("Default"),
								Text = Scope:Computed(function(use, scope)
									return getOptionName(selectedOption, use)
								end),
							
								[Children] = Scope:New "UIPadding" {
									PaddingLeft = UDim.new(0, dropdownConstants.TextPaddingLeft),
									PaddingRight = UDim.new(0, dropdownConstants.TextPaddingRight),
								}
							}
						},
						Scope:New "Frame" {
							Name = "ArrowContainer",
							AnchorPoint = Vector2.new(1, 0),
							Position = UDim2.fromScale(1, 0),
							Size = UDim2.new(0, 18, 1, 0),
							BackgroundTransparency = 1,
						
							[Children] = Scope:New "ImageLabel" {
								Name = "Arrow",
								Image = "rbxassetid://7260137654",
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromOffset(8, 4),
								BackgroundTransparency = 1,
								ImageColor3 = themeProvider:GetColor(Enum.StudioStyleGuideColor.TitlebarText, modifier),
							}
						},
						--Scope:Computed(function(use, scope)
						--if unwrap(isOpen, use) then
						--[[return]] BoxBorder {
							[Children] = ScrollFrame {
								ZIndex = zIndex,
								Name = "Drop",
								BorderSizePixel = 0,
								Visible = isOpen,
								Position = UDim2.new(0, 0, 1, spaceBetweenTopAndDropdown),
								Size = Scope:Computed(function(use, scope)
									return UDim2.new(1, 0, 0, unwrap(scrollHeight, use))
								end),
							
								ScrollBarBorderMode = Enum.BorderMode.Outline,
								CanvasScaleConstraint = Enum.ScrollingDirection.X,
							
								UILayout = Scope:New "UIListLayout" {
									Padding = UDim.new(0, rowPadding),	
								},
							
								UIPadding = Scope:New "UIPadding" {
									PaddingLeft = dropdownPadding,
									PaddingRight = dropdownPadding,
									PaddingTop = dropdownPadding,
									PaddingBottom = dropdownPadding,
								},
								[Children] = Scope:ForValues(dropdownItems, function(use, scope, props)
									props.ZIndex = unwrap(zIndex, use) + 1
									props.Text = getOptionName(props.Item) 
									return DropdownItem(props)
								end),
							}
						}
						--end
						--return nil
						--end)
					}
				},

				Scope:New "Frame" {
					Name = "WholeDropdownInput",
					BackgroundTransparency = 1,

					Size = dropdownContainerSize,

					[OnEvent "InputEnded"] = function(inputObject)
						if not unwrap(isOpen) then 
							return
						elseif inputObject.UserInputType == Enum.UserInputType.MouseMovement then
							if not unwrap(props.HideDropdownWhenMouseLeaves) then return end
							isOpen:set(false)
						end
					end,
				}
			},
		}

		do --this is a bit hacky, but it gets the size of the parent and subtracts UIPadding
			local listenToParentCleanupList = {}
			local function cleanupObject(object: any)
				local t = typeof(object)
				if t == "function" then
					object()
				elseif t == "RBXScriptConnection" then
					object:Disconnect()
				elseif t == "table" or t =="Instance" then
					if object.Destroy then
						object:Destroy()
					else
						local cleanupList = table.clone(object)
						table.clear(object)

						for _, child in cleanupList do
							cleanupObject(child)
						end
					end
				elseif t == "thread" then
					coroutine.close(object)
				end
			end

			local lastParent = nil
			local function onAncestryChanged()
				local currentParent = newDropdown.Parent :: Instance
				local previousParent = lastParent :: Instance?
				lastParent = currentParent

				if currentParent ~= previousParent then
					cleanupObject(listenToParentCleanupList)

					if currentParent == nil or not currentParent:IsA("GuiBase") then return end

					local function updateParentAbsoluteSize()
						local currentUIPadding = currentParent:FindFirstChildOfClass("UIPadding") :: UIPadding

						local currentAbsoluteSize = if currentParent:IsA("ScrollingFrame") then currentParent.AbsoluteCanvasSize else currentParent.AbsoluteSize
						local horizontalOffsetPadding = 0
						local verticalOffsetPadding = 0
						
						if currentUIPadding then
							local function paddingToOffset(padding: UDim, absoluteSize): number
								return padding.Offset + padding.Scale * absoluteSize
							end

							horizontalOffsetPadding = paddingToOffset(currentUIPadding.PaddingLeft, currentAbsoluteSize.X) + paddingToOffset(currentUIPadding.PaddingRight, currentAbsoluteSize.X)
							verticalOffsetPadding = paddingToOffset(currentUIPadding.PaddingTop, currentAbsoluteSize.Y) + paddingToOffset(currentUIPadding.PaddingBottom, currentAbsoluteSize.Y)
						end

						parentAbsoluteSize:set(Vector2.new(
							math.max(0, currentAbsoluteSize.X - horizontalOffsetPadding),
							math.max(0, currentAbsoluteSize.Y - verticalOffsetPadding)
						))
					end

					table.insert(listenToParentCleanupList, currentParent:GetPropertyChangedSignal(if currentParent:IsA("ScrollingFrame") then "AbsoluteCanvasSize" else "AbsoluteSize"):Connect(updateParentAbsoluteSize))
					
					local listenToUIPaddingCleanupList = {}
					table.insert(listenToParentCleanupList, listenToUIPaddingCleanupList)
					
					local lastUIPadding = nil
					local function onChildChanged()
						local currentUIPadding = currentParent:FindFirstChildOfClass("UIPadding")
						local previousUIPadding = lastUIPadding
						lastUIPadding = currentUIPadding

						if currentUIPadding ~= previousUIPadding then
							cleanupObject(listenToUIPaddingCleanupList)

							if currentUIPadding == nil then return end

							table.insert(listenToUIPaddingCleanupList, currentUIPadding.Changed:Connect(updateParentAbsoluteSize))
						end
					end

					table.insert(listenToParentCleanupList, currentParent.ChildAdded:Connect(onChildChanged))
					table.insert(listenToParentCleanupList, currentParent.ChildRemoved:Connect(onChildChanged))

					task.spawn(updateParentAbsoluteSize)
				end
			end

			task.spawn(onAncestryChanged)

			table.insert(Scope, newDropdown.AncestryChanged:Connect(onAncestryChanged))
			cleanupObject(listenToParentCleanupList)

			Scope:Hydrate(newDropdown)
		end

		return Scope:Hydrate(newDropdown)(stripProps(props, COMPONENT_ONLY_PROPERTIES))
	end
end