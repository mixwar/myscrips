

local ScreenGui = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Concept = Instance.new("TextButton")
local Suicide = Instance.new("TextButton")
local msm = Instance.new("TextButton")
local tomb = Instance.new("TextButton")
local jstore = Instance.new("TextButton")
local tesla = Instance.new("TextButton")

--Properties:

ScreenGui.Parent = game.CoreGui

main.Name = "main"
main.Parent = ScreenGui
main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
main.Position = UDim2.new(0.904175222, 0, 0.735802472, 0)
main.Size = UDim2.new(0, 62, 0, 128)
main.Active = true
main.Draggable = true

TextLabel.Parent = main
TextLabel.BackgroundColor3 = Color3.fromRGB(108, 126, 125)
TextLabel.Size = UDim2.new(0, 62, 0, 20)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Albara"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

Concept.Name = "Concept"
Concept.Parent = main
Concept.BackgroundColor3 = Color3.fromRGB(255, 238, 5)
Concept.Position = UDim2.new(0, 0, 0.299212635, 0)
Concept.Size = UDim2.new(0, 62, 0, 18)
Concept.Font = Enum.Font.SourceSans
Concept.Text = "Concept"
Concept.TextColor3 = Color3.fromRGB(0, 179, 6)
Concept.TextSize = 14.000
Concept.MouseButton1Down:connect(function()
local args = {
    [1] = "Chassis",
    [2] = "Concept"
}

game:GetService("ReplicatedStorage").GarageSpawnVehicle:FireServer(unpack(args))

end)

Suicide.Name = "Suicide"
Suicide.Parent = main
Suicide.BackgroundColor3 = Color3.fromRGB(185, 85, 87)
Suicide.Position = UDim2.new(0, 0, 0.157480329, 0)
Suicide.Size = UDim2.new(0, 62, 0, 18)
Suicide.Font = Enum.Font.SourceSans
Suicide.Text = "Suicide"
Suicide.TextColor3 = Color3.fromRGB(228, 248, 12)
Suicide.TextScaled = true
Suicide.TextSize = 14.000
Suicide.TextWrapped = true
Suicide.MouseButton1Down:connect(function()
workspace.RobberyTomb.DartRoom.Darts:FindFirstChild("9").DartDamage:FireServer()

end)

msm.Name = "msm"
msm.Parent = main
msm.BackgroundColor3 = Color3.fromRGB(255, 238, 5)
msm.Position = UDim2.new(0, 0, 0.44094491, 0)
msm.Size = UDim2.new(0, 62, 0, 18)
msm.Font = Enum.Font.SourceSans
msm.Text = "MSM"
msm.TextColor3 = Color3.fromRGB(0, 179, 6)
msm.TextScaled = true
msm.TextSize = 14.000
msm.TextWrapped = true
msm.MouseButton1Down:connect(function()
for i = 1, 50 do
    game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(1070.796142578125, 130.0579605102539, 1363.9810791015625))
    task.wait(0.01)
end
end)

tomb.Name = "tomb"
tomb.Parent = main
tomb.BackgroundColor3 = Color3.fromRGB(255, 238, 5)
tomb.Position = UDim2.new(0, 0, 0.582677186, 0)
tomb.Size = UDim2.new(0, 62, 0, 18)
tomb.Font = Enum.Font.SourceSans
tomb.Text = "Tomb"
tomb.TextColor3 = Color3.fromRGB(0, 179, 6)
tomb.TextScaled = true
tomb.TextSize = 14.000
tomb.TextWrapped = true
tomb.MouseButton1Down:connect(function()
for i = 1, 50 do
    game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(367.9652099609375, 22.229576110839844, 198.5996551513672))
    task.wait(0.01)
end
end)

jstore.Name = "jstore"
jstore.Parent = main
jstore.BackgroundColor3 = Color3.fromRGB(255, 238, 5)
jstore.Position = UDim2.new(0, 0, 0.724409461, 0)
jstore.Size = UDim2.new(0, 62, 0, 18)
jstore.Font = Enum.Font.SourceSans
jstore.Text = "J Store(Car)"
jstore.TextColor3 = Color3.fromRGB(0, 179, 6)
jstore.TextScaled = true
jstore.TextSize = 14.000
jstore.TextWrapped = true
jstore.MouseButton1Down:connect(function()
for i = 1, 50 do
    game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(114.67741394042969, 20.607443809509277, 1286.0283203125))
    task.wait()
    game:GetService("Players").LocalPlayer.Character:PivotTo(CFrame.new(92.08924102783203, 20.61429500579834, 1311.8311767578125))
end
end)

tesla.Name = "tesla"
tesla.Parent = main
tesla.BackgroundColor3 = Color3.fromRGB(255, 238, 5)
tesla.Position = UDim2.new(0, 0, 0.861712635, 0)
tesla.Size = UDim2.new(0, 62, 0, 18)
tesla.Font = Enum.Font.SourceSans
tesla.Text = "Tesla"
tesla.TextColor3 = Color3.fromRGB(0, 179, 6)
tesla.TextScaled = true
tesla.TextSize = 14.000
tesla.TextWrapped = true
tesla.MouseButton1Down:connect(function()
local args = {
    [1] = "Chassis",
    [2] = "Camaro"
}

game:GetService("ReplicatedStorage").GarageSpawnVehicle:FireServer(unpack(args))

end)