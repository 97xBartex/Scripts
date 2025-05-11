local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local targetColor = Color3.fromRGB(62, 56, 86)
local player = Players.LocalPlayer

-- Create a GUI popup
local function showPopup()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MoonlitPopup"
	screenGui.Parent = player:WaitForChild("PlayerGui")
	screenGui.ResetOnSpawn = false

	local popup = Instance.new("TextLabel")
	popup.Size = UDim2.new(0, 300, 0, 50)
	popup.Position = UDim2.new(0.5, -150, 0.1, 0)
	popup.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	popup.TextColor3 = Color3.new(1, 1, 1)
	popup.Font = Enum.Font.GothamBold
	popup.TextSize = 22
	popup.Text = "🌙 Moonlit Detected!"
	popup.BackgroundTransparency = 0.2
	popup.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = popup

	-- Auto remove after 0.5s
	task.delay(0.5, function()
		screenGui:Destroy()
	end)
end

-- Highlight function
local function highlightPart(part)
	local highlight = Instance.new("Highlight")
	highlight.Name = "AutoHighlight"
	highlight.Adornee = part
	highlight.FillColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineColor = Color3.fromRGB(255, 100, 100)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = part
end

-- One-time scan for matching parts
local found = false

for _, part in ipairs(Workspace:GetDescendants()) do
	if part:IsA("BasePart") and part.Color == targetColor then
		if not part:FindFirstChild("AutoHighlight") then
			highlightPart(part)
			found = true
		end
	end
end

if found then
	showPopup()
	print("🌙 Moonlit parts found and highlighted.")
else
	print("No moonlit parts found.")
end
