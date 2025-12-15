repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

repeat task.wait() until player.Character
local char = player.Character
local hum = char:WaitForChild("Humanoid")

-- Cầm vũ khí
local function EquipWeapon()
    for _,v in pairs(player.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            hum:EquipTool(v)
            break
        end
    end
end

-- Đánh (giả click)
local function Attack()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(0.1)
    VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end

-- TEST: đứng yên vẫn đánh
while task.wait(0.25) do
    EquipWeapon()
    Attack()
end
