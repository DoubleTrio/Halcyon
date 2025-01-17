require 'common'
require 'PartnerEssentials'
require 'GeneralFunctions'
require 'CharacterEssentials'

metano_inn_ch_5 = {}

function metano_inn_ch_5.SetupGround()
	

	GAME:FadeIn(20)
end


function metano_inn_ch_5.Passerby_1_Action(chara, activator)
	if not SV.Chapter4.FinishedGrove then 
		GeneralFunctions.StartConversation(chara, "I hope I didn't leave a paint stain on the bed while I was sleeping.")
		UI:SetSpeakerEmotion("Worried")
		UI:WaitShowDialogue("I don't want to pay an extra fee if I left a mark on the bed by accident...")
	else 
		GeneralFunctions.StartConversation(chara, "The inn's food is so good![pause=0] So much better than the slop back home!", "Inspired")
	end
	GeneralFunctions.EndConversation(chara)
end

function metano_inn_ch_5.Nidoqueen_Action(chara, activator)
	if not SV.Chapter4.FinishedGrove then
		GeneralFunctions.StartConversation(chara, "C'mon " .. CharacterEssentials.GetCharacterName("Nidoran_M") .. "![pause=0] Say mama,[pause=10] say mama!", "Normal", false)
	else
	
	end
	GeneralFunctions.EndConversation(chara)	
end

function metano_inn_ch_5.Nidorina_Action(chara, activator)
	if not SV.Chapter4.FinishedGrove then
		--N/A
	else
		--this might be nidorina's calling? cooking, that is
		GeneralFunctions.StartConversation(chara, "Stupid parents making me work in the inn again...[pause=0] Making me prepare the food...", "Determined")
		UI:WaitShowDialogue("I don't want to work in this dumb inn![pause=0] But they don't get that,[pause=10] of course not!")
	end
	GeneralFunctions.EndConversation(chara)
end

function metano_inn_ch_5.Nidoran_M_Action(chara, activator)
	GeneralFunctions.StartConversation(chara, "Inneeways!")
	GeneralFunctions.EndConversation(chara)
end


function metano_inn_ch_5.Innkeeper_Desk_Right_Action(chara, activator) 
	if not SV.Chapter4.FinishedGrove then
		--N/A
	else 
		local nidoqueen = CH('Nidoqueen')
		GeneralFunctions.StartConversation(nidoqueen, "I'm startin' to worry about my littlest one.", "Worried")
		UI:WaitShowDialogue("He shoulda said his first word by now...[pause=0] I'm hopin' he'll say his first real soon!")
		GeneralFunctions.EndConversation(nidoqueen)
	end
end

function metano_inn_ch_5.Innkeeper_Desk_Left_Action(chara, activator) 
	if not SV.Chapter4.FinishedGrove then
		local nidoking = CH('Nidoking')
		GeneralFunctions.StartConversation(nidoking, "Business been a bit slow as of late...[pause=0] Seems like we only get one 'er so guests a day!", "Worried")
		UI:WaitShowDialogue("I reckon less Pokémon are on the roads what with the mystery dungeons and outlaws 'n all...")
		GeneralFunctions.EndConversation(nidoking)	
	else 
	
	end
end