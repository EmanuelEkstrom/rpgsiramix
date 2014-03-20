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
	if health <= 30 then
			doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
			npcHandler:say('Your wounds have been healed!', cid)
		else
			npcHandler:say('I only heal wounded players!', cid)
		end
	return true
end

-- Node appear to start a talkstate, etc 'heal'
local node1 = keywordHandler:addKeyword({'heal'}, healPlayer)
	npcHandler:addModule(FocusModule:new())