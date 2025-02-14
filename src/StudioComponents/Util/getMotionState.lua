local Plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Fusion = require(Plugin:FindFirstChild("Fusion", true))

local unwrap = require(script.Parent.unwrap)
local types = require(script.Parent.types)

-- this technically could be changed later on in a way that
-- allows people to change whether this can be toggled
local isMotionEnabled = true

--motionStateTypes: Tween, Spring
return function(Scope: { [any]: any }): (goalState: types.StateObject<any>, motionStateType: string, ...any) -> types.CanBeState<any>
	return function(goalState: types.StateObject<any>, motionStateType: string, ...:any): types.CanBeState<any>
		local motionTypeFn = Fusion[motionStateType]
		if typeof(motionTypeFn) ~= "function" then
			warn(("[%s]: No motionStateType with the name '%s' was found in Fusion!"):format(script.Name, tostring(motionStateType)))
			return goalState
		end

		local motionGoalState = motionTypeFn(Scope, goalState, ...)
		local isMotionEnabledAState = unwrap(isMotionEnabled) ~= isMotionEnabled

		if isMotionEnabledAState then
			return Scope:Computed(function(use, scope)
				if unwrap(isMotionEnabled, use) then
					return unwrap(motionGoalState, use)
				end
				return goalState
			end)
		else
			return if isMotionEnabled then motionGoalState else goalState
		end
	end
end

