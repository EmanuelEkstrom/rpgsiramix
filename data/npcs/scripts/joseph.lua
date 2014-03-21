local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

npcHandler:addModule(FocusModule:new())

local function creatureSayCallback(cid, type, msg)
        if(not npcHandler:isFocused(cid)) then
                return false
        end
        
	if msgcontains(msg, "talisandria") then
		npcHandler:say("A great city, however a little bit crowded for my taste. I got a few friends over there though, would love to hear from them more oftenly!", cid)
	elseif msgcontains(msg, "wildmire") then
		npcHandler:say("Yeah I would love to get out of here one day. Still bannished from Talisandria!", cid)
	elseif msgcontains(msg, "bannished") then
		npcHandler:say("Yes, bannished. I murdered a man thirty years ago. I am still being punished. I hate it here.", cid)
	elseif msgcontains(msg, "dylan") then
		npcHandler:say("I met him in the bar the other night, strange man.", cid)
	elseif msgcontains(msg, "lucy") then
		npcHandler:say("A lot of the local slugs want to nail that girl to the wall.", cid)
	elseif msgcontains(msg, "witch") then
		npcHandler:say("Dont talk about that hag. I hate her!", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)