require 'common'
require 'PartnerEssentials'
require 'GeneralFunctions'
require 'CharacterEssentials'

metano_normal_home_ch_5 = {}

function metano_normal_home_ch_5.SetupGround()
	local furret, linoone, sentret = 
		CharacterEssentials.MakeCharactersFromList({
			{'Furret', 104, 152, Direction.Right},
			{'Linoone', 104, 152, Direction.Right},
			{'Sentret', 104, 152, Direction.Right}
		})
			
end

--his family sees him off. Wishes him luck, tells him to stay safe, find something cool, etc.
function metano_normal_home_ch_5.Farewell_Cutscene()
	local hero = CH('PLAYER')
	local partner = CH('Teammate1')
	
	local furret = CH('Furret')
	local linoone = CH('Linoone')
	local sentret = CH('Sentret')
	
	local zigzagoon = CharacterEssentials.MakeCharactersFromList({
			{'Zigzagoon', 168, 144, Direction.Up}
		})
	
	GROUND:TeleportTo(linoone, 152, 112, Direction.Down)
	GROUND:TeleportTo(furret, 180, 112, Direction.Down)
	GROUND:TeleportTo(sentret, 140, 120, Direction.DownRight)
	
	GeneralFunctions.CenterCamera({hero, partner})
	
	SOUND:FadeOutBGM(60)
	GAME:FadeIn(60)
	
	GAME:WaitFrames(40)
	
	GeneralFunctions.PanCamera(172, 136)
	
	GAME:WaitFrames(20)
	--SOUND:PlayBGM("")
	
	
	
	
end

--Have fun! Make sure to get plenty of rest!
function metano_normal_home_ch_5.Furret_Action(chara, activator)

	GeneralFunctions.EndConversation(chara)
end

--woah an expedition is so cool! Adventurers are so cool! I want to be like my big brother one day!
function metano_normal_home_ch_5.Sentret_Action(chara, activator)

	GeneralFunctions.EndConversation(chara)
end

--todo: portraits once linoone gets them
function metano_normal_home_ch_5.Linoone_Action(chara, activator)
	GeneralFunctions.StartConversation(chara, "You two are adventurers with the guild,[pause=10] aren't you?[pause=0] My son,[pause=10] " .. CharacterEssentials.GetCharacterName("Zigzagoon") .. ",[pause=10] has talked about you some.")
	UI:WaitShowDialogue("Please keep an eye out for him.[pause=0] He's careful and very knowledgable on the mystery dungeons you're sure to encounter on this expedition,[pause=10] but...")
	UI:WaitShowDialogue("As his mother,[pause=10] I can't help but worry for his safety.[pause=0] Make sure he stays safe,[pause=10] would you please?")
	GeneralFunctions.EndConversation(chara)
end 