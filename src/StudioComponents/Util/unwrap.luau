local External = require(script.Parent.Parent.Parent.External)
local Fusion = External.getLibrary("Fusion") :: Fusion

local ComponentTypes = script.Parent.Parent.Parent.ComponentTypes
local Types = require(ComponentTypes.Types)

type Use = Types.Use
type Fusion = Types.Fusion

return function<T>(x: T, use: Use?): T | any
	-- If x is a state, and requires a dependency to be added, we also require a use function.
	-- If x is a state, but doesn't require a dependency to be added, we use Fusion.peek function. (Doesn't add any dependencies)	
	if typeof(x) == "table" and x.type == "State" and use then
		return use(x)
	elseif typeof(x) == "table" and x.type == "State" then
		return Fusion.peek(x)
	end

	return x
end