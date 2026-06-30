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

local currentSpeed = 16
MainTab:CreateSlider({
  Name='Walk Speed',
  Range={0,500},
  Increment=1,
  Suffix='',
  CurrentValue=16,
  Callback=function(Value)
    local char = LP.Character
    if char and char:FindFirstChild('Humanoid') then
      char.Humanoid.WalkSpeed = Value
    end
  end
})
LP.CharacterAdded:Connect(function(char)
  char:WaitForChild('Humanoid').WalkSpeed = currentSpeed
end)

MainTab:CreateSlider({
  Name = 'WalkSpeed',
  Range = {0, 300},
  Increment = 1,
  Suffix = ' speed',
  CurrentValue = 16,
  Callback = function(v)
    local char = LP.Character
    if char then
      local hum = char:FindFirstChildOfClass('Humanoid')
      if hum then hum.WalkSpeed = v end
    end
  end
})
LP.CharacterAdded:Connect(function(char)
  local hum = char:WaitForChild('Humanoid')
  hum.WalkSpeed = 16
end)

MainTab:CreateSlider({
  Name='Jump Power',
  Range={0,500},
  Increment=1,
  CurrentValue=50,
  Callback=function(Value)
    local char = LP.Character
    if char and char:FindFirstChild('Humanoid') then
      char.Humanoid.JumpPower = Value
    end
  end
})

MainTab:CreateSlider({
  Name = 'JumpPower',
  Range = {0, 300},
  Increment = 1,
  Suffix = ' power',
  CurrentValue = 50,
  Callback = function(v)
    local char = LP.Character
    if char then
      local hum = char:FindFirstChildOfClass('Humanoid')
      if hum then hum.JumpPower = v end
    end
  end
})

local jumpConn
MainTab:CreateToggle({
  Name='Infinite Jump',
  CurrentValue=false,
  Callback=function(Value)
    if Value then
      jumpConn = UIS.JumpRequest:Connect(function()
        if LP.Character then
          LP.Character:FindFirstChildOfClass('Humanoid').Jump = true
        end
      end)
    elseif jumpConn then
      jumpConn:Disconnect()
      jumpConn = nil
    end
  end
})

local noclipOn = false
RS.Stepped:Connect(function()
  if noclipOn and LP.Character then
    for _,p in pairs(LP.Character:GetDescendants()) do
      if p:IsA('BasePart') then p.CanCollide=false end
    end
  end
end)
MainTab:CreateToggle({
  Name='Noclip',
  CurrentValue=false,
  Callback=function(Value) noclipOn=Value end
})

local flyOn = false
local flyBody = nil
local flyConn = nil
local function startFly()
  local char = LP.Character if not char then return end
  local hrp = char:FindFirstChild('HumanoidRootPart')
  local hum = char:FindFirstChildOfClass('Humanoid')
  if not hrp or not hum then return end
  hum.PlatformStand = true
  flyBody = Instance.new('BodyVelocity')
  flyBody.Velocity = Vector3.zero
  flyBody.MaxForce = Vector3.new(1e5, 1e5, 1e5)
  flyBody.Parent = hrp
  flyConn = RS.RenderStepped:Connect(function()
    if not flyOn or not flyBody then return end
    local cam = workspace.CurrentCamera
    local dir = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0) end
    flyBody.Velocity = dir * 60
  end)
end
local function stopFly()
  flyOn = false
  if flyConn then flyConn:Disconnect() flyConn = nil end
  if flyBody then flyBody:Destroy() flyBody = nil end
  local char = LP.Character
  if char then
    local hum = char:FindFirstChildOfClass('Humanoid')
    if hum then hum.PlatformStand = false end
  end
end
LP.CharacterAdded:Connect(function() if flyOn then task.wait(1) startFly() end end)
MainTab:CreateToggle({
  Name = 'Fly',
  CurrentValue = false,
  Callback = function(v)
    flyOn = v
    if v then startFly() else stopFly() end
  end
})

local godOn = false
local godConn
MainTab:CreateToggle({
  Name='God Mode',
  CurrentValue=false,
  Callback=function(v)
    godOn=v
    local hum = LP.Character and LP.Character:FindFirstChildOfClass('Humanoid')
    if hum then
      if v then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
      else
        hum.MaxHealth = 100
        hum.Health = 100
      end
    end
  end
})
LP.CharacterAdded:Connect(function(char)
  if godOn then
    char:WaitForChild('Humanoid').MaxHealth = math.huge
    char:WaitForChild('Humanoid').Health = math.huge
  end
end)

local function applyNoFall(char)
  local hum = char:WaitForChild('Humanoid')
  hum:GetPropertyChangedSignal('Health'):Connect(function()
    -- absorb fall by refreshing
  end)
  hum.StateChanged:Connect(function(_, new)
    if new == Enum.HumanoidStateType.Landed then
      hum.Health = hum.Health
    end
  end)
end
LP.CharacterAdded:Connect(applyNoFall)
if LP.Character then applyNoFall(LP.Character) end
MainTab:CreateLabel('No Fall Damage Active')

task.spawn(function()
  while true do
    task.wait(0.1)
    local char = LP.Character
    if char then
      local stamina = char:FindFirstChild('Stamina') or char:FindFirstChild('Energy') or char:FindFirstChild('Endurance')
      if stamina and stamina:IsA('NumberValue') then stamina.Value = stamina.Value < 10 and 100 or stamina.Value end
    end
  end
end)
MainTab:CreateLabel('Infinite Stamina Active')

local VIM = game:GetService('VirtualInputManager')
task.spawn(function()
  while true do
    task.wait(60)
    VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait(0.1)
    VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
  end
end)
MainTab:CreateLabel('Anti-AFK Active')

workspace.CurrentCamera.FieldOfView = 70
MainTab:CreateSlider({
  Name = 'Field of View',
  Range = {30, 120},
  Increment = 1,
  Suffix = ' FOV',
  CurrentValue = 70,
  Callback = function(v) workspace.CurrentCamera.FieldOfView = v end
})

local Lighting = game:GetService('Lighting')
MainTab:CreateSlider({
  Name = 'Time of Day',
  Range = {0, 24},
  Increment = 1,
  Suffix = ':00',
  CurrentValue = 12,
  Callback = function(v) Lighting.ClockTime = v end
})
MainTab:CreateToggle({Name='Fullbright',CurrentValue=false,Callback=function(v)
  Lighting.Brightness = v and 2 or 1
  Lighting.GlobalShadows = not v
  Lighting.Ambient = v and Color3.new(1,1,1) or Color3.new(0,0,0)
  Lighting.OutdoorAmbient = v and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)
end})

local espEnabled = false
local espBoxes = {}
local espNames = {}
local function removeEsp(p)
  if espBoxes[p] then espBoxes[p]:Remove() espBoxes[p]=nil end
  if espNames[p] then espNames[p]:Remove() espNames[p]=nil end
end
Players.PlayerRemoving:Connect(removeEsp)
RS.RenderStepped:Connect(function()
  for _,p in pairs(Players:GetPlayers()) do
    if p~=LP and p.Character then
      local hrp = p.Character:FindFirstChild('HumanoidRootPart')
      if hrp then
        local pos,vis = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
        if not espBoxes[p] then
          local b=Drawing.new('Square') b.Visible=false b.Color=Color3.new(1,0,0) b.Thickness=1 b.Filled=false espBoxes[p]=b
          local n=Drawing.new('Text') n.Visible=false n.Color=Color3.new(1,1,1) n.Size=14 n.Center=true n.Outline=true espNames[p]=n
        end
        espBoxes[p].Visible=espEnabled and vis
        espNames[p].Visible=espEnabled and vis
        if vis and espEnabled then
          local sz=2000/pos.Z
          espBoxes[p].Size=Vector2.new(sz,sz*2)
          espBoxes[p].Position=Vector2.new(pos.X-sz/2,pos.Y-sz)
          espNames[p].Text=p.Name
          espNames[p].Position=Vector2.new(pos.X,pos.Y-sz-16)
        end
      end
    elseif espBoxes[p] then
      removeEsp(p)
    end
  end
end)
MainTab:CreateToggle({Name='Player ESP',CurrentValue=false,Callback=function(v) espEnabled=v end})

local hpEspOn = false
local hpBoxes = {} local hpBars = {} local hpNames = {}
local function removeHpEsp(p)
  if hpBoxes[p] then hpBoxes[p]:Remove() hpBoxes[p]=nil end
  if hpBars[p] then hpBars[p]:Remove() hpBars[p]=nil end
  if hpNames[p] then hpNames[p]:Remove() hpNames[p]=nil end
end
Players.PlayerRemoving:Connect(removeHpEsp)
RS.RenderStepped:Connect(function()
  for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character then
      local hrp = p.Character:FindFirstChild('HumanoidRootPart')
      local hum = p.Character:FindFirstChildOfClass('Humanoid')
      if hrp and hum then
        local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
        if not hpBoxes[p] then
          local b=Drawing.new('Square') b.Visible=false b.Color=Color3.new(1,0,0) b.Thickness=1 b.Filled=false hpBoxes[p]=b
          local bar=Drawing.new('Square') bar.Visible=false bar.Color=Color3.new(0,1,0) bar.Thickness=0 bar.Filled=true hpBars[p]=bar
          local n=Drawing.new('Text') n.Visible=false n.Color=Color3.new(1,1,1) n.Size=13 n.Center=true n.Outline=true hpNames[p]=n
        end
        local show = hpEspOn and vis
        hpBoxes[p].Visible=show hpBars[p].Visible=show hpNames[p].Visible=show
        if show then
          local sz=2000/pos.Z
          local ratio=math.clamp(hum.Health/hum.MaxHealth,0,1)
          hpBoxes[p].Size=Vector2.new(sz,sz*2) hpBoxes[p].Position=Vector2.new(pos.X-sz/2,pos.Y-sz)
          hpBars[p].Size=Vector2.new(4,sz*2*ratio) hpBars[p].Position=Vector2.new(pos.X-sz/2-6,pos.Y-sz+(sz*2*(1-ratio)))
          hpBars[p].Color=Color3.new(1-ratio,ratio,0)
          hpNames[p].Text=p.Name..' ['..math.floor(hum.Health)..']'
          hpNames[p].Position=Vector2.new(pos.X,pos.Y-sz-15)
        end
      end
    elseif hpBoxes[p] then removeHpEsp(p) end
  end
end)
MainTab:CreateToggle({Name='Health Bar ESP',CurrentValue=false,Callback=function(v) hpEspOn=v end})

local partEspEnabled = false
local partEspBoxes = {}
local partEspLabels = {}
local function clearPartEsp()
  for _, b in pairs(partEspBoxes) do b:Remove() end
  for _, l in pairs(partEspLabels) do l:Remove() end
  partEspBoxes = {}
  partEspLabels = {}
end
local partEspTargets = {}
local function refreshPartEspTargets(filterName)
  partEspTargets = {}
  for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA('BasePart') and not v:IsDescendantOf(LP.Character or game:GetService('Players')) then
      if not filterName or filterName == '' or v.Name:lower():find(filterName:lower()) then
        table.insert(partEspTargets, v)
      end
    end
  end
end
refreshPartEspTargets(nil)
RS.RenderStepped:Connect(function()
  if not partEspEnabled then return end
  -- grow/shrink boxes table to match targets
  for i = #partEspBoxes + 1, #partEspTargets do
    local b = Drawing.new('Square') b.Visible=false b.Color=Color3.new(1,1,0) b.Thickness=1 b.Filled=false partEspBoxes[i]=b
    local l = Drawing.new('Text') l.Visible=false l.Color=Color3.new(1,1,0) l.Size=13 l.Center=true l.Outline=true partEspLabels[i]=l
  end
  for i, part in ipairs(partEspTargets) do
    if part and part.Parent then
      local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
      partEspBoxes[i].Visible = vis
      partEspLabels[i].Visible = vis
      if vis then
        local sz = math.max(20, 1500 / pos.Z)
        partEspBoxes[i].Size = Vector2.new(sz, sz)
        partEspBoxes[i].Position = Vector2.new(pos.X - sz/2, pos.Y - sz/2)
        partEspLabels[i].Text = part.Name
        partEspLabels[i].Position = Vector2.new(pos.X, pos.Y - sz/2 - 15)
      end
    end
  end
  -- hide extras
  for i = #partEspTargets + 1, #partEspBoxes do
    partEspBoxes[i].Visible = false partEspLabels[i].Visible = false
  end
end)
MainTab:CreateToggle({
  Name = 'Part ESP',
  CurrentValue = false,
  Callback = function(v)
    partEspEnabled = v
    if not v then
      for _, b in pairs(partEspBoxes) do b.Visible=false end
      for _, l in pairs(partEspLabels) do l.Visible=false end
    end
  end
})
MainTab:CreateButton({Name='Refresh Part ESP Targets', Callback=function() refreshPartEspTargets(nil) Rayfield:Notify({Title='Part ESP',Content=#partEspTargets..' parts found',Duration=2}) end})

local statsEnabled = false
local statsText = {}
local function removeStats(p) if statsText[p] then statsText[p]:Remove() statsText[p]=nil end end
Players.PlayerRemoving:Connect(removeStats)
RS.RenderStepped:Connect(function()
  for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character then
      local hrp = p.Character:FindFirstChild('HumanoidRootPart')
      local hum = p.Character:FindFirstChildOfClass('Humanoid')
      if hrp and hum then
        local pos, vis = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
        if not statsText[p] then
          local t=Drawing.new('Text') t.Size=13 t.Color=Color3.new(0,1,1) t.Outline=true t.Center=true t.Visible=false statsText[p]=t
        end
        statsText[p].Visible = statsEnabled and vis
        if statsEnabled and vis then
          local vel = math.floor(hrp.Velocity.Magnitude)
          local hp = math.floor(hum.Health)
          local maxhp = math.floor(hum.MaxHealth)
          statsText[p].Position = Vector2.new(pos.X, pos.Y - 60)
          statsText[p].Text = p.Name..'  HP:'..hp..'/'..maxhp..'  Vel:'..vel
        end
      end
    elseif statsText[p] then removeStats(p) end
  end
end)
MainTab:CreateToggle({Name='Player Stats (HP+Vel)',CurrentValue=false,Callback=function(v) statsEnabled=v end})

local aimbotOn = false
RS.RenderStepped:Connect(function()
  if not aimbotOn then return end
  if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then return end
  local nearest, nearDist = nil, math.huge
  for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character then
      local hrp = p.Character:FindFirstChild('HumanoidRootPart')
      if hrp then
        local d = (hrp.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
        if d < nearDist then nearest = hrp nearDist = d end
      end
    end
  end
  if nearest then
    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearest.Position)
  end
end)
MainTab:CreateToggle({Name='Aimbot (Hold RMB)',CurrentValue=false,Callback=function(v) aimbotOn=v end})

MainTab:CreateSlider({
  Name = 'Reach',
  Range = {5, 100},
  Increment = 1,
  Suffix = ' studs',
  CurrentValue = 10,
  Callback = function(v)
    local char = LP.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass('Tool')
    if tool then
      local handle = tool:FindFirstChild('Handle')
      if handle then handle.Size = Vector3.new(v, v, v) end
    end
  end
})

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

local tpX,tpY,tpZ = 0,0,0
MainTab:CreateInput({Name='X',PlaceholderText='0',Callback=function(v) tpX=tonumber(v) or 0 end})
MainTab:CreateInput({Name='Y',PlaceholderText='0',Callback=function(v) tpY=tonumber(v) or 0 end})
MainTab:CreateInput({Name='Z',PlaceholderText='0',Callback=function(v) tpZ=tonumber(v) or 0 end})
MainTab:CreateButton({
  Name='Teleport',
  Callback=function()
    local hrp = LP.Character and LP.Character:FindFirstChild('HumanoidRootPart')
    if hrp then hrp.CFrame = CFrame.new(tpX,tpY,tpZ) end
  end
})

local spawnPos = CFrame.new(0,0,0)  -- set this to your target position
local function onSpawn(char)
  char:WaitForChild('HumanoidRootPart')
  task.wait(0.1)  -- brief delay for physics to settle
  char.HumanoidRootPart.CFrame = spawnPos
end
LP.CharacterAdded:Connect(onSpawn)
if LP.Character then onSpawn(LP.Character) end

local clickTpOn = false
UIS.InputBegan:Connect(function(inp, gpe)
  if gpe then return end
  if not clickTpOn then return end
  if inp.UserInputType == Enum.UserInputType.MouseButton1 then
    local ray = workspace:Raycast(workspace.CurrentCamera.CFrame.Position,
      (workspace.CurrentCamera.CFrame.LookVector + UIS:GetMouseLocation() - Vector2.new(0,0)).Unit * 500,
      RaycastParams.new())
    if ray then
      local hrp = LP.Character and LP.Character:FindFirstChild('HumanoidRootPart')
      if hrp then hrp.CFrame = CFrame.new(ray.Position + Vector3.new(0,3,0)) end
    end
  end
end)
MainTab:CreateToggle({Name='Click Teleport',CurrentValue=false,Callback=function(v) clickTpOn=v end})

local function touchPart(partName)
  local part
  for _, v in pairs(workspace:GetDescendants()) do
    if v.Name == partName and v:IsA('BasePart') then part = v break end
  end
  local hrp = LP.Character and LP.Character:FindFirstChild('HumanoidRootPart')
  if part and hrp then
    firetouchinterest(part, hrp, 1)
    task.wait(0.1)
    firetouchinterest(part, hrp, 0)
    Rayfield:Notify({Title='Touched', Content=partName, Duration=2})
  else
    Rayfield:Notify({Title='Not Found', Content=partName..' not found in workspace', Duration=3})
  end
end
MainTab:CreateButton({Name='Touch Teleport1', Callback=function() touchPart('PartName') end})

local touchPartMap = {}
local selectedTouchPart = nil
local function scanTouchParts()
  touchPartMap = {}
  local names = {}
  for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA('BasePart') then
      for _, c in pairs(v:GetChildren()) do
        if c:IsA('TouchTransmitter') then
          touchPartMap[v.Name] = v
          table.insert(names, v.Name)
          break
        end
      end
    end
  end
  return names
end
local partNames = scanTouchParts()
if #partNames == 0 then
  MainTab:CreateLabel('No TouchInterest parts found in workspace')
else
  selectedTouchPart = partNames[1]
  local dd = MainTab:CreateDropdown({
    Name = 'Select Part',
    Options = partNames,
    CurrentOption = {partNames[1]},
    MultipleOptions = false,
    Callback = function(val) selectedTouchPart = val[1] end
  })
  MainTab:CreateButton({Name = 'Touch Selected', Callback = function()
    local part = touchPartMap[selectedTouchPart]
    local hrp = LP.Character and LP.Character:FindFirstChild('HumanoidRootPart')
    if part and hrp then
      firetouchinterest(part, hrp, 1) task.wait(0.1) firetouchinterest(part, hrp, 0)
      Rayfield:Notify({Title='Touched', Content=selectedTouchPart, Duration=2})
    else
      Rayfield:Notify({Title='Error', Content='Part or character not found', Duration=3})
    end
  end})
  MainTab:CreateButton({Name = 'Rescan Parts', Callback = function()
    local newNames = scanTouchParts()
    dd:Refresh(newNames)
    Rayfield:Notify({Title='Rescanned', Content=#newNames..' parts found', Duration=2})
  end})
end

local oldNc
oldNc = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
  local method = getnamecallmethod()
  if not checkcaller() then
    if method == 'FireServer' then
      -- self = RemoteEvent, ... = args
      -- print(self:GetFullName(), ...)
    elseif method == 'InvokeServer' then
      -- self = RemoteFunction
    end
  end
  return oldNc(self, ...)
end))

local farmOn = false
MainTab:CreateToggle({
  Name='Auto Farm',
  CurrentValue=false,
  Callback=function(v) farmOn=v end
})
task.spawn(function()
  while task.wait(0.1) do
    if farmOn then
      -- replace with your actual ClickDetector path:
      local cd = workspace:FindFirstChild('PartName') and workspace.PartName:FindFirstChildOfClass('ClickDetector')
      if cd then fireclickdetector(cd) end
    end
  end
end)

local CONFIG_FILE = 'MyScript_config.json'
local function saveConfig(data)
  writefile(CONFIG_FILE, game:GetService('HttpService'):JSONEncode(data))
end
local function loadConfig()
  if isfile(CONFIG_FILE) then
    return game:GetService('HttpService'):JSONDecode(readfile(CONFIG_FILE))
  end
  return {}
end

local CobaltTab = Window:CreateTab('Remote Spy', 4483362458)
CobaltTab:CreateButton({Name = 'Open Cobalt Spy', Callback = function() loadstring(game:HttpGet('https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau'))() end})
