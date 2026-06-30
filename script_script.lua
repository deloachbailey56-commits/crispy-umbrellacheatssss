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

local MainTab = Window:CreateTab('Unknown Game', 0)

local fullEspOn = false
local fBoxes={} local fBars={} local fNames={} local fVel={}
local function removeFull(p)
  if fBoxes[p] then fBoxes[p]:Remove() fBoxes[p]=nil end
  if fBars[p] then fBars[p]:Remove() fBars[p]=nil end
  if fNames[p] then fNames[p]:Remove() fNames[p]=nil end
  if fVel[p] then fVel[p]:Remove() fVel[p]=nil end
end
Players.PlayerRemoving:Connect(removeFull)
RS.RenderStepped:Connect(function()
  for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character then
      local hrp = p.Character:FindFirstChild('HumanoidRootPart')
      local hum = p.Character:FindFirstChildOfClass('Humanoid')
      if hrp and hum then
        local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
        if not fBoxes[p] then
          local b=Drawing.new('Square') b.Visible=false b.Color=Color3.new(1,0,0) b.Thickness=1 b.Filled=false fBoxes[p]=b
          local bar=Drawing.new('Square') bar.Visible=false bar.Thickness=0 bar.Filled=true fBars[p]=bar
          local n=Drawing.new('Text') n.Visible=false n.Color=Color3.new(1,1,1) n.Size=13 n.Center=true n.Outline=true fNames[p]=n
          local v=Drawing.new('Text') v.Visible=false v.Color=Color3.new(0,1,1) v.Size=12 v.Center=true v.Outline=true fVel[p]=v
        end
        local show = fullEspOn and vis
        fBoxes[p].Visible=show fBars[p].Visible=show fNames[p].Visible=show fVel[p].Visible=show
        if show then
          local sz=2000/pos.Z
          local ratio=math.clamp(hum.Health/hum.MaxHealth,0,1)
          fBoxes[p].Size=Vector2.new(sz,sz*2)
          fBoxes[p].Position=Vector2.new(pos.X-sz/2,pos.Y-sz)
          fBars[p].Size=Vector2.new(4,sz*2*ratio)
          fBars[p].Position=Vector2.new(pos.X-sz/2-7,pos.Y-sz+(sz*2*(1-ratio)))
          fBars[p].Color=Color3.new(1-ratio,ratio,0)
          fNames[p].Text=p.Name..' ['..math.floor(hum.Health)..']'
          fNames[p].Position=Vector2.new(pos.X,pos.Y-sz-15)
          fVel[p].Text='vel:'..math.floor(hrp.Velocity.Magnitude)
          fVel[p].Position=Vector2.new(pos.X,pos.Y+sz+4)
        end
      end
    elseif fBoxes[p] then removeFull(p) end
  end
end)
MainTab:CreateToggle({Name='Full ESP',CurrentValue=false,Callback=function(v) fullEspOn=v end})

local CobaltTab = Window:CreateTab('Remote Spy', 4483362458)
CobaltTab:CreateButton({Name = 'Open Cobalt Spy', Callback = function() loadstring(game:HttpGet('https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau'))() end})
