
function onUse(cid, item, fromPosition, itemEx, toPosition)
	local player = Player(cid)
	if item.itemid == 2317 and fromPosition == Position(1026, 1051, 8) then
		local storageValue = player:getStorageValue(10001)
		if storageValue == 1 then
			local thing = player:addItem(1986)
			if thing then
				thing:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "This book contains very powerful formulas.")
				
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found Lucy's lost book.")
				player:setStorageValue(10001, 2)
			else
				-- TODO: Properly check this
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Item could not be created.")
			end
		elseif storageValue > 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The dead body is empty.")
		end
	end
	return true
end