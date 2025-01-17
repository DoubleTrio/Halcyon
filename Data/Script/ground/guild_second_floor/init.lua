--[[
    init.lua
    Created: 06/29/2021 10:19:56
    Description: Autogenerated script file for the map guild_second_floor.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'CharacterEssentials'
require 'GeneralFunctions'
require 'AudinoAssembly'
require 'mission_gen'
require 'ground.guild_second_floor.guild_second_floor_ch_1'
require 'ground.guild_second_floor.guild_second_floor_ch_2'
require 'ground.guild_second_floor.guild_second_floor_ch_3'


-- Package name
local guild_second_floor = {}

local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---guild_second_floor.Init
function guild_second_floor.Init(map)
	DEBUG.EnableDbgCoro()
	print('=>> Init_guild_second_floor<<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()


	if not SV.ChapterProgression.UnlockedAssembly then--hide audino at her assembly if it isn't unlocked yet
		GROUND:Hide('Assembly')
		GROUND:Hide('Assembly_Owner')
	end

end

---guild_second_floor.Enter
function guild_second_floor.Enter(map)
	DEBUG.EnableDbgCoro()
	print('Enter_guild_second_floor')
	UI:ResetSpeaker()
	guild_second_floor.PlotScripting()
end

---guild_second_floor.Exit
function guild_second_floor.Exit(map)


end

---guild_second_floor.Update
function guild_second_floor.Update(map)


end


function guild_second_floor.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	guild_second_floor.PlotScripting()
end

function guild_second_floor.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end

function guild_second_floor.PlotScripting()
	--plot scripting
	--if a mission is to be turned in, prioritize that.
	if SV.TemporaryFlags.MissionCompleted then 
		guild_second_floor.Hand_In_Missions()
	else
		if SV.ChapterProgression.Chapter == 1 then
			if SV.Chapter1.TeamCompletedForest and not SV.Chapter1.TeamJoinedGuild then 
				guild_second_floor_ch_1.MeetNoctowl()
			else
				guild_second_floor_ch_1.SetupGround()
			end
		elseif SV.ChapterProgression.Chapter == 2 then
			if SV.Chapter2.FinishedFirstDay and not SV.Chapter2.FinishedCameruptRequestScene then 
				guild_second_floor_ch_2.CameruptRequestCutscene()
			elseif SV.Chapter2.FinishedRiver then
				guild_second_floor_ch_2.RescuedNumelCutscene()
			else
				guild_second_floor_ch_2.SetupGround()
			end
		elseif SV.ChapterProgression.Chapter == 3 then
			if not SV.Chapter3.FinishedOutlawIntro then
				guild_second_floor_ch_3.OutlawTutorialScene()
			elseif SV.Chapter3.DefeatedBoss and not SV.Chapter3.FinishedRootScene then
				guild_second_floor_ch_3.OutlawRewardScene()
			else
				guild_second_floor_ch_3.SetupGround()
			end
		else
			GAME:FadeIn(20)
		end
	end
end


--[[
Markers used for generic NPC spawning (i.e. where flavor NPCs should be going)

Teams gathered around the left message board 
Left_Trio_1, 2, 3 
Left_Duo_1, 2
Left_Solo

Teams gathered around the right message board
Right_Trio_1, 2, 3 
Right_Duo_1, 2
Right_Solo

Teams having a conversation:
Generic_Spawn_Duo_1, 2, 3 ,4
TODO: Add a couple sets of trio spawn markers 

Generic Spawns:
Generic_Spawn_1, 2, 3, 4, 5, 6, 7, 8
]]--




---------------------------------
-- Event Trigger
-- This is a temporary object created by a script used to trigger events that only happen
-- once, typically a cutscene of sorts for a particular chapter.
---------------------------------
function guild_second_floor.Event_Trigger_1_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
 assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Event_Trigger_1_Touch(...,...)"), obj, activator))
end






-------------------------------
-- Entities Callbacks
-------------------------------
function guild_second_floor.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end

function guild_second_floor.Mission_Board_Action(obj, activator)
	local partner = CH('Teammate1')
	local hero = CH('PLAYER')
	if SV.ChapterProgression.Chapter < 3 and not SV.Chapter2.FinishedFirstDay then 
		GeneralFunctions.StartPartnerConversation("Hmm...[pause=0] I don't think we should being taking jobs from the board right now...", "Worried")
		UI:SetSpeakerEmotion("Normal")
		UI:WaitShowDialogue("We only just joined after all.[pause=0] Let's come back another time!")
		GeneralFunctions.EndConversation(partner)
	elseif SV.ChapterProgression.Chapter < 3 and SV.Chapter2.FinishedFirstDay then 
		local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get("illuminant_riverbed")
		GeneralFunctions.StartPartnerConversation(hero:GetDisplayName() .. "![pause=0] We already have a mission to do!")
		UI:WaitShowDialogue("We have to get over to " .. zone:GetColoredName() .. " and find " .. CharacterEssentials.GetCharacterName("Numel") .. ".[pause=0] Let's go!")
		GeneralFunctions.EndConversation(partner)
	elseif SV.ChapterProgression.Chapter == 3 and not SV.Chapter3.EncounteredBoss then
		local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get("crooked_cavern")
		GeneralFunctions.StartPartnerConversation(hero:GetDisplayName() .. "![pause=0] We already have a mission to do!")
		UI:WaitShowDialogue("We have to get over to " .. zone:GetColoredName() .. " and capture the outlaw " .. CharacterEssentials.GetCharacterName("Sandile") .. ".[pause=0] Let's go!")
		GeneralFunctions.EndConversation(partner)
	elseif SV.ChapterProgression.Chapter == 3 and SV.Chapter3.EncounteredBoss and not SV.Chapter3.DefeatedBoss then
		local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get("crooked_cavern")
		GeneralFunctions.StartPartnerConversation(hero:GetDisplayName() .. "![pause=0] We already have a mission to do!")
		UI:WaitShowDialogue("We have to get over to " .. zone:GetColoredName() .. " and help " .. CharacterEssentials.GetCharacterName("Sandile") .. " get away from Team [color=#FFA5FF]Style[color].[pause=0] Let's get a move on!")
		GeneralFunctions.EndConversation(partner)
	else
	  --Mission Board
	  partner.IsInteracting = true
	  GROUND:CharSetAnim(partner, 'None', true)
	  GROUND:CharSetAnim(hero, 'None', true)
	  GeneralFunctions.TurnTowardsLocation(hero, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
	  GeneralFunctions.TurnTowardsLocation(partner, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
	  
	  local menu = BoardSelectionMenu:new(COMMON.MISSION_BOARD_MISSION)
	  UI:SetCustomMenu(menu.menu)
	  UI:WaitForChoice()
	
	  partner.IsInteracting = false
	  GROUND:CharEndAnim(partner)
	  GROUND:CharEndAnim(hero)	
	end
end

function guild_second_floor.Outlaw_Board_Action(obj, activator)
	local partner = CH('Teammate1')
	local hero = CH('PLAYER')
	if SV.ChapterProgression.Chapter < 3 and not SV.Chapter2.FinishedFirstDay then 
		GeneralFunctions.StartPartnerConversation("Hmm...[pause=0] I don't think we should being taking jobs from the board right now...", "Worried")
		UI:SetSpeakerEmotion("Normal")
		UI:WaitShowDialogue("We only just joined after all.[pause=0] Let's come back another time!")
		GeneralFunctions.EndConversation(partner)
	elseif SV.ChapterProgression.Chapter < 3 and SV.Chapter2.FinishedFirstDay then 
		local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get("illuminant_riverbed")
		GeneralFunctions.StartPartnerConversation(hero:GetDisplayName() .. "![pause=0] We already have a mission to do!")
		UI:WaitShowDialogue("We have to get over to " .. zone:GetColoredName() .. " and find " .. CharacterEssentials.GetCharacterName("Numel") .. ".[pause=0] Let's go!")
		GeneralFunctions.EndConversation(partner)
	elseif SV.ChapterProgression.Chapter == 3 and not SV.Chapter3.EncounteredBoss then
		local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get("crooked_cavern")
		GeneralFunctions.StartPartnerConversation(hero:GetDisplayName() .. "![pause=0] We already have a mission to do!")
		UI:WaitShowDialogue("We have to get over to " .. zone:GetColoredName() .. " and capture the outlaw " .. CharacterEssentials.GetCharacterName("Sandile") .. ".[pause=0] Let's go!")
		GeneralFunctions.EndConversation(partner)
	elseif SV.ChapterProgression.Chapter == 3 and SV.Chapter3.EncounteredBoss and not SV.Chapter3.DefeatedBoss then
		local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get("crooked_cavern")
		GeneralFunctions.StartPartnerConversation(hero:GetDisplayName() .. "![pause=0] We already have a mission to do!")
		UI:WaitShowDialogue("We have to get over to " .. zone:GetColoredName() .. " and help " .. CharacterEssentials.GetCharacterName("Sandile") .. " get away from Team [color=#FFA5FF]Style[color].[pause=0] Let's get a move on!")
		GeneralFunctions.EndConversation(partner)
	else
	  --Outlaw Board
	  partner.IsInteracting = true
	  GROUND:CharSetAnim(partner, 'None', true)
	  GROUND:CharSetAnim(hero, 'None', true)
	  GeneralFunctions.TurnTowardsLocation(hero, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
	  GeneralFunctions.TurnTowardsLocation(partner, obj.Position.X + obj.Width // 2, obj.Position.Y + obj.Height // 2)
	  	 

	  local menu = BoardSelectionMenu:new(COMMON.MISSION_BOARD_OUTLAW)
	  UI:SetCustomMenu(menu.menu)
	  UI:WaitForChoice()
	  
	  partner.IsInteracting = false
	  GROUND:CharEndAnim(partner)
	  GROUND:CharEndAnim(hero)	
	end
end


function guild_second_floor.Hand_In_Missions()
	for i = 1, 8, 1 do
		if SV.TakenBoard[i].Client ~= "" and SV.TakenBoard[i].Completion == MISSION_GEN.COMPLETE then
			if SV.TakenBoard[i].Type == COMMON.MISSION_TYPE_OUTLAW or SV.TakenBoard[i].Type == COMMON.MISSION_TYPE_OUTLAW_ITEM 
					or SV.TakenBoard[i].Type == COMMON.MISSION_TYPE_OUTLAW_FLEE or SV.TakenBoard[i].Type == COMMON.MISSION_TYPE_OUTLAW_MONSTER_HOUSE then
				guild_second_floor.Outlaw_Job_Clear(SV.TakenBoard[i])
			else
				guild_second_floor.Mission_Job_Clear(SV.TakenBoard[i])
			end
			--short pause between fadeins
			GAME:WaitFrames(20)
			
			--clear the job
			SV.TakenBoard[i] = 	{
									Client = "",
									Target = "",
									Flavor = "",
									Title = "",
									Zone = "",
									Segment = -1,
									Floor = -1,
									Reward = "",
									Type = -1,
									Completion = -1,
									Taken = false,
									Difficulty = "",
									Item = "",
									Special = "",
									ClientGender = -1,
									TargetGender = -1,
									BonusReward = "",
									BackReference = -1
								}
		end
	end 
	--reset this flag
	SV.TemporaryFlags.MissionCompleted = false

	--sort taken jobs now that we're removed completed ones
	MISSION_GEN.SortTaken()
	
	--if dinnertime is set, then go to the dining room. This should happen pretty much all the time unless story dictates some other ground for some reason.
	--otherwise go to the place dictated by SV.TemporaryFlags.PostJobsGround
	if SV.TemporaryFlags.Dinnertime then
		GAME:EnterGroundMap('guild_dining_room', 'Main_Entrance_Marker')
	else 
		if SV.TemporaryFlags.PostJobsGround == '' then --just in case, if theres no postjobsground defined, just go to your bed room. This shouldn't happen though.
			GAME:EnterGroundMap('guild_heros_room', 'Main_Entrance_Marker')
		else
			GAME:EnterGroundMap(SV.TemporaryFlags.PostJobsGround, 'Main_Entrance_Marker')
		end
	end

end
--takes a job and plays an outlaw reward scene depending on the job.
function guild_second_floor.Outlaw_Job_Clear(job)
	local partner = CH('Teammate1')
	local hero = CH('PLAYER')
	GAME:CutsceneMode(true)
	AI:DisableCharacterAI(partner)
	UI:ResetSpeaker()
	
	GROUND:TeleportTo(partner, 376, 272, Direction.Up)
	GROUND:TeleportTo(hero, 408, 272, Direction.Up)
	GAME:MoveCamera(400, 240, 1, false)
	
	SOUND:StopBGM()

	local money = false
	if job.Reward == 'money' then money = true end

	--client is zhayn, he and the pawniards take the outlaw away
	if job.Client == 'zhayn' then

		local pawniard_boy, pawniard_girl, bisharp = 
			CharacterEssentials.MakeCharactersFromList({
				--{'Sandile', 392, 224, Direction.Down},
				{'Pawniard_Boy', 368, 224, Direction.Down},
				{'Pawniard_Girl', 416, 224, Direction.Down},
				{'Bisharp', 392, 248, Direction.Down}
			})
		
		local outlaw_gender = job.TargetGender
		outlaw_gender = GeneralFunctions.NumToGender(outlaw_gender)
				
		local outlaw_monster = RogueEssence.Dungeon.MonsterID(job.Target, 0, "normal", outlaw_gender)
		
		local outlaw = RogueEssence.Ground.GroundChar(outlaw_monster, RogueElements.Loc(392, 224), Direction.Down, outlaw_monster.Species, 'Outlaw')
		outlaw:ReloadEvents()
		GAME:GetCurrentGround():AddTempChar(outlaw)

		GAME:FadeIn(40)
		SOUND:PlayBGM("Job Clear!.ogg", true)
		UI:SetSpeaker(bisharp)
		
		UI:WaitShowDialogue("You bagged the outlaw " .. _DATA:GetMonster(outlaw.CurrentForm.Species):GetColoredName() .. "!")
		
		GAME:WaitFrames(20)
		UI:WaitShowDialogue("Please take this here bounty as a reward.")
		GAME:WaitFrames(20)

		--reward the item 
		if money then
			GeneralFunctions.RewardItem(MISSION_GEN.DIFF_TO_MONEY[job.Difficulty], true)
		else
			GeneralFunctions.RewardItem(job.Reward)
		end
		
		
		if job.BonusReward ~= '' then 
			UI:SetSpeaker(bisharp)
			GAME:WaitFrames(20)
			UI:WaitShowDialogue("Please take this here item as well.")
			GAME:WaitFrames(20)
			GeneralFunctions.RewardItem(job.BonusReward)
		end 
		
		GAME:WaitFrames(20)
		GeneralFunctions.RewardPoints(MISSION_GEN.DIFFICULTY[job.Difficulty])
		
		GAME:WaitFrames(20)
		
		UI:SetSpeaker(bisharp)
		UI:WaitShowDialogue("Thank ya as always for lendin' a hand.")
	
		GROUND:CharSetEmote(pawniard_boy, "happy", 0)
		GROUND:CharSetEmote(pawniard_girl, "happy", 0)
		local coro1 = TASK:BranchCoroutine(function() GROUND:CharSetAction(bisharp, RogueEssence.Ground.PoseGroundAction(bisharp.Position, bisharp.Direction, RogueEssence.Content.GraphicsManager.GetAnimIndex("Pose"))) end)
		local coro2 = TASK:BranchCoroutine(function() GROUND:CharSetAction(pawniard_boy, RogueEssence.Ground.PoseGroundAction(pawniard_boy.Position, pawniard_boy.Direction, RogueEssence.Content.GraphicsManager.GetAnimIndex("Pose"))) end)
		local coro3 = TASK:BranchCoroutine(function() GROUND:CharSetAction(pawniard_girl, RogueEssence.Ground.PoseGroundAction(pawniard_girl.Position, pawniard_girl.Direction, RogueEssence.Content.GraphicsManager.GetAnimIndex("Pose"))) end)
		local coro4 = TASK:BranchCoroutine(function() GAME:WaitFrames(12) SOUND:PlayBattleSE('DUN_Fury_Cutter') end)

		TASK:JoinCoroutines({coro1, coro2, coro3, coro4})
		GAME:WaitFrames(60)
		
		GROUND:CharEndAnim(bisharp)
		GROUND:CharEndAnim(pawniard_boy)
		GROUND:CharEndAnim(pawniard_girl)
		GROUND:CharSetEmote(pawniard_boy, "", 0)
		GROUND:CharSetEmote(pawniard_girl, "", 0)
		GAME:WaitFrames(20)
		
		--fade out and clean up any temporary characters
		SOUND:FadeOutBGM(40)
		GAME:FadeOut(false, 40)
		GAME:GetCurrentGround():RemoveTempChar(bisharp)
		GAME:GetCurrentGround():RemoveTempChar(pawniard_boy)
		GAME:GetCurrentGround():RemoveTempChar(pawniard_girl)
		GAME:GetCurrentGround():RemoveTempChar(outlaw)

	
	else--client is some random mon
		local client_gender = job.ClientGender
		client_gender = GeneralFunctions.NumToGender(client_gender)
		client_gender = client_gender

		local client_monster = RogueEssence.Dungeon.MonsterID(job.Client, 0, "normal", client_gender)
		
		local client = RogueEssence.Ground.GroundChar(client_monster, RogueElements.Loc(392, 240), Direction.Down, job.Client:gsub("^%l", string.upper), client_monster.Species)
		client:ReloadEvents()
		GAME:GetCurrentGround():AddTempChar(client)

		GAME:FadeIn(40)
		SOUND:PlayBGM("Job Clear!.ogg", true)
		UI:SetSpeaker(client)
		
		
		local item = RogueEssence.Dungeon.InvItem(job.Item)
		UI:WaitShowDialogue("Thank you for getting my " .. item:GetDisplayName() .. " back!")
		GAME:WaitFrames(20)
		UI:WaitShowDialogue("Please take this as my thanks!")
		GAME:WaitFrames(20)

		--reward the item 
		if money then
			GeneralFunctions.RewardItem(MISSION_GEN.DIFF_TO_MONEY[job.Difficulty], true)
		else
			GeneralFunctions.RewardItem(job.Reward)
		end
		
		if job.BonusReward ~= '' then 
			UI:SetSpeaker(client)
			GAME:WaitFrames(20)
			UI:WaitShowDialogue("Please take this as well!")
			GAME:WaitFrames(20)
			GeneralFunctions.RewardItem(job.BonusReward)
		end 
		
		GAME:WaitFrames(20)
		GeneralFunctions.RewardPoints(MISSION_GEN.DIFFICULTY[job.Difficulty])
		GAME:WaitFrames(20)
		
		
		--fade out and clean up any temporary characters
		SOUND:FadeOutBGM(40)
		GAME:FadeOut(false, 40)
		GAME:GetCurrentGround():RemoveTempChar(client)
	end
end

--takes a job and plays an regular mission reward scene depending on the job.
function guild_second_floor.Mission_Job_Clear(job)
	local partner = CH('Teammate1')
	local hero = CH('PLAYER')
	GAME:CutsceneMode(true)
	AI:DisableCharacterAI(partner)
	UI:ResetSpeaker()
	
	GROUND:TeleportTo(partner, 88, 272, Direction.Up)
	GROUND:TeleportTo(hero, 120, 272, Direction.Up)
	GAME:MoveCamera(112, 240, 1, false)
	SOUND:StopBGM()

	local money = false
	if job.Reward == 'money' then money = true end

	--client is target. Check on escort is needed in case the escort is to the same species.
	if job.Client == job.Target and job.Type ~= COMMON.MISSION_TYPE_ESCORT then
		local client_gender = job.ClientGender
		client_gender = GeneralFunctions.NumToGender(client_gender)

		local client_monster = RogueEssence.Dungeon.MonsterID(job.Client, 0, "normal", client_gender)		
		local client = RogueEssence.Ground.GroundChar(client_monster, RogueElements.Loc(104, 240), Direction.Down, job.Client:gsub("^%l", string.upper), client_monster.Species)
		client:ReloadEvents()
		GAME:GetCurrentGround():AddTempChar(client)

		GAME:FadeIn(40)
		SOUND:PlayBGM("Job Clear!.ogg", true)
		UI:SetSpeaker(client)
		
		--different thank you message depending on the job type
		if job.Type == COMMON.MISSION_TYPE_RESCUE then
			UI:WaitShowDialogue("Thank you for rescuing me!")
		elseif job.Type == COMMON.MISSION_TYPE_EXPLORATION then 
			local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get(job.Zone)
			UI:WaitShowDialogue("Thank you for taking me on an adventure in " .. zone:GetColoredName() .. "!")
		elseif job.Type == COMMON.MISSION_TYPE_LOST_ITEM then
			local item = RogueEssence.Dungeon.InvItem(job.Item)
			UI:WaitShowDialogue("Thank you for finding my " .. item:GetDisplayName() .. "!")
		else--delivery 
			local item = RogueEssence.Dungeon.InvItem(job.Item)
			UI:WaitShowDialogue("Thank you for delivering the " .. item:GetDisplayName() .. " to me!")
		end
		
		GAME:WaitFrames(20)
		UI:WaitShowDialogue("Please take this as my thanks!")
		GAME:WaitFrames(20)

		--reward the item 
		if money then
			GeneralFunctions.RewardItem(MISSION_GEN.DIFF_TO_MONEY[job.Difficulty], true)
		else
			GeneralFunctions.RewardItem(job.Reward)
		end
		
		if job.BonusReward ~= '' then 
			UI:SetSpeaker(client)
			GAME:WaitFrames(20)
			UI:WaitShowDialogue("Please take this as well!")
			GAME:WaitFrames(20)
			GeneralFunctions.RewardItem(job.BonusReward)
		end 
		
		GAME:WaitFrames(20)
		GeneralFunctions.RewardPoints(MISSION_GEN.DIFFICULTY[job.Difficulty])
		GAME:WaitFrames(20)
		
		
		--fade out and clean up any temporary characters
		SOUND:FadeOutBGM(40)
		GAME:FadeOut(false, 40)
		GAME:GetCurrentGround():RemoveTempChar(client)

	
	else--client not the target
		local client_gender = job.ClientGender
		client_gender = GeneralFunctions.NumToGender(client_gender)
		
		
		local client_monster = RogueEssence.Dungeon.MonsterID(job.Client, 0, "normal", client_gender)
		
		local client = RogueEssence.Ground.GroundChar(client_monster, RogueElements.Loc(88, 240), Direction.Down, job.Client:gsub("^%l", string.upper), client_monster.Species)
		client:ReloadEvents()
		GAME:GetCurrentGround():AddTempChar(client)

		local target_gender = job.TargetGender
		target_gender = GeneralFunctions.NumToGender(target_gender)
				
		local target_monster = RogueEssence.Dungeon.MonsterID(job.Target, 0, "normal", target_gender)
		target_monster.Gender = _DATA:GetMonster(job.Target).Forms[0]:RollGender(_ZONE.CurrentGround.Rand)
		
		local target = RogueEssence.Ground.GroundChar(target_monster, RogueElements.Loc(120, 240), Direction.Down, job.Target:gsub("^%l", string.upper), target_monster.Species)
		target:ReloadEvents()
		GAME:GetCurrentGround():AddTempChar(target)
		
		
		GAME:FadeIn(40)
		SOUND:PlayBGM("Job Clear!.ogg", true)
		UI:SetSpeaker(client)
		
		if job.Type == COMMON.MISSION_TYPE_ESCORT then
			UI:WaitShowDialogue("Thank you for escorting me to my friend!")
		else 
			if job.Special == MISSION_GEN.SPECIAL_CLIENT_LOVER then
				UI:WaitShowDialogue("Thank you for rescuing my love!")
			elseif job.Special == MISSION_GEN.SPECIAL_CLIENT_RIVAL then
				UI:WaitShowDialogue("Thank you for rescuing my rival!")
			elseif job.Special == MISSION_GEN.SPECIAL_CLIENT_CHILD then
				UI:WaitShowDialogue("Thank you for rescuing my child!")
			else
				UI:WaitShowDialogue("Thank you for rescuing my friend!")
			end
		end
		GAME:WaitFrames(20)
		UI:WaitShowDialogue("Please take this as my thanks!")
		GAME:WaitFrames(20)

		--reward the item 
		if money then
			GeneralFunctions.RewardItem(MISSION_GEN.DIFF_TO_MONEY[job.Difficulty], true)
		else
			GeneralFunctions.RewardItem(job.Reward)
		end
		
		if job.BonusReward ~= '' then 
			UI:SetSpeaker(client)
			GAME:WaitFrames(20)
			UI:WaitShowDialogue("Please take this as well!")
			GAME:WaitFrames(20)
			GeneralFunctions.RewardItem(job.BonusReward)
		end 
		
		GAME:WaitFrames(20)
		GeneralFunctions.RewardPoints(MISSION_GEN.DIFFICULTY[job.Difficulty])
		GAME:WaitFrames(20)
		
		
		--fade out and clean up any temporary characters
		SOUND:FadeOutBGM(40)
		GAME:FadeOut(false, 40)
		GAME:GetCurrentGround():RemoveTempChar(client)
		GAME:GetCurrentGround():RemoveTempChar(target)
	end
end



function guild_second_floor.Cleffa_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Cleffa_Action(...,...)"), chara, activator))
end

function guild_second_floor.Aggron_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Aggron_Action(...,...)"), chara, activator))
end

function guild_second_floor.Zigzagoon_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Zigzagoon_Action(...,...)"), chara, activator))
end

function guild_second_floor.Audino_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Audino_Action(...,...)"), chara, activator))
end

function guild_second_floor.Marill_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Marill_Action(...,...)"), chara, activator))
end

function guild_second_floor.Spheal_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Spheal_Action(...,...)"), chara, activator))
end

function guild_second_floor.Jigglypuff_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Jigglypuff_Action(...,...)"), chara, activator))
end

function guild_second_floor.Cranidos_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Cranidos_Action(...,...)"), chara, activator))
end

function guild_second_floor.Mareep_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Mareep_Action(...,...)"), chara, activator))
end

function guild_second_floor.Seviper_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Seviper_Action(...,...)"), chara, activator))
end

function guild_second_floor.Zangoose_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Zangoose_Action(...,...)"), chara, activator))
end

function guild_second_floor.Bagon_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Bagon_Action(...,...)"), chara, activator))
end

function guild_second_floor.Doduo_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Doduo_Action(...,...)"), chara, activator))
end

function guild_second_floor.Noctowl_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Noctowl_Action(...,...)"), chara, activator))
end

function guild_second_floor.Camerupt_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Camerupt_Action(...,...)"), chara, activator))
end


function guild_second_floor.Metapod_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Metapod_Action(...,...)"), chara, activator))
end

function guild_second_floor.Silcoon_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("guild_second_floor_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Silcoon_Action(...,...)"), chara, activator))
end


function guild_second_floor.Mission_Test_Action(chara, activator)
	UI:ResetSpeaker()
	UI:WaitShowDialogue("Outlaw and Mission board have been refreshed!")
	MISSION_GEN.RemoveMissionBackReference()
	MISSION_GEN.ResetBoards()
	MISSION_GEN.GenerateBoard(COMMON.MISSION_BOARD_MISSION)
	MISSION_GEN.GenerateBoard(COMMON.MISSION_BOARD_OUTLAW)
	MISSION_GEN.SortMission()
	MISSION_GEN.SortOutlaw()
end

function guild_second_floor.Assembly_Action(obj, activator)
	AudinoAssembly.Assembly(CH('Assembly_Owner'))
end

---------------------------
-- Map Transitions
---------------------------
function guild_second_floor.Upwards_Stairs_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("guild_third_floor_lobby", "Main_Entrance_Marker")
  SV.partner.Spawn = 'Default'
end


function guild_second_floor.Downwards_Stairs_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("guild_first_floor", "Guild_First_Floor_Stairs_Marker")
  SV.partner.Spawn = 'Guild_First_Floor_Stairs_Marker_Partner'
end

return guild_second_floor