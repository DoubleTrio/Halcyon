--[[
    init.lua
    Created: 06/12/2023 20:41:47
    Description: Autogenerated script file for the map rock_maze.
]]--
-- Commonly included lua functions and data
require 'origin.common'
require 'halcyon.GeneralFunctions'

local rock_maze = {}
--------------------------------------------------
-- Map Callbacks
--------------------------------------------------
function rock_maze.Init(zone)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PrintInfo("=>> Init_rock_maze")
end

function rock_maze.Rescued(zone, name, mail)
  COMMON.Rescued(zone, name, mail)
end

function rock_maze.ExitSegment(zone, result, rescue, segmentID, mapID)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PrintInfo("=>> ExitSegment_rock_maze (Rock Maze) result "..tostring(result).." segment "..tostring(segmentID))

	GAME:SetRescueAllowed(false)
	
	--[[Different dungeon result typeS (cleared, died, etc)
	       public enum ResultType
        {
            Unknown = -1,
            Downed,
            Failed,
            Cleared,
            Escaped,
            TimedOut,
            GaveUp,
            Rescue
        }
		]]--
	
	
	--flag rock_maze as last dojo zone
	SV.Dojo.LastZone = "rock_maze"

	
	--Failed to clear
	if result ~= RogueEssence.Data.GameProgress.ResultType.Cleared then 
		SV.Dojo.TrainingFailedGeneric = true
	else--Cleared
		SV.Dojo.TrainingCompletedGeneric = true
	end
	
	GeneralFunctions.EndDungeonRun(result, "master_zone", -1, 36, 0, false, false)

end
	

return rock_maze