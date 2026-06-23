-- Step 1: load AND execute the library (the () at the end is mandatory)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Step 2: create the main window
local Window = Rayfield:CreateWindow({
    Name = 'My Cheat Menu',
    LoadingTitle = 'Loading...',
    LoadingSubtitle = 'by you',
    Theme = 'Default',
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    KeySystem = false,
})

-- Step 3: create at least one Tab — the window will NOT show without this
local MainTab = Window:CreateTab('Main', 4483362458)

-- Step 4: add elements — every callback MUST contain real game logic, never empty
MainTab:CreateButton({ Name='Teleport to Spawn', Callback=function()
    local char = game.Players.LocalPlayer.Character
    if char then char:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(0,5,0) end
end })

MainTab:CreateButton({ Name='Fire Remote', Callback=function()
    local server = game:GetService('ServerStorage') -- replace with your server folder name
    if server then
        local remote = require(server:WaitForChild("YourRemoteName"))
        if remote and remote.ServerStuff then
            remote.ServerStuff(game.Players.LocalPlayer)
        end
    end
end })

MainTab:CreateButton({ Name='Toggle Noclip', Callback=function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass('Humanoid') then
        char:FindFirstChildOfClass('Humanoid').CollisionSize = Vector3.new(0, 0, 0)
    end
end })

MainTab:CreateSection('Info')
MainTab:CreateLabel('Script by GamerAI')

-- Notifications (can be called anytime after window is created)
Rayfield:Notify({ Title='Ready', Content='Script loaded!', Duration=5 })