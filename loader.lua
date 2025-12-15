-- BLOX FRUITS MINI HUB
warn("BLOX HUB START")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
if not game:IsLoaded() then game.Loaded:Wait() end

-- ===== SETTINGS =====
getgenv().AutoFarm = false
getgenv().AutoAttack = false
getgenv().AutoBuso = false
getgenv().Distance = 6

-- ===== UI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "MiniHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,240,0,220)
frame.Position = UDim2.new(0,20,0.5,-110)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true

local function makeBtn(text, y, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1,-20,0,36)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(callback)
    return b
end

local farmBtn = makeBtn("Auto Farm: OFF", 10, function()
    getgenv().AutoFarm = not getgenv().AutoFarm
    farmBtn.Text = "Auto Farm: "..(getgenv().AutoFarm and "ON" or "OFF")
end)

local atkBtn = makeBtn("Auto Attack: OFF", 55, function()
    getgenv().AutoAttack = not getgenv().AutoAttack
    atkBtn.Text = "Auto Attack: "..(getgenv().AutoAttack and "ON" or "OFF")
end)

local busoBtn = makeBtn("Auto Buso: OFF", 100, function()
    getgenv().AutoBuso = not getgenv().AutoBuso
    busoBtn.Text = "Auto Buso: "..(getgenv().AutoBuso and "ON" or "OFF")
end)

-- ===== LOGIC =====
RunService.RenderStepped:Connect(function()
    pcall(function()
        if getgenv().AutoFarm then
            if workspace:FindFirstChild("Enemies") then
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob:FindFirstChild("Humanoid")
                    and mob.Humanoid.Health > 0
                    and mob:FindFirstChild("HumanoidRootPart") then

                        local my = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if my then
                            my.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,getgenv().Distance)
                        end
                        break
                    end
                end
            end
        end

        if getgenv().AutoAttack then
            VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end

        if getgenv().AutoBuso then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end)
        end
    end)
end)
