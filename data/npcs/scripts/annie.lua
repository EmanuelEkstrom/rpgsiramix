local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

npcHandler:addModule(FocusModule:new())

function healPlayer(cid, message, keywords, parameters, node)
	local health = getCreatureHealth(cid)
	local player = Player(cid)
	if health <= getCreatureMaxHealth(cid) / 100 * 15  then
			npcHandler:say('Exura sio "'.. getCreatureName(cid) ..'". Your wounds have been healed!', cid)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
		else
			npcHandler:say('I only heal wounded players. You look fine, child!', cid)
		end
	return true
end

local node1 = keywordHandler:addKeyword({'heal'}, healPlayer)
	npcHandler:addModule(FocusModule:new())

local function creatureSayCallback(cid, type, msg)
        if(not npcHandler:isFocused(cid)) then
                return false
        end

	if msgcontains(msg, "talisandria") then
		npcHandler:say("A great city, however a little bit crowded for my taste. I got a few friends over there though, would love to hear from them more oftenly!", cid)
	elseif msgcontains(msg, "wildmire") then
		npcHandler:say("Do you feel the calm, fresh air breezing over your shoulders? That is Wildmire!", cid)
	elseif msgcontains(msg, "dylan") then
		npcHandler:say("Dylan is a strange man, I know absolutely nothing about him other than he knows his books.", cid)
	elseif msgcontains(msg, "lucy") then
		npcHandler:say("A remarkable woman. My sister! She is very academic, I love her.", cid)
	elseif msgcontains(msg, "help") then
		npcHandler:say({
			"So you need help? I can give you some guidelines on how to get on going here in Wildmire...",
			"You start by going down the sewers to get some experience by killing rats. Make sure to collect the gold they drop, would not wanna miss that!...",
			"When you have enough money to buy yourself a rope and a shovel, visit Gregor in the village. He owns a toolshop...",
			"Once you reach level 3 you are allowed to leave the village from the east exit, however you can leave sooner from the north exit...",
			"As soon as you reach level 8 I suggest you to go talk to Wildmires one and only {witch}. She will grant you a vocation of your choice...",
			"When you received a vocation you are no longer welcomed here in Wildmire. As soon as you reach level 9 in Wildmire you are not able to leave.",
			"Anything else I can assist you with?"
		}, cid)
	elseif msgcontains(msg, "witch") then
		npcHandler:say("Ursula! She is not an ordinary witch, she studies the path of magic, strenght and accuracy. Pay her a visit when you reach level 8.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)