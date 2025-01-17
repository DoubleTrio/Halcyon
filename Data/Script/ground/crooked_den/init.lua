--[[
    init.lua
    Created: 08/09/2022 17:51:31
    Description: Autogenerated script file for the map crooked_den.
]]--
-- Commonly included lua functions and data
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'ground.crooked_den.crooked_den_ch_3'

-- Package name
local crooked_den = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---crooked_den.Init
--Engine callback function
function crooked_den.Init(map, time)

	DEBUG.EnableDbgCoro()
	print('=>> Init_crooked_den <<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()
end

---crooked_den.Enter
--Engine callback function
function crooked_den.Enter(map, time)

	crooked_den.PlotScripting()

end

---crooked_den.Exit
--Engine callback function
function crooked_den.Exit(map, time)


end

---crooked_den.Update
--Engine callback function
function crooked_den.Update(map, time)


end

function crooked_den.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	crooked_den.PlotScripting()
end

function crooked_den.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end


function crooked_den.PlotScripting()
	if SV.ChapterProgression.Chapter == 3 then 
		if SV.Chapter3.FinishedRootScene then
			crooked_den.GenericEnding()
		elseif SV.Chapter3.LostToBoss then--player just died
			crooked_den_ch_3.DiedToBoss()
		elseif SV.Chapter3.DefeatedBoss then--player won
			crooked_den_ch_3.DefeatedBoss()
		elseif SV.Chapter3.EncounteredBoss then--player came back after dying 
			crooked_den_ch_3.SecondPreBossScene()
		else--first encounter
			crooked_den_ch_3.FirstPreBossScene()
		end
	elseif SV.ChapterProgression.Chapter > 3 then
		crooked_den.GenericEnding()
	else
		GAME:FadeIn(20)
	end
end




--No cutscene to play, play a generic ending saying there's nothing here.
--todo: add in teammate 2 and teammate 3 if they exist. not needed for now.
--todo: have results screen pop up after this instead of before this
function crooked_den.GenericEnding()
	local hero = CH('PLAYER')
	local partner = CH('Teammate1')
	AI:DisableCharacterAI(partner)
	SOUND:StopBGM()
	GAME:WaitFrames(20)
	
	GROUND:TeleportTo(hero, 188, 256, Direction.Up)
	GROUND:TeleportTo(partner, 156, 256, Direction.Up)
	GAME:MoveCamera(180, 120, 1, false)
		
	GAME:CutsceneMode(true)
	UI:ResetSpeaker()
	UI:WaitShowTitle(GAME:GetCurrentGround().Name:ToLocal(), 20)
	GAME:WaitFrames(60)
	UI:WaitHideTitle(20)
	GAME:FadeIn(40)
	
	SOUND:PlayBGM('In The Depths of the Pit.ogg', true)
	
	local coro1 = TASK:BranchCoroutine(function() GROUND:MoveToPosition(partner, 156, 152, false, 1) end)
	local coro2 = TASK:BranchCoroutine(function() GAME:WaitFrames(10) GROUND:MoveToPosition(hero, 188, 152, false, 1) end)

	TASK:JoinCoroutines({coro1, coro2})
	GAME:WaitFrames(10)	
	
	local coro1 = TASK:BranchCoroutine(function() GeneralFunctions.LookAround(partner, 3, 4, false, false, true, Direction.Up) end)
	local coro2 = TASK:BranchCoroutine(function() GAME:WaitFrames(10)
												  GeneralFunctions.LookAround(hero, 3, 4, false, false, true, Direction.Up) end)
	TASK:JoinCoroutines({coro1, coro2})

	--temporary flags are set by the zone script rather than here.
	GAME:WaitFrames(20)
	UI:SetCenter(true)
	UI:WaitShowDialogue("There doesn't appear to be anything of interest here.")
	UI:WaitShowDialogue("It's impossible to go any further.[pause=0]\nIt's time to go back.")
	UI:SetCenter(false)
	SOUND:FadeOutBGM(60)
	GAME:FadeOut(false, 60)
	GAME:CutsceneMode(false)
	GAME:WaitFrames(20)
	
	--Go to second floor if mission was done, else, dinner room
	if SV.TemporaryFlags.MissionCompleted then
		GeneralFunctions.EndDungeonRun(RogueEssence.Data.GameProgress.ResultType.Cleared, "master_zone", -1, 22, 0, true, true)
	else
		GeneralFunctions.EndDungeonRun(RogueEssence.Data.GameProgress.ResultType.Cleared, "master_zone", -1, 6, 0, true, true)
	end
	
end



function crooked_den.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
 end

return crooked_den




