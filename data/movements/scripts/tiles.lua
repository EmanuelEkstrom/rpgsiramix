
function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if player == nil then
		return false
	end
	
	if item.actionid == 10004 and player:getLevel() < 3 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Only players who are level 3 or higher can cross this bridge.")
		player:teleportToEx(Position(1026, 1021, 7), player:isGhost(), nil, CONST_ME_MAGIC_BLUE)
		return true
	end
	return false
end