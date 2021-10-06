require 'common'
require 'PartnerEssentials'
require 'GeneralFunctions'
require 'CharacterEssentials'

guild_storage_hallway_ch_1 = {}



--[[function guild_storage_hallway_ch_1.SetupGround()
	local groundObj = RogueEssence.Ground.GroundObject(RogueEssence.Content.ObjAnimData("", 0), 
														RogueElements.Rect(144, 88, 64, 16),
														RogueElements.Loc(0, 8), 
														true, 
														"Event_Trigger")
	  groundObj:ReloadEvents()
	  GAME:GetCurrentGround():AddObject(groundObj)
	  
	  GAME:FadeIn(20)
end]]--

function guild_storage_hallway_ch_1.MeetAudino()
	
	local hero = CH('PLAYER')
	local partner = CH('Teammate1')
	
	local audino = CharacterEssentials.MakeCharactersFromList({
		{'Audino', -20, 172, Direction.Right}
	})
	
	GAME:CutsceneMode(true)
	AI:DisableCharacterAI(partner)
	GROUND:TeleportTo(hero, 168, -24, Direction.Down)
	GROUND:TeleportTo(partner, 168, -56, Direction.Down)
	GAME:FadeIn(20)
	--GROUND:Hide("Event_Trigger")
	
	--UI:SetSpeaker(STRINGS:Format("\\uE040"), true, -1, -1, -1, RogueEssence.Data.Gender.Unknown)
	--UI:WaitShowDialogue("C-coming through!")

--[[	coro1 = TASK:BranchCoroutine(function() GeneralFunctions.EmoteAndPause(hero, "Question", true)
											GROUND:CharAnimateTurnTo(hero, Direction.Right, 4)
											GAME:WaitFrames(10)
											GROUND:CharAnimateTurnTo(hero, Direction.Left, 4)
											GROUND:CharSetEmote(hero, 8, 1) end)
	local coro2 = TASK:BranchCoroutine(function() GAME:WaitFrames(10) 
												  GeneralFunctions.EmoteAndPause(partner, "Question", false)
												  GROUND:CharAnimateTurnTo(partner, Direction.Left, 4)
												  GAME:WaitFrames(10)
											      GROUND:CharAnimateTurnTo(partner, Direction.Down, 4) end) ]]--
					
	local coro1 = TASK:BranchCoroutine(function() GROUND:MoveToPosition(hero, 168, 172, false, 1) end)
	local coro2 = TASK:BranchCoroutine(function() GROUND:MoveToPosition(partner, 168, 140, false, 1) end)
	local coro3 = TASK:BranchCoroutine(function() GAME:WaitFrames(153) 
												  GROUND:MoveToPosition(audino, 152, 172, true, 4) end)
	TASK:JoinCoroutines({coro1, coro2})
	
	UI:SetSpeaker(STRINGS:Format("\\uE040"), true, audino.CurrentForm.Species, audino.CurrentForm.Form, audino.CurrentForm.Skin, audino.CurrentForm.Gender)
	UI:SetSpeakerEmotion("Pain")
	
	--you two dopes run into each other
	SOUND:PlayBattleSE('EVT_Tackle')
	coro1 = TASK:BranchCoroutine(function() GROUND:AnimateInDirection(hero, "Pain", Direction.Left, Direction.Right, 4, 1, 4) 
											GROUND:CharPoseAnim(hero, "Pain") end)
	coro2 = TASK:BranchCoroutine(function() GROUND:AnimateInDirection(audino, "Hurt", Direction.Right, Direction.Left, 4, 1, 2) 
												  GROUND:CharSetAnim(audino, "Hurt", true) end)
	coro3 = TASK:BranchCoroutine(function() GAME:WaitFrames(10)
											GeneralFunctions.EmoteAndPause(partner, 'Shock', false) end)
	local coro4 = TASK:BranchCoroutine(function() UI:WaitShowTimedDialogue("Urf!", 60) end)
	--local coro5 = TASK:BranchCoroutine(function() GROUND:AnimateInDirection(partner, "Walk", Direction.Left, Direction.Right, 4, 1, 3) end)
	
	TASK:JoinCoroutines({coro1, coro2, coro3, coro4})
	
	
	--GROUND:CharTurnToChar(partner, audino)
	GROUND:CharSetAnim(audino, "None", true)
	GAME:WaitFrames(20)
	UI:SetSpeakerEmotion("Dizzy")
	UI:WaitShowDialogue("Hey...[pause=0] Who made everything spinny...")
	GAME:WaitFrames(20)
	
	
	GeneralFunctions.ShakeHead(audino, 4, true)
	GAME:WaitFrames(20)
	GeneralFunctions.EmoteAndPause(audino, "Exclaim", true)
	UI:SetSpeakerEmotion("Surprised")
	UI:WaitShowDialogue("Goodness![pause=0] Are you alright?")
	GAME:WaitFrames(20)
	
	UI:WaitShowDialogue("Oh no,[pause=10] d-did I h-hurt you?")
	UI:SetSpeakerEmotion("Teary-Eyed")
	GROUND:CharSetEmote(audino, 5, 1)
	SOUND:PlayBattleSE('EVT_Emote_Sweating')
	UI:WaitShowDialogue("I'm s-so sorry![pause=0] I d-didn't m-mean to!")
	UI:WaitShowDialogue("It was an a-accident...[pause=0] I'm sorry...")
	GAME:WaitFrames(20)
	
	--todo: shake before getting up
	--GROUND:CharTurnToChar(partner, hero)
	GeneralFunctions.HeroDialogue(hero, "(Urgh...)", "Dizzy")
	GeneralFunctions.HeroDialogue(hero, "(That bonk was enough to give me double amnesia...)", "Dizzy")
	GAME:WaitFrames(20)
	
	--if you got hurt... I'd...
	GROUND:CharWaitAnim(hero, "Wake")
	GROUND:CharSetAnim(hero, "None", true)
	GAME:WaitFrames(20)
	
	--GROUND:CharTurnToChar(partner, audino)
	UI:SetSpeaker(STRINGS:Format("\\uE040"), true, audino.CurrentForm.Species, audino.CurrentForm.Form, audino.CurrentForm.Skin, audino.CurrentForm.Gender)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Are you o-okay?[pause=0] I'm sorry,[pause=10] I didn't mean to b-barge into you like that...")
	GAME:WaitFrames(20)
	
	--GROUND:CharTurnToChar(partner, hero)
	GeneralFunctions.DoAnimation(hero, "Nod", false)
	GAME:WaitFrames(20)
	
	--GROUND:CharTurnToChar(partner, audino)
	UI:SetSpeakerEmotion("Sigh")
	UI:WaitShowDialogue("Oh thank goodness.[pause=0] I'm glad you're not hurt.")
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("I hate even the idea of hurting others....")
	UI:SetSpeakerEmotion("Teary-Eyed")
	--todo:shake loop
	UI:WaitShowDialogue("If I had h-hurt you...[pause=0] I'd...[pause=0] I'd...")
	GAME:WaitFrames(20)
	
	GROUND:CharSetEmote(audino, 4, 0)
	UI:SetSpeakerEmotion("Joyous")
	UI:WaitShowDialogue("But you're okay![pause=10] Yay!")
	GAME:WaitFrames(20)
	GROUND:CharSetEmote(audino, -1, 0)
	
	GROUND:CharTurnToChar(partner, audino)
	UI:SetSpeaker(partner)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("What had you in such a hurry anyway?")
	GAME:WaitFrames(20)
	
	GROUND:CharTurnToChar(audino, partner)
	UI:SetSpeaker(STRINGS:Format("\\uE040"), true, audino.CurrentForm.Species, audino.CurrentForm.Form, audino.CurrentForm.Skin, audino.CurrentForm.Gender)
	UI:WaitShowDialogue("Oh,[pause=10] I'm just taking care of the chores around the guild.")
	UI:WaitShowDialogue("I have so much to do tonight that I have to run to get them all done before bedtime.")
	GAME:WaitFrames(20)
	
	GeneralFunctions.EmoteAndPause(audino, "Exclaim", true)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Hey...[pause=0] I just realized I've never met you two before...[pause=0] Who are you?")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(partner)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Right,[pause=10] we haven't introduced ourselves.")
	UI:WaitShowDialogue("I'm " .. partner:GetDisplayName() .. " and my partner there is " .. hero:GetDisplayName() .. ".[pause=0] We're a new adventuring team.")
	UI:WaitShowDialogue("We just joined the guild a little while ago.")
	GAME:WaitFrames(20)
	
	GROUND:EntTurn(audino, Direction.DownRight)
	UI:SetSpeaker(STRINGS:Format("\\uE040"), true, audino.CurrentForm.Species, audino.CurrentForm.Form, audino.CurrentForm.Skin, audino.CurrentForm.Gender)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("New guild members?[pause=0] That's more work to add to my chore list...")
	GAME:WaitFrames(20)
	
	GeneralFunctions.EmoteAndPause(audino, 'Exclaim', true)
	GROUND:CharAnimateTurnTo(audino, Direction.Right, 4)
	GROUND:CharSetEmote(audino, 5, 1)
	UI:SetSpeakerEmotion("Surprised")
	UI:WaitShowDialogue("B-but don't worry about that![pause=0] It's no t-trouble at all!")
	UI:SetSpeakerEmotion("Normal")
	--UI:WaitShowDialogue("With the messes that " .. CharacterEssentials.GetCharacterName("Cranidos") .. " makes,[pause=10] you'd have to try to be give me more work than he does!")
	UI:WaitShowDialogue("It's not that m-much more work![pause=0] It's part of my job,[pause=10] so it's no problem!")
	GAME:WaitFrames(20)
	
	UI:WaitShowDialogue("I'm " .. audino:GetDisplayName() .. "![pause=0] I'm an apprentice here at the guild too!")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(partner)
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("Glad to meet you " .. audino:GetDisplayName() .. "!")
	GAME:WaitFrames(20)
	
	--what were you doing here rin? oh i was in the guldmasters room tidying up, dont go in there though
	GROUND:CharTurnToChar(audino, partner)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("What were you up to in that room behind you anyway?")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(audino)
	UI:WaitShowDialogue("That's the Guildmaster's quarters.[pause=0] I was tidying up in there for him.")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(partner)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("The Guildmaster's quarters,[pause=10] huh?[pause=0] I figured that the room we spoke to him in was his quarters.")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(audino)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("That room is more like his office.[pause=0] His actual bedroom is right down this hall.[pause=0] But...")
	UI:WaitShowDialogue("The Guildmaster doesn't like anyone going into his room.[pause=0] He only allows me to so I can take care of the chores.")
	UI:SetSpeakerEmotion("Sad")
	UI:WaitShowDialogue("S-so please don't go in his room.[pause=0] I don't w-want to see you guys getting in trouble.")
	GAME:WaitFrames(20)
	
	UI:SetSpeaker(partner)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("Oh,[pause=10] alright.[pause=0] We'll stay away from that room then.")
	GAME:WaitFrames(20)
	
	
	UI:SetSpeaker(audino)
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("It's no problem![pause=0] I-If you ever need help with anything,[pause=10] let me know,[pause=10] OK?")
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("I promise I won't r-ram into you again like earlier![pause=0] S-Sorry again!")
	GAME:WaitFrames(20)
	UI:WaitShowDialogue("I have to get back to my chores before it gets any later.[pause=0] Stay safe!")
	--runs, realizes it'll happen again, starts to walk
	
	coro1 = TASK:BranchCoroutine(function() GAME:WaitFrames(30)
											GROUND:MoveToPosition(audino, 168, audino.Position.Y, false, 2)
											GROUND:MoveToPosition(audino, 168, -20, false, 2) 
											GROUND:Hide("Audino") end)
	coro2 = TASK:BranchCoroutine(function() GROUND:MoveInDirection(partner, Direction.Right, 32, false, 1) 
											GeneralFunctions.FaceMovingCharacter(partner, audino, 4, Direction.UpLeft) end)
	coro3 = TASK:BranchCoroutine(function() GROUND:AnimateInDirection(hero, "Walk", Direction.Left, Direction.Right, 8, 1, 1)
											GeneralFunctions.FaceMovingCharacter(hero, audino, 4, Direction.Up) end)

	TASK:JoinCoroutines({coro1, coro2, coro3})
	
	GROUND:CharTurnToCharAnimated(partner, hero, 4)
	GROUND:CharTurnToCharAnimated(hero, partner, 4)
	UI:SetSpeaker(partner)
	UI:SetSpeakerEmotion("Worried")
	UI:WaitShowDialogue("Well,[pause=10] that was certainly something.[pause=0] I wonder how often she bumps into others like that...")
	UI:SetSpeakerEmotion("Happy")
	UI:WaitShowDialogue("She seemed nice enough though.")
	GAME:WaitFrames(40)
	
	GROUND:CharAnimateTurnTo(partner, Direction.Right, 4)
	GAME:WaitFrames(60)
	GROUND:CharTurnToCharAnimated(partner, hero, 4)
	UI:SetSpeakerEmotion("Normal")
	UI:WaitShowDialogue("I bet there's really cool trinkets and treasures in the Guildmaster's room.")
	UI:WaitShowDialogue("Surely a world class adventurer would have found a lot of cool stuff in his time!")
	UI:WaitShowDialogue("Too bad we can't go in there though...[pause=0] I'd like to see some of his treasure some day though.")
	GAME:WaitFrames(20)
	
	
	AI:SetCharacterAI(partner, "ai.ground_partner", CH('PLAYER'), partner.Position)
	AI:EnableCharacterAI(partner)
	GAME:CutsceneMode(false)
	
	
	
end