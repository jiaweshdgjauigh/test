_G.Key = ""

print("v.2")

--// SERVICES //--
local HTTPservice = game:GetService("HttpService")

--// IMPORTS //--

local base_url = "https://raw.githubusercontent.com/jiaweshdgjauigh/test/refs/heads/main/"

local function ImportScript(path)
	local url = base_url .. path
	print("Importing:", url)

	local success, source = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		error("FAILED TO FETCH " .. path .. ": " .. tostring(source))
	end

	if not source or source == "" then
		error("NO SOURCE: " .. path)
	end

	local fn, err = loadstring(source)

	if not fn then
		error("FAILED TO COMPILE " .. path .. ": " .. tostring(err))
	end

	return fn()
end

local Modules = {
	Capabilities = ImportScript("util/capabilities.luau"),
	Verification = ImportScript("util/verification.luau"),
	AssetLoader = ImportScript("util/assetsloader.luau")
}

local function ImportImage(path)
    local result = Modules.AssetLoader.fetchImage(path)
    if result then
        return result
    end
end

--// FILES //--

local function ensurefolder(path)
	if not isfolder(path) then
		makefolder(path)
	end
end
local function ensurefile(path)
	if not isfile(path) then
		if isfolder(path) then
			delfolder(path)
			warn(`[FILES] {path} was a folder and has been deleted.`)
		end

		writefile(path, "")
	end
end

ensurefolder("huntergui")
ensurefolder("huntergui/assets")
ensurefile("huntergui/key.json")

local function safeRead(path)
	local success, result = pcall(readfile, path)
	if success then
		return result
	else
		warn("Failed to read:", result, " - Overwriting path")
		writefile(path)
		return nil
	end
end

--// VERIFICATION //--

local function saveKey(k)
    writefile("huntergui/key.json", HTTPservice:JSONEncode({key = k}))
end

local function getKey()
    local key = safeRead("huntergui/key.json")
    if key then
		local success, err = pcall(function()
        	key = HTTPservice:JSONDecode(key)
		end)
		if not key and err then
			return ""
		end
        if key then
            return key.key
        end
    end
end

--//--------------//--

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local Discord = Instance.new("ImageButton")
local UICorner_3 = Instance.new("UICorner")
local Body = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local Close = Instance.new("TextButton")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 13, 36)
Frame.BackgroundTransparency = 0.400
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(1, 0, 1, 0)

Frame_2.Parent = Frame
Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(17, 18, 48)
Frame_2.BackgroundTransparency = 0.500
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame_2.Size = UDim2.new(0, 461, 0, 297)

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Frame_2

Title.Name = "Title"
Title.Parent = Frame_2
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.0216919743, 0, 0.0404040404, 0)
Title.Size = UDim2.new(0, 218, 0, 44)
Title.Font = Enum.Font.Arial
Title.Text = "Key System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true
Title.TextXAlignment = Enum.TextXAlignment.Left

TextBox.Parent = Frame_2
TextBox.BackgroundColor3 = Color3.fromRGB(28, 32, 77)
TextBox.BackgroundTransparency = 0.150
TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.169197395, 0, 0.740740716, 0)
TextBox.Size = UDim2.new(0, 304, 0, 33)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(156, 175, 185)
TextBox.PlaceholderText = "Key here"
TextBox.Text = getKey() or ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = TextBox

Discord.Name = "Discord"
Discord.Parent = Frame_2
Discord.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Discord.BackgroundTransparency = 1.000
Discord.BorderColor3 = Color3.fromRGB(0, 0, 0)
Discord.BorderSizePixel = 0
Discord.Position = UDim2.new(0.878524959, 0, 0.0404040404, 0)
Discord.Size = UDim2.new(0, 40, 0, 40)
Discord.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

UICorner_3.CornerRadius = UDim.new(1, 0)
UICorner_3.Parent = Discord

Body.Name = "Body"
Body.Parent = Frame_2
Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Body.BackgroundTransparency = 1.000
Body.BorderColor3 = Color3.fromRGB(0, 0, 0)
Body.BorderSizePixel = 0
Body.Position = UDim2.new(0.0216919743, 0, 0.188552186, 0)
Body.Size = UDim2.new(0, 218, 0, 44)
Body.Font = Enum.Font.Unknown
Body.Text = "Join the Discord server to get a key. Do not share your keys, you can only generate one a day."
Body.TextColor3 = Color3.fromRGB(206, 208, 208)
Body.TextScaled = true
Body.TextSize = 14.000
Body.TextWrapped = true
Body.TextXAlignment = Enum.TextXAlignment.Left

TextButton.Parent = Frame_2
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.364425153, 0, 0.878787875, 0)
TextButton.Size = UDim2.new(0, 124, 0, 22)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Submit"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 21.000
TextButton.TextWrapped = true

Close.Name = "Close"
Close.Parent = Frame
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundTransparency = 1.000
Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.742316782, 0, 0.911680937, 0)
Close.Size = UDim2.new(0, 200, 0, 50)
Close.Font = Enum.Font.SourceSans
Close.Text = "nvm i dont wanna load this script"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 21.000
Close.TextWrapped = true

Close.MouseButton1Click:Connect(function()
	Frame:Destroy()
end)

TextButton.MouseButton1Click:Connect(function()
	local result = Modules.Verification.Verify(
		TextBox.Text, gethwid()
	)
	print(result)
	if not result then
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Invalid Key",
			Text = "This key doesnt exist or has been claimed.",
			Duration = 5
		})
	else
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Valid Key",
			Text = "Redeemed key",
			Duration = 5
		})
        saveKey(TextBox.Text)
		getgenv().Key = TextBox.Text
	end
end)

local button_cb = Instance.new("BindableFunction")
button_cb.OnInvoke = function()
	setclipboard("https://discord.gg/NMxQTJKXja")
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Copied Link",
		Text = "Paste the link in a browser to join.",
		Duration = 3
	})
end
Discord.Image = ImportImage(base_url.. "assets/discord.png", "discord.png")
Discord.MouseButton1Click:Connect(function()
	local success, response = pcall(function()
		return request({
			Url = "http://127.0.0.1:6463/rpc?v=1",
			Method = "POST",

			Headers = {
				["Content-Type"] = "application/json",
				["Origin"] = "https://discord.com"
			},

			Body = HTTPservice:JSONEncode({
				cmd = "INVITE_BROWSER",
				nonce = HTTPservice:GenerateGUID(false),

				args = {
					code = "NMxQTJKXja"
				}
			})
		})
	end)

	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Didn't get the invite?",
		Text = "Click the link for the discord invite to join",
		Duration = 5,
		Callback = button_cb,
		Button1 = "Get Link"
	})
end)
