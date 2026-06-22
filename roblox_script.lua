-- Load the Rayfield library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create a main window with some basic settings
local Window = Rayfield:CreateWindow({ Name='MyGUI', LoadingTitle='Loading', Theme='Default' })

-- Create the first tab for our GUI
local Tab1 = Window:CreateTab('Tab 1', 507346582) -- Use your own asset ID here if desired

-- Create a section in Tab 1 with basic settings
Tab1:CreateSection('My Section', 507346582) -- Use your own asset ID here if desired

-- Add a button to the section that calls a callback function when clicked
local Button = Tab1:CreateButton({ Name='Click Me', Callback=function() Rayfield:Notify({ Title='Title', Content='Message' }) end })

-- Create the second tab for our GUI with basic settings
local Tab2 = Window:CreateTab('Tab 2', 507346582) -- Use your own asset ID here if desired

-- Add a toggle to the section that calls a callback function when toggled
local Toggle = Tab2:CreateToggle({ Name='Toggle', CurrentValue=false, Flag='toggle1', Callback=function(v) Rayfield:Notify({ Title='Title', Content='Message' }) end })

-- Add a slider to the section that calls a callback function when its value changes
local Slider = Tab2:CreateSlider({ Name='Speed', Range={0,100}, Increment=1, CurrentValue=16, Flag='speed', Callback=function(v) Rayfield:Notify({ Title='Title', Content='Message' }) end })

-- Add an input field to the section that calls a callback function when its value changes
local Input = Tab2:CreateInput({ Name='Input', PlaceholderText='Enter text', Callback=function(t) Rayfield:Notify({ Title='Title', Content='Message' }) end })

-- Add a dropdown to the section that calls a callback function when an option is selected
local Dropdown = Tab2:CreateDropdown({ Name='Select', Options={'A','B'}, CurrentOption={'A'}, Flag='dd1', Callback=function(o) Rayfield:Notify({ Title='Title', Content='Message' }) end })

-- Add a colorpicker to the section that calls a callback function when its color changes
local ColorPicker = Tab2:CreateColorPicker({ Name='Color', Color=Color3.new(1,0,0), Flag='col1', Callback=function(c) Rayfield:Notify({ Title='Title', Content='Message' }) end })

-- Add a keybind to the section that calls a callback function when it is pressed or released
local KeyBind = Tab2:CreateKeybind({ Name='Key', CurrentKeybind='Q', HoldToInteract=false, Flag='kb1', Callback=function(k) Rayfield:Notify({ Title='Title', Content='Message' }) end })