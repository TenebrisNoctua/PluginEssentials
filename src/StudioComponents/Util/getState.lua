local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local unwrap = require(script.Parent.unwrap)
local types = require(script.Parent.types)

type stateOrAny = types.StateObject<any> | any

return function(Scope: { [any]: any }): (inputValue: stateOrAny, defaultValue: stateOrAny, mustBeKind: string?) -> stateOrAny
	return function(inputValue: stateOrAny, defaultValue: stateOrAny, mustBeKind: string?): stateOrAny
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