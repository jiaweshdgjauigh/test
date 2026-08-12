--[[
Capabilities.lua
Utility

Designed to check for functions
]]

if game.RunService:IsStudio() then
	warn("This script may not work as expected.")
end

type Callback = (result : boolean) -> ()

local res = {}
local requiredchecks = {
	["print"] = false, -- just a tes
	["hookfunction"] = false, -- The value will only be true if the function is supported.
	["hookmetamethod"] = false,
	["getconnections"] = false
}
local function defaultcallback(res, functname)
	if res == false then
		warn(`[Capabilities] {functname} is not supported.`)
		return
	end
	
	-- Make sure the index is not nil or false. If it's value is false, it will not work.
	if requiredchecks[functname] ~= nil then
		requiredchecks[functname] = res
		print(`[Capabilities] {functname} is supported`)
	else
		warn(`[Capabilities] Failed to find or set: {functname}`)
	end
end
--[[`fn` is the function to check]]
local function check(expectedtype : string, fn : {Function : any, name : string}, callback : Callback)
	if not callback then
		callback = defaultcallback
	end
	
	if type(fn[1]) == expectedtype then
		local s, err = xpcall(
			function()
				callback(true, fn[2])
			end,
			function(err)
				return "[Capabilities] There has been an issue while checking: ".. err
			end
		)
		if not s and err then
			warn(err)
		end
	else
		local s, err = xpcall(
			function()
				callback(false, fn[2])
			end,
			function(err)
				return "[Capabilities] There has been an issue while checking: ".. err
			end
		)
		if not s and err then
			warn(err)
		end
	end
end

check("function", {hookfunction, "hookfunction"})
check("function", {hookmetamethod, "hookmetamethod"})
check("function", {getconnections, "getconnections"})
check("function", {print, "print"})

return res -- Return the results
