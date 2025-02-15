local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

return function(x: any, use: any?): any
	-- If x is a state, and requires a dependency to be added, we also require a use function.
	-- If x is a state, but doesn't require a dependency to be added, we use Fusion.peek function. (Doesn't add any dependencies)

	if typeof(x) == "table" and x.type == "State" and use then
		return use(x)
	elseif typeof(x) == "table" and x.type == "State" then
		return Fusion.peek(x)
	end

	return x
end