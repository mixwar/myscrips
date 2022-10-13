local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Jailbreak by Albara#9123", "Synapse")

------------------------------- main
local Main = Window:NewTab("Local")
local MainSection = Main:NewSection("Main")

MainSection:NewButton("Grab Shotgun", "Give you a Shotgun", function()
    local Bakery = game:GetService("Workspace").Givers.Station;

for _, ClickDetector in pairs(Bakery:GetDescendants()) do
    if (ClickDetector:IsA("ClickDetector")) then
        fireclickdetector(ClickDetector);
    end;
end;
end)

MainSection:NewButton("ShotGun Mod", "Shotgun Mod", function()
    for i,v in pairs(getgc(true))do
        if type(v)=="table" and rawget(v,"Damage") then
        v.MagSize=math.huge
        v.FireFreq=20
        v.BulletSpread=0.1
        v.FireAuto=true
        v.CamShakeMagnitude=0
        
    end
 end
end)


MainSection:NewToggle("No Wait", "No Wait on - off", function(state)
    if state then
        local Interface = require(game:GetService("ReplicatedStorage").Module.UI);
for i,a in next, Interface.CircleAction.Specs do
   a.Timed = false;
end;
    else
        local Interface = require(game:GetService("ReplicatedStorage").Module.UI);
for i,a in next, Interface.CircleAction.Specs do
   a.Timed = true;
end;
    end
end)

MainSection:NewToggle("Keycard", "Give you Keycard", function(state)
    if state then
        local plrUtils = game:GetService("ReplicatedStorage").Game.PlayerUtils
local oldHasKey = require(plrUtils).hasKey
require(plrUtils).hasKey = function() 
    return true
end
    else
        local plrUtils = game:GetService("ReplicatedStorage").Game.PlayerUtils
local oldHasKey = require(plrUtils).hasKey
require(plrUtils).hasKey = function() 
    return false
end
    end
end)

MainSection:NewButton("Inf Nitro", "Inf Nitro", function()
    local mouse = game:GetService('Players').LocalPlayer:GetMouse()

local function hotkeyHandler(key)
  if (key == 'q') then
    for _, v in next, getgc(true) do
      if (type(v) == 'table' and rawget(v, 'Nitro')) then
        v.Nitro = 250
      end
    end
  end
end

mouse.KeyDown:connect(hotkeyHandler)

end)


------------------------------------- Server
local Server = Window:NewTab("Server")
local ServerSection = Server:NewSection("Server")

ServerSection:NewToggle("Remove Grass", "Remove Grass", function(state)
    if state then
        sethiddenprop(workspace.Terrain, "Decoration", false)
    else
        sethiddenprop(workspace.Terrain, "Decoration", true)
    end
end)

ServerSection:NewButton("NPC No Damage", "NPC Off", function()
    game:GetService('RunService').Stepped:connect(function() -- i use this if i comes back
        if game:GetService("Workspace"):FindFirstChild("GuardNPCPlayers") then
        game:GetService("Workspace").GuardNPCPlayers:remove()
        end end)
end)

ServerSection:NewButton("ESP", "ESP Players", function()
    pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end)
end)

ServerSection:NewButton("Fling Player ( press X to on or off)", "Fling other players", function()
    _G.KeyCode = "X"
loadstring(game:HttpGet("https://shattered-gang.lol/scripts/fe/touch_fling.lua"))()
end)

ServerSection:NewButton("ESP Airdrop", "ESP Airdrop", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/GiJvzt5b'))()
end)

local About = Window:NewTab("About")
local Version = About:NewSection("Version 1.0.4")
local Credit = About:NewSection("Made By Albara#9123")
local Close = About:NewSection("Press G To Close The Gui")
Close:NewKeybind("Close/Open UI", "Opens And Closes The Gui", Enum.KeyCode.G, function()
    Library:ToggleUI()
end)
