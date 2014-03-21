
function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if player == nil then
		return true
	end
	
	player:say("STEP AWAY FROM US!", TALKTYPE_ORANGE_1, false, cid, {x = 1079, y = 979, z = 7})
	player:teleportTo(fromPosition, true)
	return true
end
