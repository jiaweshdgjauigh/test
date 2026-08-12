local keys = {
	"8J2X1A2-Hunter"
}

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
	Title = "HunterGui",
	Icon = "door-open", -- lucide icon
	Author = "By XxHunterStormBytexX4",
	Folder = "huntui",
	
	MinSize = Vector2.new(560, 350),
	ToggleKey = Enum.KeyCode.LeftShift,
	Transparent = true,
	Theme = "Dark",
	Resizable = true,
	SideBarWidth = 200,
	BackgroundImageTransparency = 0.42,
	HideSearchBar = true,
	ScrollBarEnabled = true,
	
	User = {
		Enabled = true,
		Anonymous = false,
		Callback = function()
		end,
	},

	KeySystem = { 

		Key = keys,

		Note = "Join the Discord server for the key.",

		URL = "https://discord.gg/NMxQTJKXja",

		SaveKey = true,
	},
})

local Tab = Window:Tab({
	Title = "Home",
	Icon = "bird", -- optional
	Locked = false,
})
local CAPABILITIES = {}
local c_success, c_err = pcall(function()
	CAPABILITIES = loadstring(game:HttpGet("https://raw.githubusercontent.com/jiaweshdgjauigh/test/refs/heads/main/util/capabilities.lua"))()
end)

if not c_success then
	warn(`[ERROR] {c_err}`)
end
local function booltotext(val : boolean)
	if val == true then
		return "✅"
	else
		return "❌"
	end
end

local capabilities_txt = `hookmetamethod: {booltotext(CAPABILITIES["hookmetamethod"])} \n hookfunction: {booltotext(CAPABILITIES["hookfunction"])} \n getconnections: {booltotext(CAPABILITIES["getconnections"])}`

local Paragraph = Tab:Paragraph({
	Title = "Supported executor functions",
	Desc = capabilities_txt,
	Color = "Grey",
	Image = "",
	ImageSize = 30,
	Thumbnail = "",
	ThumbnailSize = 80,
	Locked = false,
	Buttons = {
	}
})
