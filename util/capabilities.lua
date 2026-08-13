--[[
Capabilities.lua
Utility

Designed to check for functions
Note to me: Use volt's documentation for functions OR the sUnc official website.
]]

if game.RunService:IsStudio() then
	warn("This script may not work as expected.")
end

type Callback = (result : boolean) -> ()

local requiredchecks = {
	["print"] = false, -- just a tes
	["hookfunction"] = false, -- The value will only be true if the function is supported.
	["hookmetamethod"] = false,
	["getconnections"] = false,
	
	-- files
	["readfile"] = false,
	["writefile"] = false,
	["setclipboard"] = false
}
local function defaultcallback(res, functname)
	if res == false then
		warn(`[Capabilities] {functname} is not supported.`)
	end
	
	-- Make sure the index is not nil or false. If it's value is false, it will not work.
	if requiredchecks[functname] ~= nil then
		requiredchecks[functname] = res
		print(`[Capabilities] {functname}: {tostring(res)}`)
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
check("function", {readfile, "readfile"})
check("function", {writefile, "writefile"})
check("function", {setclipboard, "setclipboard"})

local function booltotext(val : boolean)
	if val == true then
		return "✅"
	else
		return "❌"
	end
end

local txt = ""
for i, v in pairs(requiredchecks) do
	txt = txt.. `{tostring(i)}: {booltotext(v)} \n`
end

return requiredchecks, txt -- Return the results
