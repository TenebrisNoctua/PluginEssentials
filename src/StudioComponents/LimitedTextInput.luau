local External = require(script.Parent.Parent.External)
local Fusion = External.getLibrary("Fusion") :: Fusion

local StudioComponents = script.Parent
local StudioComponentsUtil = StudioComponents:FindFirstChild("Util")

local ComponentTypes = script.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

-- Scoped components
local TextInputComponent = require(StudioComponents.TextInput)
local getStateUtil = require(StudioComponentsUtil.getState)

local unwrap = require(StudioComponentsUtil.unwrap)

local OnChange = Fusion.OnChange

type LimitedTextInputProperties = Types.LimitedTextInputProperties
type Scope = Types.Scope
type Fusion = Types.Fusion

return function(Scope: Scope): (props: LimitedTextInputProperties) -> any
	local getState = getStateUtil(Scope)
	local TextInput = TextInputComponent(Scope)

	return function(props: LimitedTextInputProperties)
		local currentText = getState(props.Text, "", "Value")

		local createProps = table.clone(props)
		createProps.Text = currentText
		createProps.GraphemeLimit = nil
		createProps.TextLimit = nil
		createProps.OnChange = nil

		local function limitText(newText: string)
			local desiredGraphemeLimit = unwrap(props.GraphemeLimit)
			local desiredTextLimit = unwrap(props.TextLimit)

			local hasDesiredTextLimit = (desiredTextLimit and desiredTextLimit > -1)
			local hasDesiredGraphemeLimit = (desiredGraphemeLimit  and desiredGraphemeLimit > -1)
			local newCurrentText = newText

			if hasDesiredTextLimit or hasDesiredGraphemeLimit then
				local textWithTextLimit = newText:sub(1, if hasDesiredTextLimit then desiredTextLimit else #newText)

				if hasDesiredGraphemeLimit then
					local graphemesToLength = {}
					for first, last in utf8.graphemes(textWithTextLimit) do
						table.insert(graphemesToLength, last)
					end

					local cutoffLength = graphemesToLength[desiredGraphemeLimit] or graphemesToLength[#graphemesToLength]
					local textWithGraphemeLimit = textWithTextLimit:sub(1, cutoffLength)

					newCurrentText = textWithGraphemeLimit
				else
					newCurrentText = textWithTextLimit
				end
			end
			return newCurrentText
		end

		local textBoxRef = TextInput(createProps)
		local lastUpdateText = textBoxRef.Text

		local function updateWithLimitedText(newText: string)
			local newCurrentText = limitText(newText or textBoxRef.Text)

			textBoxRef.Text = newCurrentText
			currentText:set(newCurrentText)

			if lastUpdateText ~= unwrap(currentText) then
				lastUpdateText = newCurrentText
				if props.OnChange then
					props.OnChange(newCurrentText)
				end
			end
		end

		updateWithLimitedText(textBoxRef.Text)

		return Scope:Hydrate(textBoxRef) {
			[OnChange "Text"] = updateWithLimitedText,
		}
	end
end
