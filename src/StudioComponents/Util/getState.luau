local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local ComponentTypes = script.Parent.Parent.Parent.ComponentTypes

local Types = require(ComponentTypes.Types)
local unwrap = require(script.Parent.unwrap)

type StateOrAny = Types.State<any> | any
type Scope = Types.Scope

return function(Scope: Scope): (inputValue: StateOrAny, defaultValue: StateOrAny, mustBeKind: string?) -> StateOrAny
	return function(inputValue: StateOrAny, defaultValue: StateOrAny, mustBeKind: string?): StateOrAny
		local stateKind = mustBeKind or "Value"
		local isInputAState = unwrap(inputValue) ~= inputValue
		local isDefaultAState = unwrap(defaultValue) ~= defaultValue
		
		if isInputAState and (mustBeKind == nil or inputValue.kind == mustBeKind) then
			return inputValue
		elseif inputValue ~= nil then
			return Scope[stateKind](Scope, unwrap(inputValue))
		end
		
		return if isDefaultAState then defaultValue else Scope[stateKind](Scope, defaultValue)
	end
end