mysql = exports.mysql

function awardPlayer(thePlayer, title, desc, gc)
	if not thePlayer or not isElement(thePlayer) or getElementType(thePlayer) ~= "player" then
		return false
	end

	gc = tonumber(gc)
	if not gc or gc <= 0 then
		return false
	end
	gc = math.floor(gc)

	local accountId = tonumber(getElementData(thePlayer, "account:id"))
	if not accountId then
		return false
	end

	if dbExec(exports.mysql:getConn("core"), "UPDATE `accounts` SET `credits`=credits+? WHERE `id`=?", gc, accountId) then
		local currentCredits = tonumber(getElementData(thePlayer, "credits")) or 0
		setElementData(thePlayer, "credits", currentCredits + gc)
		triggerClientEvent(thePlayer, "displayAchievement", thePlayer, title, desc, gc)
		exports.donators:addPurchaseHistory(thePlayer, title or "ACHIEVEMENT UNLOCKED! "..(desc and ("("..desc..")") or ("")), gc)
		return true
	end

	outputChatBox("You were supposed to be rewarded with "..gc.."GCs.", thePlayer, 255, 0, 0)
	outputChatBox("But unfortunately, a MySQL error occurred and adding GC uncompleted.", thePlayer, 255, 0, 0)
	return false
end
addEvent("awardPlayer", false)
addEventHandler("awardPlayer", root, awardPlayer)

function playSoundFx(thePlayer)
	triggerClientEvent(thePlayer, "playSoundFx", thePlayer)
end
