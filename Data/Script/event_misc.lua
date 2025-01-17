require 'common'
require 'GeneralFunctions'


STATUS_SCRIPT = {}

function STATUS_SCRIPT.Test(owner, ownerChar, context, args)
  PrintInfo("Test")
end


MAP_STATUS_SCRIPT = {}

function MAP_STATUS_SCRIPT.Test(owner, ownerChar, character, status, msg, args)
  PrintInfo("Test")
end


function MAP_STATUS_SCRIPT.ShopGreeting(owner, ownerChar, character, status, msg, args)
  
  if status ~= owner or character ~= nil then
    return
  end
  local found_shopkeep = COMMON.FindNpcWithTable(false, "Role", "Shopkeeper")
  if found_shopkeep and COMMON.CanTalk(found_shopkeep) then
    DUNGEON:CharTurnToChar(found_shopkeep, _DUNGEON.ActiveTeam.Leader)
    UI:SetSpeaker(found_shopkeep)
    UI:WaitShowDialogue(RogueEssence.StringKey(string.format("TALK_SHOP_START_%04d", found_shopkeep.Discriminator)):ToLocal())
	GAME:WaitFrames(10)
  end
end


function MAP_STATUS_SCRIPT.SetShopkeeperHostile(owner, ownerChar, character, status, msg, args)
  
  if status ~= owner or character ~= nil then
    return
  end
  local found_shopkeep = COMMON.FindNpcWithTable(false, "Role", "Shopkeeper")
  if found_shopkeep then
    local teamIndex = _ZONE.CurrentMap.AllyTeams:IndexOf(found_shopkeep.MemberTeam)
	_DUNGEON:RemoveTeam(RogueEssence.Dungeon.Faction.Friend, teamIndex)
	_DUNGEON:AddTeam(RogueEssence.Dungeon.Faction.Foe, found_shopkeep.MemberTeam)
	local tactic = _DATA:GetAITactic("shopkeeper") -- shopkeeper attack tactic
	found_shopkeep.Tactic = RogueEssence.Data.AITactic(tactic)
	found_shopkeep.Tactic:Initialize(found_shopkeep)
	
	local berserk_idx = "shopkeeper"
	local berserk = RogueEssence.Dungeon.StatusEffect(berserk_idx)
	TASK:WaitTask(found_shopkeep:AddStatusEffect(nil, berserk, nil))
  end
  -- force everyone to skip their turn for this entire session
  _ZONE.CurrentMap.CurrentTurnMap:SkipRemainingTurns()
end

ITEM_SCRIPT = {}

function ITEM_SCRIPT.Test(owner, ownerChar, context, args)
  local text = "You got a " .. context.Item:GetDungeonName()
  local notice = _MENU:CreateNotice("Test", text)
  _DUNGEON.PendingLeaderAction = _MENU:ProcessMenuCoroutine(notice)
end

function ITEM_SCRIPT.MissionItemPickup(owner, ownerChar, context, args)
  local mission_num = args.Mission
  local mission = SV.TakenBoard[mission_num]
  if mission.Item == context.Item.Value then
    mission.Completion = COMMON.MISSION_COMPLETE
    SV.TemporaryFlags.MissionCompleted = true
    GAME:WaitFrames(70)
	UI:ResetSpeaker()
    UI:WaitShowDialogue("Yes! You found " .. _DATA:GetMonster(mission.Client):GetColoredName() .. "'s " .. context.Item:GetDungeonName() .. "!")
	  --Clear but remember minimap state
    SV.TemporaryFlags.PriorMapSetting = _DUNGEON.ShowMap
    _DUNGEON.ShowMap = _DUNGEON.MinimapState.None
    
    --Slight pause before asking to warp out 
    GAME:WaitFrames(20)
    GeneralFunctions.AskMissionWarpOut()
  end
end

function ITEM_SCRIPT.OutlawItemPickup(owner, ownerChar, context, args)
  local mission_num = args.Mission
  local mission = SV.TakenBoard[mission_num]
  if mission.Item == context.Item.Value then
    SV.OutlawItemPickedUp = true
  end
end

REFRESH_SCRIPT = {}

function REFRESH_SCRIPT.Test(owner, ownerChar, character, args)
  PrintInfo("Test")
end


SKILL_CHANGE_SCRIPT = {}

function SKILL_CHANGE_SCRIPT.Test(owner, character, skillIndices, args)
  PrintInfo("Test")
end