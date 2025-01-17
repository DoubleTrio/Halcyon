--[[
    init.lua
    Created: 07/03/2022 16:01:27
    Description: Autogenerated script file for the map personality_test.
]]--
-- Commonly included lua functions and data
require 'common'
require 'PartnerEssentials'

-- Package name
local personality_test = {}

-- Local, localized strings table
-- Use this to display the named strings you added in the strings files for the map!
-- Ex:
--      local localizedstring = MapStrings['SomeStringName']
local MapStrings = {}

-------------------------------
-- Map Callbacks
-------------------------------
---personality_test.Init
--Engine callback function
function personality_test.Init(map)

  --This will fill the localized strings table automatically based on the locale the game is 
  -- currently in. You can use the MapStrings table after this line!
  MapStrings = COMMON.AutoLoadLocalizedStrings()

end

---personality_test.Enter
--Engine callback function
function personality_test.Enter(map)

	personality_test.PlotScripting()

end

---personality_test.Exit
--Engine callback function
function personality_test.Exit(map)


end

---personality_test.Update
--Engine callback function
function personality_test.Update(map)


end

---personality_test.GameSave
--Engine callback function
function personality_test.GameSave(map)
	PartnerEssentials.SaveGamePartnerPosition(CH('Teammate1'))


end

---personality_test.GameLoad
--Engine callback function
function personality_test.GameLoad(map)
	PartnerEssentials.LoadGamePartnerPosition(CH('Teammate1'))
	personality_test.PlotScripting()
end


function personality_test.PlotScripting()
  if not SV.Chapter1.PlayedIntroCutscene then 
	personality_test.CharacterSelect()
  else
	GROUND:EnterGroundMap('metano_town', 'Main_Entrance_Marker') --fail safe. If player somehow gets to the personality test after seeing the first intro cutscene, warp them to metano town.
  end
end
-------------------------------
-- Entities Callbacks
-------------------------------


--Even though the map is called "personality test", it's really just a character select for the start of your adventure.
function personality_test.CharacterSelect()

	GAME:CutsceneMode(true)
	UI:ResetSpeaker()
	SOUND:FadeOutBGM()
--move camera to arbitrary position. Partner and hero will spawn in at 0,0 when they're created, so this is done to hide that without extra hassle.	
	GAME:MoveCamera(300, 300, 1, false) 
	
	--initialize some save data
	_DATA.Save.ActiveTeam:SetRank("unranked")
	_DATA.Save.ActiveTeam.Money = 0
	_DATA.Save.ActiveTeam.Bank = 0
	_DATA.Save.NoSwitching = true--switching is not allowed
	
	--remove any team members that may exist by default for some reason
	local party_count = _DATA.Save.ActiveTeam.Players.Count
	for ii = 1, party_count, 1 do
		_DATA.Save.ActiveTeam.Players:RemoveAt(0)
	end

	local assembly_count = GAME:GetPlayerAssemblyCount()
	for i = 1, assembly_count, 1 do
	   _DATA.Save.ActiveTeam.Assembly.RemoveAt(i-1)--not sure if this permanently deletes or not...
	end 
	
	
	GAME:WaitFrames(60)
  	UI:WaitShowVoiceOver("Welcome to the world of Pokémon!", -1)  
  	UI:WaitShowVoiceOver("Ahead of you lies a world full of exciting adventures\n and mysteries to discover!", -1)  
	UI:WaitShowVoiceOver("Before you go, you need to make some important decisions.", -1)  
	UI:WaitShowVoiceOver("Please think carefully before choosing!", -1)  
	UI:WaitShowVoiceOver("Now, make your choices!", -1) 
	GAME:WaitFrames(40)
	
	SOUND:PlayBGM("Welcome to the World of Pokémon!.ogg", true)
	GAME:FadeIn(40)
	GAME:WaitFrames(20)

	--Hero data
	local msg = "Your hero."
	--[[local choices = {'Bulbasaur', 'Charmander', 'Squirtle', 'Pikachu', 'Vulpix', 'Vulpix-A', 'Meowth', 'Machop', 
					 'Cubone', 'Chikorita', 'Cyndaquil', 'Totodile', 'Houndour', 'Phanpy', 'Magby',
					 'Larvitar', 'Treecko', 'Torchic', 'Mudkip', 'Poochyena', 'Ralts', 'Skitty',
					 'Turtwig', 'Chimchar', 'Piplup', 'Shinx', 'Buizel', 'Munchlax', 'Riolu',
					 'Snivy', 'Oshawatt', 'Lilliup', 'Zorua', 'Minccino', 'Vanillite', 'Mienfoo',
					 'Chespin', 'Fennekin', 'Froakie', 'Skiddo', 'Espurr', 'Amaura', 'Noibat',
					 'Rowlet', 'Litten', 'Rockruff', 'Fomantis', 'Scorbunny', 'Wooloo', 'Yamper'}
		]]--			
	local choices = {RogueEssence.Dungeon.MonsterID("bulbasaur", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("charmander", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("squirtle", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("pikachu", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("vulpix", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("vulpix", 1, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("meowth", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("machop", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("cubone", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("eevee", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("chikorita", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("cyndaquil", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("totodile", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("houndour", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("phanpy", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("magby", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("larvitar", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("treecko", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("torchic", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("mudkip", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("poochyena", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("ralts", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("skitty", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("turtwig", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("chimchar", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("piplup", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("shinx", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("buizel", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("munchlax", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("riolu", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("snivy", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("oshawott", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("lillipup", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("zorua", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("minccino", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("vanillite", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("mienfoo", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("chespin", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("fennekin", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("froakie", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("skiddo", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("espurr", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("amaura", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("noibat", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("rowlet", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("litten", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("popplio", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("rockruff", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("fomantis", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("scorbunny", 0, "normal", Gender.Genderless),
					--RogueEssence.Dungeon.MonsterID("wooloo", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("yamper", 0, "normal", Gender.Genderless),
					RogueEssence.Dungeon.MonsterID("sprigatito", 0, "normal", Gender.Genderless)}
					
	--not all moves listed are egg moves. Sometimes, egg move choices are too over or under powered and so something else had to be chosen				
	local egg_move_list = 
		{["bulbasaur"] = "sludge", --Sludge bulbasaur
		 ["charmander"] = "metal_claw", --metal claw, charmander 
		 ["squirtle"] = "icy_wind", --icy wind, squirtle		
		 ["pikachu"] = "disarming_voice", --disarming voice, pikachu
		 ["vulpix"] = "tail_slap", --tail slap, vulpix and vulpix-a
		 ["meowth"] = "foul_play", --foul play, meowth
		 ["machop"] = "bullet_punch", --bullet punch, machop
		 ["cubone"] = "double_kick", --double kick, cubone 
		 ["eevee"] = "double_kick", --double kick, eevee 
		 ["chikorita"] = "refresh", --refresh, chikorita
		 ["cyndaquil"] = "double_kick", --double kick, cyndaquil 
		 ["totodile"] = "aqua_jet", --aqua jet, totodile
		-- ["houndour"] = "thunder_fang", --thunder fang, houndour
		 ["phanpy"] = "ice_shard", --ice shard, phanpy
		-- ["magby"] = "thunder_punch", --thunder punch, magby
		 --["larvitar"] = "iron_head", --ironhead, larvitar
		 ["treecko"] = "dragon_breath",--dragon breath, treecko
		 ["torchic"] = "low_kick",--low kick, torchic
		 ["mudkip"] = "avalanche", --avalanche, mudkip
		 --["poochyena"] = "play_rough", --play rough, poochyena
		 --["ralts"] = "shadow_sneak", --shadow sneak, ralts
		 ["skitty"] = "zen_headbutt", --zen headbutt, skitty 
		 ["turtwig"] = "sand_tomb", --sand tomb, turtwig
		 ["chimchar"] = "thunder_punch", --thunder punch, chimchar
		 ["piplup"] = "icy_wind", --icy wind, piplup
		 ["shinx"] = "ice_fang", --icy fang, shinx 
		 --["buizel"] = "fury_cutter", --fury cutter, buizel 
		 ["munchlax"] = "zen_headbutt", --zen headbutt, munchlax
		 ["riolu"] = "bullet_punch", --bullet punch, riolu
		 ["snivy"] = "twister", --twister, snivy 
		 ["oshawott"] = "assurance", --assurance, oshawatt
		 --["lillipup"] = "fire_fang", --fire fang, lillipup
		 ["zorua"] = "copycat", --copycat, zorua 
		 --["minccino"] = "aqua_tail", --aqua tail, minccino
		 --["vanillite"] = "water_pulse", --water pulse, vanillite 
		 --["mienfoo"] = "knock_off", --knock off, mienfoo
		 ["chespin"] = "power_up_punch", --power up punch, chespin
		 ["fennekin"] = "wish", --wish, fennekin
		 ["froakie"] = "mud_sport", --mud sport froakie 
		 ["skiddo"] = "zen_headbutt", --zen headbutt, Skiddo
		 --["espurr"] = "assist", --assist, espurr (also bad egg moves)
		 --["amaura"] = "mirror_shot", --mirror coat, amaura (discharge is an absurdly busted option i could give it though)
		 --["noibat"] = "tailwind", --tailwind, noibat
		 ["rowlet"] = "confuse_ray", --Confuse Ray, rowlet
		 ["litten"] = "revenge", --revenge, litten 
		 --["popplio"] = "charm", --popplio, charm
		 ["rockruff"] = "thunder_fang", --thunder fang, rockruff
		 --["fomantis"] = "weather_ball", --weather ball, fomantis
		 ["scorbunny"] = "assurance", --assurance, scorbunny
		 --["wooloo"] = "counter", --counter, wooloo
		 ["yamper"] = "flame_charge", --flame charge, yamper
		 ["sprigatito"] = "copycat"} --sprigatito, copycat
	
	local continue = false 
	local hero_choice = -1
	
	while not continue do
		UI:ChooseMonsterMenu(msg, choices)
		UI:WaitForChoice()	
		local result = UI:ChoiceResult()
		hero_choice = result
		UI:ChoiceMenuYesNo("Is " .. _DATA:GetMonster(hero_choice.Species):GetColoredName() .. " correct?")
		UI:WaitForChoice()
		continue = UI:ChoiceResult()
	end
		

	
	local gender = 0
	local gender_choices = {'Boy', 'Girl', "Non-Binary"}
	UI:BeginChoiceMenu("Are you a boy, girl, or non-binary?", gender_choices, 1, 1)
	UI:WaitForChoice()
	gender = UI:ChoiceResult()
	
	if gender == 1 then
		gender = Gender.Male
	elseif gender == 2 then
		gender = Gender.Female
	else --dunno if this will cause issues with sprites to use
		gender = Gender.Genderless
	end
	
	local monster = _DATA:GetMonster(hero_choice.Species).Forms[hero_choice.Form]
	local ability = monster.Intrinsic1
	if monster.Intrinsic2 ~= "none" then--if pokemon has 2 abilities, let player choose which to get
		UI:BeginChoiceMenu("Which ability would you like to have?", {_DATA:GetIntrinsic(monster.Intrinsic1):GetColoredName(), _DATA:GetIntrinsic(monster.Intrinsic2):GetColoredName()}, 1, 1)
		UI:WaitForChoice()
		local result = UI:ChoiceResult()
		if result == 2 then ability = monster.Intrinsic2 end
	end
	

	
	
	--create hero with a species specific egg move and specific ability
	local mon_id = hero_choice
	mon_id.Gender = gender
	_DATA.Save.ActiveTeam.Players:Add(_DATA.Save.ActiveTeam:CreatePlayer(_DATA.Save.Rand, mon_id, 5, ability, 0))
	if GAME:GetCharacterSkill(GAME:GetPlayerPartyMember(0), 3) ~= "" then 
		GAME:SetCharacterSkill(GAME:GetPlayerPartyMember(0), egg_move_list[mon_id.Species], 3)--override move in slot 4 if 4 moves are known. They can always go see slowpoke to get it back
	else 
		GAME:LearnSkill(GAME:GetPlayerPartyMember(0), egg_move_list[mon_id.Species])
	end
	GAME:SetTeamLeaderIndex(0)
	


	--Partner data
	result = hero_choice
	continue = false
	local type_warning = true
	local partner_choice = 0
	local hero_type = nil
	local partner_type = nil
	
	while result.Species == hero_choice.Species or not continue do --do not allow same species for partner and player
		UI:ChooseMonsterMenu("Your partner.", choices)
		type_warning = true
		UI:WaitForChoice()
		result = UI:ChoiceResult()
		partner_choice = result
		if result.Species == hero_choice.Species then
			UI:WaitShowDialogue("Player and partner may not be the same species.[pause=0] Please choose again.")
		else
			hero_type = _DATA:GetMonster(hero_choice.Species).Forms[hero_choice.Form].Element1
			partner_type = _DATA:GetMonster(partner_choice.Species).Forms[partner_choice.Form].Element1
			if hero_type == partner_type then --warn player if types match
				UI:WaitShowDialogue("Warning![pause=0] Your hero and partner choices share the same primary type.")
				UI:WaitShowDialogue("This may make your adventure more difficult than normal.")
				UI:ChoiceMenuYesNo("Are you sure you wish to continue with these choices?")
				UI:WaitForChoice()
				type_warning = UI:ChoiceResult()
			end
			if type_warning then--if they agreed to continue after the warning, or never got the warning, then make sure their choice is correct
				UI:ChoiceMenuYesNo("Is " .. _DATA:GetMonster(partner_choice.Species):GetColoredName() .. " correct?")
				UI:WaitForChoice()
				continue = UI:ChoiceResult()
			end
		end	
	end 
	
	UI:BeginChoiceMenu("Your partner, are they a boy, girl, or non-binary?", gender_choices, 1, 1)
	UI:WaitForChoice()
	gender = UI:ChoiceResult()
	
	if gender == 1 then
		gender = Gender.Male
	elseif gender == 2 then
		gender = Gender.Female
	else --dunno if this will cause issues with sprites to use
		gender = Gender.Genderless
	end

	local monster = _DATA:GetMonster(partner_choice.Species).Forms[partner_choice.Form]
	local ability = monster.Intrinsic1
	if monster.Intrinsic2 ~= "none" then--if pokemon has 2 abilities, let player choose which to get
		UI:BeginChoiceMenu("Which ability would you like your partner to have?", {_DATA:GetIntrinsic(monster.Intrinsic1):GetColoredName(), _DATA:GetIntrinsic(monster.Intrinsic2):GetColoredName()}, 1, 1)
		UI:WaitForChoice()
		result = UI:ChoiceResult()
		if result == 2 then ability = monster.Intrinsic2 end
	end
	
	mon_id = partner_choice
	mon_id.Gender = gender
	_DATA.Save.ActiveTeam.Players:Add(_DATA.Save.ActiveTeam:CreatePlayer(_DATA.Save.Rand, mon_id, 5, ability, 0))--dunno what the -1 and 0 are exactly...
	if GAME:GetCharacterSkill(GAME:GetPlayerPartyMember(1), 3) ~= "" then 
		GAME:SetCharacterSkill(GAME:GetPlayerPartyMember(1), egg_move_list[mon_id.Species], 3)--override move in slot 4 if 4 moves are known. They can always go see slowpoke to get it back
	else 
		GAME:LearnSkill(GAME:GetPlayerPartyMember(1), egg_move_list[mon_id.Species])
	end
	--set player and partner to founders so they cannot be released
	--set them as partner so they cannot be taken off the active team
    _DATA.Save:UpdateTeamProfile(true)
    _DATA.Save.ActiveTeam.Players[0].IsFounder = true
	_DATA.Save.ActiveTeam.Players[0].IsPartner = true

	_DATA.Save.ActiveTeam.Players[1].IsFounder = true
	_DATA.Save.ActiveTeam.Players[1].IsPartner = true

	--give the duo a small perma stat bonus
	--_DATA.Save.ActiveTeam.Players[0].MaxHPBonus = 1
	--_DATA.Save.ActiveTeam.Players[0].AtkBonus = 1
	--_DATA.Save.ActiveTeam.Players[0].DefBonus = 1
	--_DATA.Save.ActiveTeam.Players[0].MAtkBonus = 1
	--_DATA.Save.ActiveTeam.Players[0].MDefBonus = 1

	--_DATA.Save.ActiveTeam.Players[1].MaxHPBonus = 1
	--_DATA.Save.ActiveTeam.Players[1].AtkBonus = 1
	--_DATA.Save.ActiveTeam.Players[1].DefBonus = 1
	--_DATA.Save.ActiveTeam.Players[1].MAtkBonus = 1
	--_DATA.Save.ActiveTeam.Players[1].MDefBonus = 1
	--_DATA.Save.ActiveTeam.Players[1].SpeedBonus = 1
	
	_DATA.Save.ActiveTeam.Players[0]:FullRestore()--set hp/pp to full for player and partner
	_DATA.Save.ActiveTeam.Players[1]:FullRestore()
	
	
	--assign dungeon AIs
	local talk_evt = RogueEssence.Dungeon.BattleScriptEvent("HeroInteract")
	_DATA.Save.ActiveTeam.Players[0].ActionEvents:Add(talk_evt)
	
	talk_evt = RogueEssence.Dungeon.BattleScriptEvent("PartnerInteract")
	_DATA.Save.ActiveTeam.Players[1].ActionEvents:Add(talk_evt)

  
	local yesnoResult = false 
	while not yesnoResult do
		UI:NameMenu("What is your partner's name?", "It is highly recommended to give a nickname.", 60)
		UI:WaitForChoice()
		result = UI:ChoiceResult()
		--if no name given, set name to species name
		if result == "" then result = _DATA:GetMonster(GAME:GetPlayerPartyMember(1).CurrentForm.Species).Name:ToLocal() end
		UI:ChoiceMenuYesNo("Is [color=#FFFF00]" .. result .. "[color] correct?")
		UI:WaitForChoice()
		yesnoResult = UI:ChoiceResult()
	end

	
	local hero = GAME:GetPlayerPartyMember(0)
	local partner = GAME:GetPlayerPartyMember(1)

	
	GAME:SetCharacterNickname(partner, result)
	GAME:SetTeamName(result) --set team name to partner's name temporarily
	COMMON.RespawnAllies()
	
	GAME:WaitFrames(60)
  
	
	--assign custom variables to the hero and partner to mark them as hero and partner
	local hTbl = LTBL(hero)
	local pTbl = LTBL(partner)
	hTbl.Importance = 'Hero'
	pTbl.Importance = 'Partner'
	
	--for beta testing only: skip to another chapter?
	--[[
	UI:ChoiceMenuYesNo("Would you like to skip to Chapter 2?", true)
	UI:WaitForChoice()
	yesnoResult = UI:ChoiceResult()
	if yesnoResult then 
		 yesnoResult = false
		while not yesnoResult do
			UI:NameMenu("What will your name be?", "", 60)
			UI:WaitForChoice()
			result = UI:ChoiceResult()
			GAME:SetCharacterNickname(GAME:GetPlayerPartyMember(0), result)
			UI:ChoiceMenuYesNo("Is [color=#FFFF00]" .. result .. "[color] correct?")
			UI:WaitForChoice()
			yesnoResult = UI:ChoiceResult()
		end
		
		yesnoResult = false
		while not yesnoResult do
			UI:NameMenu("What will your team's name be?", "You don't need to put 'Team' in the name itself.", 60)
			UI:WaitForChoice()
			result = UI:ChoiceResult()
			GAME:SetTeamName(result)
			UI:ChoiceMenuYesNo("Is Team " .. GAME:GetTeamName() .. " correct?", true)
			UI:WaitForChoice()
			yesnoResult = UI:ChoiceResult()
		end
		--set chapter 1 flags to true, note that you can skip talking to guild NPCs but this will mark them as met already
		SV.Chapter1 = 
			{
				PlayedIntroCutscene = true,
				PartnerEnteredForest = true,--Did partner go into the forest yet?
				PartnerCompletedForest = true,--Did partner complete solo run of first dungeon?
				PartnerMetHero = true,--Finished partner meeting hero cutscene in the relic forest?
				TeamCompletedForest = true, --completed backtrack to town?
				TeamJoinedGuild = true,--team officially joined guild? this flag lets you walk around guild without triggering cutscenes to talk to different guildmates

				--these flags mark whether you've talked to your new guild buddies yet. Need to talk to them all to go to sleep and end the chapter.
				MetSnubbull = true,--talked to snubbull?
				MetZigzagoon = true,
				MetCranidosMareep = true,
				MetBreloomGirafarig = true,
				MetAudino = true,
				
				--partner dialogue flag on second floor
				PartnerSecondFloorDialogue = 0
			}
		SV.ChapterProgression.Chapter = 2
		GAME:GivePlayerItem("held_synergy_scarf", 2)--give 2 vibrant scarves
		_DATA.Save.ActiveTeam:SetRank("normal")
		GAME:UnlockDungeon("relic_forest")
		GAME:UnlockDungeon("illuminant_riverbed")

		GAME:CutsceneMode(false)
		SOUND:FadeOutBGM(120)
		GAME:WaitFrames(120)
		GAME:EnterGroundMap("guild_heros_room", "Main_Entrance_Marker")
		return
	end
	 ]]--
	
	SOUND:FadeOutBGM(120)
	GAME:FadeOut(false, 120)
	GAME:WaitFrames(120)
	GAME:CutsceneMode(false)
	GAME:EnterGroundMap('relic_forest', 'Main_Entrance_Marker')
end

return personality_test

