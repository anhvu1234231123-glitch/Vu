-- ⚠️ CHỈ DÙNG CHO HỌC TẬP / TEST
-- AUTO FARM BLOX FRUITS (BASIC – BẢN LÚC ĐẦU)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

-- CÀI ĐẶT
getgenv().AutoFarm = true
getgenv().FarmDistance = 6
getgenv().TweenSpeed = 200

-- LẤY NHÂN VẬT
local function getChar()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
    return getChar():WaitForChild("HumanoidRootPart")
end

-- DI CHUYỂN
local function tweenTo(cf)
    local hrp = getHRP()
    local dist = (hrp.Position - cf.Position).Magnitude
    local time = dist / getgenv().TweenSpeed
    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {CFrame = cf}
    )
    tween:Play()
    tween.Completed:Wait()
end

-- TÌM MOB GẦN NHẤT
local function getNearestMob()
    local nearest, minDist = nil, math.huge
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("Humanoid")
        and mob.Humanoid.Health > 0
        and mob:FindFirstChild("HumanoidRootPart") then
            local d = (mob.HumanoidRootPart.Position - getHRP().Position).Magnitude
            if d < minDist then
                minDist = d
                nearest = mob
            end
        end
    end
    return nearest
end

-- ĐÁNH
local function attack()
    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(0.1)
    VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end

-- VÒNG LẶP FARM
RunService.RenderStepped:Connect(function()
    if not getgenv().AutoFarm then return end
    pcall(function()
        local mob = getNearestMob()
        if mob then
            tweenTo(mob.HumanoidRootPart.CFrame * CFrame.new(0,0,getgenv().FarmDistance))
            attack()
        end
    end)
end)

print("Auto Farm Loaded")
