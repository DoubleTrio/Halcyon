--[[
    init.lua
    Created: 03/21/2021 22:07:39
    Description: Autogenerated script file for the map metano_cave.
]]--
-- Commonly included lua functions and data
require 'origin.common'
require 'halcyon.PartnerEssentials'
require 'halcyon.ground.metano_cave.metano_cave_ch_2'
require 'halcyon.ground.metano_cave.metano_cave_ch_3'
require 'halcyon.ground.metano_cave.metano_cave_ch_4'

-- Package name
local metano_cave = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = STRINGS.MapStrings['SomeStringName']


-------------------------------
-- Map Callbacks
-------------------------------
---metano_cave.Init
--Engine callback function
function metano_cave.Init(map, time)

	DEBUG.EnableDbgCoro()
	print('=>> Init_metano_cave <<=')
	
	COMMON.RespawnAllies()
	PartnerEssentials.InitializePartnerSpawn()
	
	if SOUND:GetCurrentSong() ~= SV.metano_town.Song then
		SOUND:PlayBGM(SV.metano_town.Song, true)
  end
  
	GROUND:CharSetAnim(CH('Sunflora'), "None", true) --sunflora is not happy and so does not bounce around with her idle anim 

	GROUND:AddMapStatus("darkness")--darkness
	
	--Remove nicknames from characters if the nickname mod is enabled.
	if CONFIG.UseNicknames then
		CH('Sunflora').Data.Nickname = CharacterEssentials.GetCharacterName('Sunflora')
	else 
		CH('Sunflora').Data.Nickname = 'Sunflora'
	end
end

---metano_cave.Enter
--Engine callback function
function metano_cave.Enter(map, time)
	DEBUG.EnableDbgCoro()
	print('Enter_metano_cave')
	metano_cave.PlotScripting()
end

---metano_cave.Exit
--Engine callback function
function metano_cave.Exit(map, time)


end

---metano_cave.Update
--Engine callback function
function metano_cave.Update(map, time)


end

---metano_cave.GameSave
--Engine callback function
function metano_cave.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))
end

---metano_cave.GameLoad
--Engine callback function
function metano_cave.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	metano_cave.PlotScripting()
end

function metano_cave.PlotScripting()
	if SV.ChapterProgression.Chapter == 4 then
		metano_cave_ch_4.SetupGround()
	else 
		GAME:FadeIn(20)
	end
end

-------------------------------
-- Map Transitions
-------------------------------

function metano_cave.Cave_Entrance_Touch(obj, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  GAME:FadeOut(false, 20)
  GAME:EnterGroundMap("metano_town", "Cave_Entrance_Marker", true)
  SV.partner.Spawn = 'Cave_Entrance_Marker_Partner'
end



-------------------------------
-- Entities Callbacks
-------------------------------

function metano_cave.Sunflora_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("metano_cave_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Sunflora_Action(...,...)"), chara, activator))
end

function metano_cave.Oddish_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  assert(pcall(load("metano_cave_ch_" .. tostring(SV.ChapterProgression.Chapter) .. ".Oddish_Action(...,...)"), chara, activator))
end

function metano_cave.Teammate1_Action(chara, activator)
  DEBUG.EnableDbgCoro() --Enable debugging this coroutine
  PartnerEssentials.GetPartnerDialogue(CH('Teammate1'))
end

return metano_cave
