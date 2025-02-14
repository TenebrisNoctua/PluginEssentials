local unwrap = require(script.Parent.unwrap)
local types = require(script.Parent.types)

type GetSelectedStateProperties = {
	Value: types.Value<any>?,
	Options: types.CanBeState<{any}>?,
	OnSelected: ((selectedOption: any, use: () -> ()?) -> nil)?,
}

return function(props: GetSelectedStateProperties): () -> any
	return function(use, scope)
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
