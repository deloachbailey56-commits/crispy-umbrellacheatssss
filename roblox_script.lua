-- Load Rayfield library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create main window with specified properties and settings
local Window = Rayfield:CreateWindow({
   Name = 'My Cheat Menu',
   LoadingTitle = 'Loading...',
   LoadingSubtitle = 'by you',
   Theme = 'Default',
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   KeySystem = false,
})

-- Create first tab with specified properties and settings
local MainTab = Window:CreateTab('Main', 4483362458)

-- Add elements to the main tab
MainTab:CreateSection('Section Name') -- Section element
MainTab:CreateButton({ Name='Click Me', Callback=function() end }) -- Button element
MainTab:CreateToggle({ Name='Toggle', CurrentValue=false, Flag='MyToggle1', Callback=function(Value) end }) -- Toggle element
MainTab:CreateSlider({ Name='Speed', Range={0,100}, Increment=1, CurrentValue=16, Flag='MySlider1', Callback=function(Value) end }) -- Slider element
MainTab:CreateInput({ Name='Input', PlaceholderText='Enter text', RemoveTextAfterFocusLost=false, Callback=function(Text) end }) -- Input element
MainTab:CreateDropdown({ Name='Select', Options={'A','B'}, CurrentOption={'A'}, MultipleOptions=false, Flag='MyDrop1', Callback=function(Options) end }) -- Dropdown element
MainTab:CreateColorPicker({ Name='Color', Color=Color3.new(1,0,0), Flag='MyColor1', Callback=function(Color) end }) -- Colorpicker element
MainTab:CreateKeybind({ Name='Key', CurrentKeybind='Q', HoldToInteract=false, Flag='MyKey1', Callback=function(Keybind) end }) -- Keybind element
MainTab:CreateLabel('Some label text') -- Label element
MainTab:CreateParagraph({ Title='Title', Content='Body text' }) -- Paragraph element

-- Notification when the script loads successfully
Rayfield:Notify({ Title='Ready', Content='Script loaded!', Duration=5 })