local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	if npcHandler.topic[cid] == 1 then
		if msgcontains(msg, "yes") then
			setPlayerStorageValue(cid, 10001, 1)
			npcHandler:say({
				"Thanks so much! The only thing I know about my friend that might be useful is that he was very interested in furred animals DNA...",
				"He would thus chase furred animals and research on it's fur. There's a wolf cave very close south of the village, look there!"
			}, cid)	
		else
			npcHandler:say("Tell me whenever you want to help me, because I will reward you well!", cid)
		end
		npcHandler.topic[cid] = 0
	
	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, "yes") then
			if doPlayerRemoveItem(cid, 1986, 1) then
				setPlayerStorageValue(cid, 10001, 3)
				doPlayerAddItem(cid, 2526, 1)
				playerLearnInstantSpell(cid, "Weak Sweep")
				doSendMagicEffect(getThingPosition(cid), CONST_ME_MAGIC_BLUE)
				npcHandler:say({
					"Oh god thank you! Thanks to your dedication I will hereby reward you with this strong and very useful studded shield...",
					"I will also reward you with the useful spell {Weak Sweep}, look up the spell in one of the local spellbooks here in the village." 
				}, cid)
			end
		else
			npcHandler:say("Okay, please find it and return it to me!", cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "mission") or msgcontains(msg, "quest") then
		local storageValue = getPlayerStorageValue(cid, 10001)
		if storageValue == -1 then
			npcHandler:say({
				"I lent a very special book to a very special friend that contained formulas from ancient times...",
				"Since then I have not seen him or my book. I really do not think he has stolen it, I trust him. But something must have happened to him. Would you help me find my friend and my book?"
			}, cid)
			npcHandler.topic[cid] = 1
		elseif storageValue >= 1 then
			npcHandler:say("Did you find my book?", cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "weak sweep") then
		npcHandler:say({
			"Weak Sweep is a spell that was formed out for beginners, the main purpose of the spell is to make rookies a bit more powerful...",
			"This spell has to be earned in order to be used, therefore not everyone may use it. If you do not already have proven yourself helpful ask me for a {mission}."
		}, cid)
	elseif msgcontains(msg, "talisandria") then
		npcHandler:say("That town is just too crowded for my taste.", cid)
	elseif msgcontains(msg, "wildmire") then
		npcHandler:say("That is our village! So peaceful...", cid)
	elseif msgcontains(msg, "dylan") then
		npcHandler:say("No one really knows how and when Dylan came to the village. It is said that he has royal blood. He is an intellectual man for sure!", cid)
	elseif msgcontains(msg, "library") then
		npcHandler:say("This is the royal library, {Dylan} is working in the library. Ask your questions to him.", cid)
	elseif msgcontains(msg, "quaras") then
		npcHandler:say("Quaras are evil killers! They sneaks up on shore at night only to sabotage and murder. Stay safe at night.", cid)
	elseif msgcontains(msg, "activity") then
		npcHandler:say("The guards in the village fears the worst, namely {quaras}. ", cid)
	elseif msgcontains(msg, "rich") then
		npcHandler:say("If we are rich, yes. You just need to walk up the stairs over there and see for yourself.", cid)
	elseif msgcontains(msg, "village") then
		npcHandler:say({
			"This village is generally very good. We are {rich} and are very well protected by our wall. However...",
			"In recent times we have noticed unusual {activity} in our waters. It has also proven to be very strange disappearances in the village lately, so be on your guard!"
		}, cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
