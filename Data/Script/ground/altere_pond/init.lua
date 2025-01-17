--[[
    init.lua
    Created: 06/15/2021 21:21:51
    Description: Autogenerated script file for the map altere_pond.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'
require 'ground.altere_pond.altere_pond_ch_1'
require 'ground.altere_pond.altere_pond_ch_2'
require 'ground.altere_pond.altere_pond_ch_3'

-- Package name
local altere_pond = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---altere_pond.Init
--Engine callback function
function altere_pond.Init(map)
	
	DEBUG.EnableDbgCoro()
	print('=>> Init_altere_pond <<=')
	MapStrings = COMMON.AutoLoadLocalizedStrings()
	COMMON.RespawnAllies()
	GROUND:AddMapStatus("clouds_overhead")
	PartnerEssentials.InitializePartnerSpawn()

end

---altere_pond.Enter
--Engine callback function
function altere_pond.PlotScripting()

	if SV.ChapterProgression.Chapter == 1 then 
		if not SV.Chapter1.PartnerEnteredForest and not SV.Chapter1.PartnerMetHero then
			altere_pond_ch_1.PrologueGoToRelicForest()
		elseif SV.Chapter1.PartnerEnteredForest and not SV.Chapter1.PartnerCompletedForest then
			altere_pond_ch_1.WipedInForest()
		elseif SV.Chapter1.TeamCompletedForest then 
			altere_pond_ch_1.PartnerHeroReturn()
		end 		
	elseif SV.ChapterProgression.Chapter == 2 then
		altere_pond_ch_2.SetupGround()
	else
		GAME:FadeIn(20)
	end
end

function altere_pond.Enter(map)
	altere_pond.PlotScripting()
end

function altere_pond.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	altere_pond.PlotScripting()
end

function altere_pond.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end

---altere_pond.Exit
--Engine callback function
function altere_pond.Exit(map)


end

---altere_pond.Update
--Engine callback function
function altere_pond.Update(map)


end





-------------------------------
-- Map Transitions
-------------------------------

function altere_pond.North_Exit_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  if SV.metano_town.Song ~= "File Select.ogg" then SOUND:FadeOutBGM(20) end--map transition may result in a music change depending on song Falo is playing
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("metano_altere_transition", "Metano_Altere_Transition_South_Entrance_Marker", SV.metano_town.Song == 'File Select.ogg')
  SV.partner.Spawn = 'Metano_Altere_Transition_South_Entrance_Marker_Partner'
end

--separate entrance to go into relic forest
function altere_pond.East_Exit_Touch(obj, activator)
	local zone = _DATA.DataIndices[RogueEssence.Data.DataManager.DataType.Zone]:Get("relic_forest")
    UI:ResetSpeaker()
    local hero = CH('PLAYER')
    local partner = CH('Teammate1')
    partner.IsInteracting = true
    GROUND:CharSetAnim(partner, 'None', true)
    GROUND:CharSetAnim(hero, 'None', true)		
	UI:ChoiceMenuYesNo("Would you like to enter " .. zone:GetColoredName() .. "?", true)
	UI:WaitForChoice()
	local yesnoResult = UI:ChoiceResult()
	if yesnoResult then 
		SOUND:FadeOutBGM(60)
		GAME:FadeOut(false, 60)
		partner.IsInteracting = false
		GROUND:CharEndAnim(partner)
		GROUND:CharEndAnim(hero)	
		GAME:EnterDungeon("relic_forest", 0, 0, 0, RogueEssence.Data.GameProgress.DungeonStakes.Risk, true, true)
	end
	partner.IsInteracting = false
	GROUND:CharEndAnim(partner)
	GROUND:CharEndAnim(hero)	
end 

---------------------------------
-- Event Trigger
-- These are temporary objects created by a script used to trigger events that only happen
-- at certain plot progressions, typically a cutscene of sorts for a particular chapter.
---------------------------------
function altere_pond.Event_Trigger_1_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
 assert(pcall(load("altere_pond_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Event_Trigger_1_Touch(...,...)"), obj, activator))
end




------------------
--NPCS 
----------------

function altere_pond.Relicanth_Action(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
 assert(pcall(load("altere_pond_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Relicanth_Action(...,...)"), obj, activator))
end




function altere_pond.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end


return altere_pond

