require 'common'
require 'PartnerEssentials'
require 'GeneralFunctions'
require 'CharacterEssentials'

metano_fire_home_ch_5 = {}

function metano_fire_home_ch_5.SetupGround()

	local camerupt  = 
		CharacterEssentials.MakeCharactersFromList({
			{'Camerupt', 256, 136, Direction.Down}
		})

	
	GAME:FadeIn(20)
end

function metano_fire_home_ch_5.Camerupt_Action(chara, activator)
	GeneralFunctions.StartConversation(chara, "My baby boy's been working so hard lately,[pause=10] I'm so proud of him!", "Happy")
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("I've been rewarding him with Lava Cakes when he finishes all of his chores for the day, but...")
	UI:WaitShowDialogue("I may need to cut down on how many I give him.[pause=0] I don't want him to start getting chubby!")
	GeneralFunctions.EndConversation(chara)
end 
