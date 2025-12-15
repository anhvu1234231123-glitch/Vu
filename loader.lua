-- BLOX FRUITS BASIC HUB (FIX)
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
repeat task.wait() until player.Character
local char = player.Character
local hum = char:WaitForChild("Humanoid")

-- ===== SETTINGS =====
getgenv().AutoFarm = false
getgenv().Distance = 6

-- ===== CHỈ CẦM 1 VŨ KHÍ =====
local Weapon
for _,v in pairs(player.Backpack:GetChildren()) do
    if v:IsA("Tool") then
        Weapon = v
        break
    end
end

local function EquipWeapon()
    if Weapon and Weapon.Parent ~= char then
        hum:EquipTool(Weapon)
    end
end

-- ===== ATTACK =====
local function Attack()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(0.1)
    VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end

-- ===== UI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "BasicHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,220,0,120)
frame.Position = UDim2.new(0,20,0.5,-60)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.Active = true
frame.Draggable = true

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1,-20,0,40)
btn.Position = UDim2.new(0,10,0,40)
btn.Text = "AUTO FARM: OFF"
btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
btn.TextColor3 = Color3.new(1,1,1)

btn.MouseButton1Click:Connect(function()
    getgenv().AutoFarm = not getgenv().AutoFarm
    btn.Text = "AUTO FARM: "..(getgenv().AutoFarm and "ON" or "OFF")
end)

-- ===== FARM LOOP =====
RunService.RenderStepped:Connect(function()
    if not getgenv().AutoFarm then return end
    pcall(function()
        if not workspace:FindFirstChild("Enemies") then return end
        for _,mob in pairs(workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid")
            and mob.Humanoid.Health > 0
            and mob:FindFirstChild("HumanoidRootPart") then

                EquipWeapon()

                local myHRP = char:FindFirstChild("HumanoidRootPart")
                if myHRP then
                    myHRP.CFrame =
                        mob.HumanoidRootPart.CFrame * CFrame.new(0,0,getgenv().Distance)
                end

                Attack()
                break
            end
        end
    end)
end)
