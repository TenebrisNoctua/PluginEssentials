local External = require(script.Parent.Parent.Parent.External)
local Fusion = External.getLibrary("Fusion") :: Fusion

local ComponentTypes = script.Parent.Parent.Parent.ComponentTypes

local Types = require(ComponentTypes.Types)
local unwrap = require(script.Parent.unwrap)

-- this technically could be changed later on in a way that
-- allows people to change whether this can be toggled
local isMotionEnabled = true

type State<T> = Types.State<T>
type Scope = Types.Scope
type Use = Types.Use
type Fusion = Types.Fusion

--motionStateTypes: Tween, Spring
return function(Scope: Scope): (goalState: State<any>, motionStateType: string, ...any) -> State<any> | any
	return function(goalState: State<any>, motionStateType: string, ...: any): State<any> | any
		local motionTypeFn = Fusion[motionStateType]
		if typeof(motionTypeFn) ~= "function" then
			warn(("[%s]: No motionStateType with the name '%s' was found in Fusion!"):format(script.Name, tostring(motionStateType)))
			return goalState
		end

		local motionGoalState = motionTypeFn(Scope, goalState, ...)
		local isMotionEnabledAState = unwrap(isMotionEnabled) ~= isMotionEnabled

		if isMotionEnabledAState then
			return Scope:Computed(function(use: Use, scope: Scope)
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

