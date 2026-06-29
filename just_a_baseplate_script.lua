getgenv().RAYFIELD_ASSET_ID = 110785486010149

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService('Players')
local RS      = game:GetService('RunService')
local UIS     = game:GetService('UserInputService')
local LP      = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name                   = "just a baseplate Cheats",
    Icon                   = 0,
    LoadingTitle           = "Loading",
    LoadingSubtitle        = "",
    Theme                  = "Default",
    ToggleUIKeybind        = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings   = false,
})

local MainTab = Window:CreateTab('Tab Label', 0)

-- firetouchinterest(part, transmitter, toggle) — toggle 1=touching, 0=stopped
-- Use this whenever a part needs to be 'stepped on' to trigger something
local function touchPart(partName)
  local part = workspace:FindFirstChild(partName)
  if not part then
    -- search recursively if not a direct child of workspace
    part = workspace:FindFirstChildWhichIsA('BasePart', true)
    for _, v in pairs(workspace:GetDescendants()) do
      if v.Name == partName and v:IsA('BasePart') then part = v break end
    end
  end
  local hrp = LP.Character and LP.Character:FindFirstChild('HumanoidRootPart')
  if part and hrp then
    firetouchinterest(part, hrp, 1)  -- simulate stepping on
    task.wait(0.1)
    firetouchinterest(part, hrp, 0)  -- simulate stepping off
    Rayfield:Notify({Title='Touched', Content='Fired '..partName, Duration=2})
  else
    Rayfield:Notify({Title='Error', Content=partName..' not found', Duration=3})
  end
end
-- Example usage in a button:
-- MainTab:CreateButton({Name='Touch Teleport1', Callback=function() touchPart('touch_part') end})

-- Cobalt Remote Spy (always last)
local CobaltTab = Window:CreateTab('Remote Spy', 4483362458)
local cobalt = loadstring(game:HttpGet('https://raw.githubusercontent.com/notpoiu/cobalt/main/cobalt.lua'))()
CobaltTab:CreateButton({Name = 'Open Cobalt Spy', Callback = function() cobalt:Start() end})