local ComponentTypes = script.Parent.Parent.Parent.ComponentTypes

local Types = require(ComponentTypes.Types)
local unwrap = require(script.Parent.unwrap)

type GetSelectedStateProperties = Types.GetSelectedStateProperties
type Use = Types.Use
type Scope = Types.Scope

return function(props: GetSelectedStateProperties): (use: Use, scope: Scope) -> any
	return function(use: Use, scope: Scope)
		local currentValue = unwrap(props.Value)
		local availableOptions = unwrap(props.Options) or {}
		
		if currentValue == nil or not table.find(availableOptions, currentValue) then
			local _, nextItem = next(availableOptions)
			if nextItem ~= nil then
				if props.OnSelected then
					props.OnSelected(nextItem, use)
				end
				return nextItem
			end
		else
			use(props.Value)
		end

		return currentValue
	end
end
