

repeat wait() until game:IsLoaded()

-- Variables
loadstring(game:HttpGet("https://raw.githubusercontent.com/mixwar/myscripts/main/Lua%20Albara.lua"))()


local GlobalTargetPlayer = nil
local GlobalTargetPosition = nil
local GlobalTarget = nil
local SAimGlobalTarget = nil
local SAimGlobalTargetPosition = nil
local HasInitialized = false


FovCircle = Drawing.new("Circle")
FovCircle.Thickness = 0.8
FovCircle.NumSides = 40
FovCircle.Radius = 100
FovCircle.Filled = false
FovCircle.Position = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.x / 2, game.Workspace.CurrentCamera.ViewportSize.y / 2)
FovCircle.Visible = false
FovCircle.Transparency = 1

SAimFovCircle = Drawing.new("Circle")
SAimFovCircle.Thickness = 0.8
SAimFovCircle.NumSides = 40
SAimFovCircle.Radius = 100
SAimFovCircle.Filled = false
SAimFovCircle.Position = Vector2.new(game.Workspace.CurrentCamera.ViewportSize.x / 2, game.Workspace.CurrentCamera.ViewportSize.y / 2)
SAimFovCircle.Visible = false
SAimFovCircle.Transparency = 1

-- UI Library
local AimTab = library:AddTab("AimBot", 1); 

local AimbotColumn =  AimTab:AddColumn();


-- Aimbot
local Aimbot = AimbotColumn:AddSection("Aimbot")


local function get2dDistance(src, dst)
    return math.sqrt(math.pow(src.x - dst.x, 2) + math.pow(src.y - dst.y, 2))
end
local function get3dDistance(src, dst)
    return math.sqrt(math.pow(src.x - dst.x, 2) + math.pow(src.y - dst.y, 2) + math.pow(src.z - dst.z, 2))
end






local function Checkfov(pos2, fov)
    local ssize =
    Vector2.new(
    game.Workspace.CurrentCamera.ViewportSize.x / 2,
    game.Workspace.CurrentCamera.ViewportSize.y / 2
)

if (ssize - pos2).Magnitude < fov then
    return true
else
    return false
end
end

local function IsVisible(pos, part)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {game.Players.LocalPlayer.Character, part.Parent}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local Result = workspace:Raycast(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, (pos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).unit * (pos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude, params)
    if Result ~= nil then
        return false
    end
    return true
end


local function GetClosestToCenter()
    local UserInputService = game:GetService("UserInputService")
    local Camera = game.Workspace.CurrentCamera
    local Distance = 99999
    local SAimDistance = 99999
    local PlayerPos2 = Vector2.new(0,0)
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Character and v.Name ~= game.Players.LocalPlayer.Name then
            local PlayerHeadPart = v.Character:FindFirstChild(library.flags["Priority"])
            local ssize = Vector2.new(Camera.ViewportSize.x / 2, Camera.ViewportSize.y / 2)
            if PlayerHeadPart then
                pos3 = Camera:WorldToViewportPoint(PlayerHeadPart.Position)
                if pos3.z > 0 then
                    pos2 = Vector2.new(pos3.x, pos3.y)
                    local dist = get2dDistance(pos2, ssize)
                    if library.flags["TeamCheck"] then
                        if v.Team ~= game.Players.LocalPlayer.Team then
                            if dist < Distance  then
                                Distance = dist
                                ReturnPlayer = v
                                PlayerPos2 = pos2
                            end
                        end 
                    else
                        if dist < Distance  then
                            Distance = dist
                            ReturnPlayer = v
                            PlayerPos2 = pos2
                        end               
                    end
                   
                        
                    
                end
            end
        end
    end
    print(ReturnPlayer, PlayerPos2)
    return ReturnPlayer, PlayerPos2, SAimReturnPlayer, SAimPlayerPos2
end



local function CameraAimbot()
    local Cam = game.Workspace.CurrentCamera
    local MyPart = game.Players.LocalPlayer.Character:FindFirstChild(library.flags["Priority"])
    if GlobalTarget and MyPart and Checkfov(GlobalTargetPosition, library.flags["FOV"])  then
        if (MyPart.Position - GlobalTarget.Position).Magnitude / 3 < library.flags["AimDistance"] then
            if IsVisible(GlobalTarget.Position, GlobalTarget) and library.flags["VisCheck"] then
                Cam.CFrame = CFrame.new(Cam.CFrame.p, GlobalTarget.CFrame.p) 
            end 
            if not library.flags["VisCheck"] then 
                Cam.CFrame = CFrame.new(Cam.CFrame.p, GlobalTarget.CFrame.p) 
            end
        end
    end
end

local function MouseAimbot(pSmoothness)
    local Camera = game.Workspace.CurrentCamera
    local ScreenSize = Vector2.new(Camera.ViewportSize.x / 2, Camera.ViewportSize.y / 2)    
    local RelativeOffset = GlobalTargetPosition - ScreenSize
    local MyPart = game.Players.LocalPlayer.Character:FindFirstChild(library.flags["Priority"])
    
    if Checkfov(GlobalTargetPosition, library.flags["FOV"]) then
        if MyPart and GlobalTarget then
            if (MyPart.Position - GlobalTarget.Position).Magnitude / 3 < library.flags["AimDistance"] then 
                if IsVisible(GlobalTarget.Position, GlobalTarget) and library.flags["VisCheck"] then
                    mousemoverel(RelativeOffset.x / pSmoothness, RelativeOffset.y / pSmoothness)
                end
                if not library.flags["VisCheck"] then 
                    mousemoverel(RelativeOffset.x / pSmoothness, RelativeOffset.y / pSmoothness)
                end
            end
        end
    end
end





-- Metamethod 


local function ItializedMetamethodHooks() 
    local OldIndex = nil
    local OldNameCall = nil
    
    
    OldIndex = hookmetamethod(game, "__index", function(Self, Key) -- METHOD 2
        if checkcaller() then return OldIndex(Self, Key) end 
        
        

        
        
        
        return OldIndex(Self, Key)
    end)
    
    
    OldNameCall = hookmetamethod(game, "__namecall", function(...) -- METHOD 1
        if checkcaller() then return OldNameCall(...) end 
        local Method = getnamecallmethod()
        local MethodArgs = {...}
        

    end)
end

--[[
Wasnt ------------------------------------
]]--
spawn(function()
    while task.wait(0.05) do
        local Player, PlayerPosition, SAimPlayer, SAimPlayerPosition = GetClosestToCenter()
        if SAimPlayer and SAimPlayer.Character then
            local SAimTargetPart = SAimPlayer.Character:FindFirstChild(library.flags["Priority"])
            if SAimTargetPart then
                SAimGlobalTarget = SAimTargetPart
                SAimGlobalTargetPosition = SAimPlayerPosition
            end 
        end
        if Player and Player.Character then
            local TargetPart = Player.Character:FindFirstChild(library.flags["Priority"])
            if TargetPart then
                GlobalTarget = TargetPart
                GlobalTargetPosition = PlayerPosition
                GlobalTargetPlayer = Player
            end
        end
    end
end)

Aimbot:AddToggle({text = "Enabled", flag = "AimEnabled", state = false}):AddBind({mode = "hold", key = "MouseButton2", callback = function(a) 
    if a then else if not library.flags["AimEnabled"]then return end;if library.flags["AimMode"]=="Camera"then CameraAimbot()else MouseAimbot(library.flags["AimSmoothness"])end end
end})

Aimbot:AddToggle({text = "Team Check", flag = "TeamCheck", state = false})

:AddColor({flag = "SAimCircleColor", color = Color3.fromRGB(255, 255, 255), callback = function(a) SAimFovCircle.Color = a end});

Aimbot:AddList({text = "Mode", max = 3, flag = "AimMode", values = {"Camera", "Mouse"}, value = "Camera"});

Aimbot:AddDivider();
Aimbot:AddSlider({text = "Sensitive of Aiming", flag = "AimSmoothness", tip = "Aimbot mouse only", min = 1, max = 100, value = 5})

Aimbot:AddList({text = "Target Priority", max = 3, flag = "Priority", values = {"Head", "HumanoidRootPart", "Torso"}, value = "Head"});

Aimbot:AddDivider();
Aimbot:AddToggle({text = "Wall Check", flag = "VisCheck", state = false})
Aimbot:AddToggle({text = "Draw Circle", flag = "Circle", state = false, callback = function(a) FovCircle.Visible = a
end}):AddColor({flag = "CircleColor", color = Color3.fromRGB(255, 255, 255), callback = function(a) FovCircle.Color = a end});
Aimbot:AddSlider({text = "Circle Radius", flag = "FOV", min = 1, max = 1000, value = 100, callback = function(a) FovCircle.Radius = a end})
Aimbot:AddSlider({text = "Aim Distance", flag = "AimDistance", min = 1, max = 5000, value = 100})



-- Visual Sections





local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Cam = workspace.CurrentCamera
local Esp = {}

pcall(function()
    local function AddToEsp(Player)
        local Outline = Drawing.new("Square")
        Outline.Color = Color3.fromRGB(0,0,0)
        Outline.Visible = false 
        Outline.Thickness = 3
        
        
        local Box = Drawing.new("Square")
        Box.Color = Color3.fromRGB(255, 255, 255)
        Box.Visible = false 
        Box.Thickness = 1.3
        
        local Name = Drawing.new("Text")
        Name.Center = true 
        Name.Outline = true 
        Name.OutlineColor = Color3.fromRGB(0,0,0)
        Name.Color = Color3.fromRGB(255, 255, 255)
        Name.Text = Player.Name
        Name.Font = Drawing.Fonts.Plex
        
        local HealthBarOutLine = Drawing.new("Line")
        HealthBarOutLine.Thickness = 3
        HealthBarOutLine.Color = Color3.new(0,0,0)
        
        local HealthBar = Drawing.new("Line")
        HealthBar.Thickness = 1.3 
        HealthBar.Color = Color3.new(0,255,0)
        
        local TracerOutLine = Drawing.new("Line")
        TracerOutLine.Thickness = 3
        TracerOutLine.Color = Color3.fromRGB(0, 0, 0)
        
        local Tracer = Drawing.new("Line")
        Tracer.Thickness = 1.3
        Tracer.Color = Color3.fromRGB(255, 255, 255)
        
        
        Esp[Player] = {
            ["Box"] = Box,
            ["Outline"] = Outline,
            ["Name"] = Name,
            ["Health"] = {
                HealthBarOutLine,
                HealthBar
            },
            ["Tracer"] = Tracer,
            ["TracerOutLine"] = TracerOutLine
        }
    end 
    
    local function SizeVecs(Part)
        local Size = Part.Size
        
        return {
            TBRC = Part.CFrame * CFrame.new(Size.X,Size.Y * 1.3,Size.Z),
            TBLC = Part.CFrame * CFrame.new(-Size.X,Size.Y * 1.3,Size.Z),
            TFRC = Part.CFrame * CFrame.new(Size.X,Size.Y * 1.3,-Size.Z),
            TFLC = Part.CFrame * CFrame.new(-Size.X,Size.Y * 1.3,-Size.Z ),
            
            BBRC = Part.CFrame * CFrame.new(Size.X,-Size.Y * 1.6,Size.Z),
            BBLC = Part.CFrame * CFrame.new(-Size.X,-Size.Y * 1.6,Size.Z),
            BFRC = Part.CFrame * CFrame.new(Size.X,-Size.Y * 1.6,-Size.Z),
            BFLC = Part.CFrame * CFrame.new(-Size.X,-Size.Y * 1.6,-Size.Z),
        }
    end
    
    game:GetService("RunService").RenderStepped:Connect(function()
            for I,V in pairs(Esp) do 
                if I and I.Team ~= LocalPlayer.Team or I.Team == nil and I.Character and I.Character:FindFirstChild("HumanoidRootPart") and I.Character:FindFirstChild("Humanoid") then
                        local Hum = I.Character.Humanoid
                        local Hrp = I.Character.HumanoidRootPart
                        local RootVec,On = Cam:WorldToScreenPoint(Hrp.Position)
                        local Distance = math.floor((Cam.CFrame.Position - Hrp.CFrame.Position).Magnitude)
                    
                        local GrabDeminsons = SizeVecs(Hrp)
                        local YMin,YMax = Cam.ViewportSize.X,0 
                        local XMin,XMax = Cam.ViewportSize.X,0 
                        
                        for _,V in pairs(GrabDeminsons) do 
                            
                            local Vec = Cam:WorldToViewportPoint(V.Position)
                            
                            if Vec.X < XMin then 
                                XMin = Vec.X 
                            end 
                            
                            if Vec.X > XMax then 
                                XMax = Vec.X 
                            end 
                            
                            if Vec.Y < YMin then 
                                YMin = Vec.Y 
                            end 
                            
                            if Vec.Y > YMax then 
                                YMax = Vec.Y 
                            end 
                        end 
                        
                        local Font = library.flags["Font"]
                        
                        V["Box"].Size = Vector2.new(XMin - XMax,YMin - YMax)
                        V["Box"].Position = Vector2.new(XMax + V["Box"].Size.X / XMin, YMax + V["Box"].Size.Y / YMin) 
                        V["Box"].Color = library.flags["BoxColor"]
                        
                        V["Name"].Size = 13
                        V["Name"].Position = Vector2.new(XMax + V["Box"].Size.X / 2,V["Box"].Position.Y) - Vector2.new(0,V["Name"].TextBounds.Y - V["Box"].Size.Y + 1)
                        V["Name"].Color = library.flags["NameColor"]
                        V["Name"].Size = library.flags["FontSize"]
                        
                        if Font == "Plex" then 
                            V["Name"].Font = 2
                        end
                        if Font == "UI" then 
                            V["Name"].Font = 0
                        end
                        if Font == "System" then 
                            V["Name"].Font = 1
                        end
                        if Font == "Monospace" then 
                            V["Name"].Font = 3
                        end
                        
                        
                        if library.flags["Distance"] then 
                            if library.flags["HealthNumber"] then 
                                V["Name"].Text = I.Name.." ["..tostring(Distance).."]" .. "[" .. Hum.Health .. "]"
                            else
                                V["Name"].Text = I.Name.." ["..tostring(Distance).."]"
                            end
                        else 
                            if library.flags["HealthNumber"] then 
                                V["Name"].Text = I.Name .. " [" .. Hum.Health .. "]"
                            else
                                V["Name"].Text = I.Name
                            end
                        end
                        
                        
                        V["Health"][1].From = Vector2.new(XMax + V["Box"].Size.X - 5,V["Box"].Position.Y)
                        V["Health"][1].To = Vector2.new(V["Health"][1].From.X,V["Box"].Position.Y + V["Box"].Size.Y)
                        
                        V["Health"][2].From = Vector2.new(XMax + V["Box"].Size.X - 5,V["Box"].Position.Y)
                        V["Health"][2].To = Vector2.new(V["Health"][1].From.X,V["Box"].Position.Y + V["Box"].Size.Y / (Hum.MaxHealth / Hum.Health))
                        V["Health"][2].Color = library.flags["HealthColor"]
                        
                        V["Outline"].Size = Vector2.new(XMin - XMax,YMin - YMax)
                        V["Outline"].Position = Vector2.new(XMax + V["Box"].Size.X / XMin,YMax + V["Box"].Size.Y / YMin) 
                        --V["Outline"].Color = library.flags["BoxOutline"]
                        
                        V["Tracer"].From = Vector2.new(Cam.ViewportSize.X / 2,Cam.ViewportSize.Y)
                        V["Tracer"].To = Vector2.new(XMax + V["Box"].Size.X / 2,V["Box"].Position.Y)
                        --V["Tracer"].Color = library.flags["TracerColor"]
                        
                        V["TracerOutLine"].From = Vector2.new(Cam.ViewportSize.X / 2,Cam.ViewportSize.Y)
                        V["TracerOutLine"].To = Vector2.new(XMax + V["Box"].Size.X / 2,V["Box"].Position.Y)
                        --V["TracerOutLine"].Color = library.flags["TracerOutline"]
                        
                        
                        if On then
                            V["Tracer"].Visible = false
                            V["TracerOutLine"].Visible = false
                            V["Health"][1].Visible = library.flags["Healthbar"]
                            V["Health"][2].Visible = library.flags["Healthbar"]
                            V["Name"].Visible = library.flags["Name"]
                            V["Outline"].Visible = library.flags["Box"]
                            V["Box"].Visible = library.flags["Box"] 
                        else 
                            V["Tracer"].Visible = false
                            V["TracerOutLine"].Visible = false
                            V["Health"][1].Visible = false 
                            V["Health"][2].Visible = false
                            V["Name"].Visible = false
                            V["Outline"].Visible = false
                            V["Box"].Visible = false
                        end 
                    else 
                        V["Tracer"].Visible = false
                        V["TracerOutLine"].Visible = false
                        V["Health"][1].Visible = false 
                        V["Health"][2].Visible = false
                        V["Name"].Visible = false
                        V["Outline"].Visible = false
                        V["Box"].Visible = false 
                    end 
            end 
            
            

        
        end)

        for _,V in pairs(Players:GetChildren()) do 
            if V ~= LocalPlayer then
                AddToEsp(V)
            end
        end 
        
        Players.PlayerAdded:Connect(function(V)
            AddToEsp(V)
        end)
end)

-- [Misc] --------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Misc Sections

-- [Init] --------------------------------------------------------------------------------------------------------------------------------------------------------------------

library:Init();
library:selectTab(library.tabs[1]);
