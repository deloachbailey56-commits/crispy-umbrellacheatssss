getgenv().RAYFIELD_ASSET_ID = 110785486010149

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService('Players')
local RS      = game:GetService('RunService')
local UIS     = game:GetService('UserInputService')
local LP      = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name                   = "Unknown Game Cheats",
    Icon                   = 0,
    LoadingTitle           = "Loading",
    LoadingSubtitle        = "",
    Theme                  = "Default",
    ToggleUIKeybind        = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings   = false,
})

local MainTab = Window:CreateTab('Teleport Player', 0)

local function getPlayerNames()
  local t={} for _,p in pairs(Players:GetPlayers()) do if p~=LP then t[#t+1]=p.Name end end return t
end
local tpDD = MainTab:CreateDropdown({
  Name='Select Player',
  Options=getPlayerNames(),
  CurrentOption={},
  Callback=function() end
})
MainTab:CreateButton({
  Name='Teleport',
  Callback=function()
    local sel = tpDD.CurrentOption[1]
    local target = Players:FindFirstChild(sel)
    if target and target.Character then
      local hrp = LP.Character and LP.Character:FindFirstChild('HumanoidRootPart')
      local tHRP = target.Character:FindFirstChild('HumanoidRootPart')
      if hrp and tHRP then hrp.CFrame = tHRP.CFrame * CFrame.new(0,0,-3) end
    end
  end
})
MainTab:CreateButton({
  Name='Refresh Players',
  Callback=function() tpDD:Refresh(getPlayerNames()) end
})

-- Cobalt Remote Spy (always last)
local CobaltTab = Window:CreateTab('Remote Spy', 4483362458)
CobaltTab:CreateButton({Name = 'Open Cobalt Spy', Callback = function() loadstring(game:HttpGet('https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau'))() end})