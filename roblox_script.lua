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

-- Slider for speed control
MainTab:CreateSlider({ Name='WalkSpeed', Range={0,500}, Increment=1, CurrentValue=16, Flag='SpeedFlag',
    Callback=function(Value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChildOfClass('Humanoid') then
            char:FindFirstChildOfClass('Humanoid').WalkSpeed = Value
        end
    end
})

-- Toggle for speed control mode (walking/standing still)
local SpeedMode = false
MainTab:CreateToggle({ Name='Speed Mode', CurrentValue=false, Flag='SpeedModeFlag',
    Callback=function(Value)
        SpeedMode = Value
    end
})

-- Button to change speed while walking or standing still
MainTab:CreateButton({ Name='Change Speed', Callback=function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass('Humanoid') then
        local speedValue = MainTab:GetFlaggedValue('SpeedFlag') or 16
        local modeValue = MainTab:GetFlaggedValue('SpeedModeFlag') or false
        local walkSpeed = speedValue
        if modeValue == true and char:FindFirstChildOfClass('Humanoid').Walking then
            -- Change the speed while walking
            walkSpeed = 0
        end
        if modeValue == false and not char:FindFirstChildOfClass('Humanoid').Walking then
            -- Change the speed while standing still
            walkSpeed = 16
        end
        char:FindFirstChildOfClass('Humanoid').WalkSpeed = walkSpeed
    end
})

MainTab:CreateSection('Info')
MainTab:CreateLabel('Script by GamerAI')

-- Notifications (can be called anytime after window is created)
Rayfield:Notify({ Title='Ready', Content='Script loaded!', Duration=5 })