local mysql = exports.mysql

local function isValidEmail(email)
	if type(email) ~= "string" then
		return false
	end

	email = email:gsub("^%s+", ""):gsub("%s+$", "")
	if #email < 5 or #email > 128 then
		return false
	end

	return email:match("^[A-Za-z0-9%.%%%+%-_]+@[A-Za-z0-9%.%-]+%.[A-Za-z][A-Za-z]+$") ~= nil
end

function saveEmail(_, email)
	local thePlayer = client or source
	if not thePlayer or not isElement(thePlayer) or getElementType(thePlayer) ~= "player" then
		return false
	end

	local accountId = tonumber(getElementData(thePlayer, "account:id"))
	local isLoggedIn = tonumber(getElementData(thePlayer, "loggedin")) == 1 or getElementData(thePlayer, "account:loggedin") == true
	if not accountId or not isLoggedIn then
		return false
	end

	if not isValidEmail(email) then
		return false
	end

	email = email:gsub("^%s+", ""):gsub("%s+$", "")
	return dbExec(exports.mysql:getConn("core"), "UPDATE `accounts` SET `email` = ? WHERE `id` = ?", email, accountId)
end
addEvent("requestEmail:saveEmail", true)
addEventHandler("requestEmail:saveEmail", getRootElement(), saveEmail)
