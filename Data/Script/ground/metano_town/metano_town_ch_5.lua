require 'common'
require 'PartnerEssentials'
require 'GeneralFunctions'
require 'CharacterEssentials'

metano_town_ch_5 = {}

function metano_town_ch_5.SetupGround()
	GROUND:Hide('Swap_Owner')
	GROUND:Hide('Swap')
	
	local growlithe = CH('Growlithe')
	
	if not SV.Chapter5.TalkedToSnubbull then
		local snubbull =
			CharacterEssentials.MakeCharactersFromList({
				{'Snubbull', 1056, 864, Direction.Up}
			})
	end
	
	local mareep, cranidos, gloom, nidorina, electrike = 
		CharacterEssentials.MakeCharactersFromList({
			{'Mareep', 1180, 1304, Direction.UpLeft},
			{'Cranidos', 1204, 1304, Direction.Left},
			{'Gloom', 512, 184, Direction.DownRight},
			{'Nidorina', 536, 208, Direction.UpLeft},
			{'Electrike', 464, 576, Direction.Up},
			
		})
		



	--Move Growlithe from his desk
	GROUND:TeleportTo(growlithe, 1132, 928, Direction.DownLeft)

	AI:SetCharacterAI(snubbull, "ai.ground_default", RogueElements.Loc(1040, 848), RogueElements.Loc(32, 32), 1, 16, 32, 40, 180)
	
	
	GAME:FadeIn(20)
	
end


--She is getting supplies from Kec. She goes inside to the storage room after you talk
--to her to get her out of the way
function metano_town_ch_5.Snubbull_Action()

end 




