-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- GUI Container
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "StylishSpamGUI"
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0, 360)
MainFrame.Position = UDim2.new(0, 30, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title Label
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -60, 0, 28)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "Money Farm | MadeByXZuyaX"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -28, 0, 6)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(1, 0)

CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

-- Minimize Button
local MinimizeButton = Instance.new("TextButton", MainFrame)
MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
MinimizeButton.Position = UDim2.new(1, -56, 0, 6)
MinimizeButton.Text = "-"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(1, 0)

-- Scroll Frame
local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(1, -20, 0, 220)
ScrollFrame.Position = UDim2.new(0, 10, 0, 40)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0

local UIListLayout = Instance.new("UIListLayout", ScrollFrame)
UIListLayout.Padding = UDim.new(0, 4)

-- Buttons
local RefreshButton = Instance.new("TextButton", MainFrame)
RefreshButton.Size = UDim2.new(0, 110, 0, 35)
RefreshButton.Position = UDim2.new(0, 10, 1, -50)
RefreshButton.Text = "Refresh"
RefreshButton.BackgroundColor3 = Color3.fromRGB(0, 125, 255)
RefreshButton.TextColor3 = Color3.new(1, 1, 1)
RefreshButton.Font = Enum.Font.GothamBold
RefreshButton.TextSize = 16
Instance.new("UICorner", RefreshButton).CornerRadius = UDim.new(0, 6)

local ToggleButton = Instance.new("TextButton", MainFrame)
ToggleButton.Size = UDim2.new(0, 130, 0, 35)
ToggleButton.Position = UDim2.new(1, -140, 1, -50)
ToggleButton.Text = "SPAM: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 16
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 6)

-- Logic (pindah ke atas, sebelum semua tombol)
local selectedPlayers = {}
local isSpamming = false
local minimized = false

-- Select All Button
local SelectAllButton = Instance.new("TextButton", MainFrame)
SelectAllButton.Size = UDim2.new(0, 120, 0, 30)
SelectAllButton.Position = UDim2.new(0.5, -60, 1, -95)
SelectAllButton.Text = "Select All"
SelectAllButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
SelectAllButton.TextColor3 = Color3.new(1, 1, 1)
SelectAllButton.Font = Enum.Font.GothamBold
SelectAllButton.TextSize = 14
Instance.new("UICorner", SelectAllButton).CornerRadius = UDim.new(0, 6)

SelectAllButton.MouseButton1Click:Connect(function()
	for _, child in ipairs(ScrollFrame:GetChildren()) do
		if child:IsA("TextButton") and child.Name ~= "UIListLayout" then
			local playerName = child.Text
			if not selectedPlayers[playerName] then
				selectedPlayers[playerName] = true
				child.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
			end
		end
	end
end)

local function updatePlayerList()
	for _, child in ipairs(ScrollFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	selectedPlayers = {}

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local btn = Instance.new("TextButton", ScrollFrame)
			btn.Size = UDim2.new(1, -4, 0, 32)
			btn.Text = player.Name
			btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.Font = Enum.Font.Gotham
			btn.TextSize = 14
			Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

			btn.MouseButton1Click:Connect(function()
				if selectedPlayers[player.Name] then
					selectedPlayers[player.Name] = nil
					btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
				else
					selectedPlayers[player.Name] = true
					btn.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
				end
			end)
		end
	end

	ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

RefreshButton.MouseButton1Click:Connect(updatePlayerList)

ToggleButton.MouseButton1Click:Connect(function()
	isSpamming = not isSpamming
	ToggleButton.Text = isSpamming and "SPAM: ON" or "SPAM: OFF"
	ToggleButton.BackgroundColor3 = isSpamming and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)

	if isSpamming then
		spawn(function()
			while isSpamming do
				for name, _ in pairs(selectedPlayers) do
					local target = Players:FindFirstChild(name)
					if target and target.Character then
						local args = {
							[1] = "OneTwo",
							[2] = target.Character
						}
						ReplicatedStorage.Packages.Knit.Services.AbilityService.RE.Ability:FireServer(unpack(args))
					end
				end
				task.wait()
			end
		end)
	end
end)

-- Minimize/maximize toggle
MinimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized
	ScrollFrame.Visible = not minimized
	RefreshButton.Visible = not minimized
	ToggleButton.Visible = not minimized
	SelectAllButton.Visible = not minimized

	MinimizeButton.Text = minimized and "+" or "-"
	MainFrame.Size = minimized and UDim2.new(0, 280, 0, 40) or UDim2.new(0, 280, 0, 370)
end)

-- Load
updatePlayerList()
