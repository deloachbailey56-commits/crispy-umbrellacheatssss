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

local MainTab = Window:CreateTab('Player Stats', 0)

local statsEnabled = false
local statsDrawings = {}
local function removeStats(p)
  if statsDrawings[p] then
    for _, d in pairs(statsDrawings[p]) do d:Remove() end
    statsDrawings[p] = nil
  end
end
Players.PlayerRemoving:Connect(removeStats)
task.spawn(function()
  while true do
    task.wait(0.5)
    if not statsEnabled then
      for p in pairs(statsDrawings) do removeStats(p) end
    else
      for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
          local hrp = p.Character:FindFirstChild('HumanoidRootPart')
          local hum = p.Character:FindFirstChildOfClass('Humanoid')
          if hrp and hum then
            local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
            if not statsDrawings[p] then
              local t = Drawing.new('Text') t.Size=13 t.Color=Color3.new(0,1,1) t.Outline=true t.Center=true t.Visible=false
              statsDrawings[p] = {t}
            end
            local vel = math.floor(hrp.Velocity.Magnitude)
            local hp = math.floor(hum.Health)
            local maxhp = math.floor(hum.MaxHealth)
            statsDrawings[p][1].Visible = vis
            if vis then
              statsDrawings[p][1].Position = Vector2.new(pos.X, pos.Y - 60)
              statsDrawings[p][1].Text = p.Name .. '  HP:'..hp..'/'..maxhp..'  Vel:'..vel
            end
          end
        elseif statsDrawings[p] then
          removeStats(p)
        end
      end
    end
  end
end)
MainTab:CreateToggle({Name='Player Stats (Health+Vel)',CurrentValue=false,Callback=function(v) statsEnabled=v end})

-- Cobalt Remote Spy (always last)
local CobaltTab = Window:CreateTab('Remote Spy', 4483362458)
CobaltTab:CreateButton({Name = 'Open Cobalt Spy', Callback = function() loadstring(game:HttpGet('https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau'))() end})