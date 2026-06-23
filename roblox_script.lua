-- Framework: Rayfield --
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create the main window --
local Window = Rayfield:CreateWindow({
    Name = "Teleport Script",
    LoadingTitle = "Loading...",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
})

-- Create the first tab --
local MainTab = Window:CreateTab("Main", 4483362458)

-- Add a button to teleport --
local TeleportButton = MainTab:CreateButton({
    Name = "Teleport",
    Callback = function()
        local char = game.Players.LocalPlayer.Character

        if char and char:FindFirstChildOfClass("Humanoid") then
            print("Current position: ", game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
        end
    end,
})

-- Add an input to enter coordinates --
MainTab:CreateInput({
    Name = "Teleport To",
    PlaceholderText = "Enter coordinates (XYZ)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local x, y, z = tonumber(string.match(text, "%d+"))

        if char and char:FindFirstChildOfClass("Humanoid") then
            char.HumanoidRootPart.CFrame = CFrame.new(x or 0, y or 0, z or 0)
        end
    end,
})

-- Notify that the script is ready --
Rayfield:Notify({Title = "Ready", Content = "Script loaded!", Duration = 5})