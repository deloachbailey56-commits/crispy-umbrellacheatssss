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

local CobaltTab = Window:CreateTab('Remote Spy', 4483362458)
CobaltTab:CreateButton({Name = 'Open Cobalt Spy', Callback = function() loadstring(game:HttpGet('https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau'))() end})
