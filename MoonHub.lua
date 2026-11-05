
-- 🌙 MOON HUB V1
-- Delta Executor UI Prototype

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MoonHub"
gui.ResetOnSpawn = false

pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)

if not gui.Parent then
    gui.Parent = player:WaitForChild("PlayerGui")
end

local purple = Color3.fromRGB(145, 90, 220)
local dark = Color3.fromRGB(20, 16, 32)

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(310, 390)
main.Position = UDim2.new(0.5, -155, 0.5, -195)
main.BackgroundColor3 = dark
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 14)

local stroke = Instance.new("UIStroke", main)
stroke.Color = purple
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 0, 45)
title.Position = UDim2.fromOffset(12, 0)
title.BackgroundTransparency = 1
title.Text = "🌙 MOON HUB"
title.TextColor3 = Color3.fromRGB(220, 190, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 23
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30, 30)
close.Position = UDim2.new(1, -38, 0, 7)
close.Text = "×"
close.TextSize = 22
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(90,40,110)
close.Parent = main

Instance.new("UICorner", close)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- 拖曳視窗
local dragging = false
local dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.fromOffset(8, 52)
sidebar.Size = UDim2.fromOffset(105, 325)
sidebar.BackgroundColor3 = Color3.fromRGB(32,25,45)
sidebar.Parent = main
Instance.new("UICorner", sidebar)

local content = Instance.new("ScrollingFrame")
content.Position = UDim2.fromOffset(120, 52)
content.Size = UDim2.fromOffset(182, 325)
content.BackgroundColor3 = Color3.fromRGB(32,25,45)
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.Parent = main
Instance.new("UICorner", content)

local pages = {
    ["防護"] = {
        "防抓",
        "防踢",
        "防香蕉",
        "防火",
        "防炸彈",
        "防黑洞"
    },
    ["效能"] = {
        "防卡",
        "降低特效"
    },
    ["Blobman"] = {
        "Blobman 踢（私人測試）"
    },
    ["木板"] = {
        "木板踢（私人測試）"
    },
    ["視角"] = {
        "第三人稱",
        "視角距離"
    },
    ["玩家"] = {
        "顯示玩家名字",
        "玩家列表"
    },
    ["設定"] = {
        "恢復預設"
    }
}

local function clear()
    for _,v in ipairs(content:GetChildren()) do
        if v:IsA("GuiObject") then
            v:Destroy()
        end
    end
end

local function showPage(name)
    clear()

    local heading = Instance.new("TextLabel")
    heading.Size = UDim2.new(1,-10,0,35)
    heading.Position = UDim2.fromOffset(5,3)
    heading.BackgroundTransparency = 1
    heading.Text = name
    heading.TextColor3 = Color3.fromRGB(210,175,255)
    heading.Font = Enum.Font.GothamBold
    heading.TextSize = 18
    heading.Parent = content

    local y = 43

    for _,item in ipairs(pages[name]) do
        local enabled = false
        local button = Instance.new("TextButton")

        button.Size = UDim2.new(1,-12,0,35)
        button.Position = UDim2.fromOffset(6,y)
        button.BackgroundColor3 = Color3.fromRGB(55,42,75)
        button.TextColor3 = Color3.new(1,1,1)
        button.TextSize = 12
        button.Font = Enum.Font.GothamMedium
        button.Text = item.." [OFF]"
        button.Parent = content

        Instance.new("UICorner",button)

        button.MouseButton1Click:Connect(function()
            enabled = not enabled
            button.Text = item..
                (enabled and " [ON]" or " [OFF]")

            button.BackgroundColor3 = enabled
                and purple
                or Color3.fromRGB(55,42,75)

            -- 目前為介面原型
            -- 各項遊戲功能尚未連接
        end)

        y = y + 42
    end

    content.CanvasSize = UDim2.fromOffset(0,y+5)
end

local y = 8

for name in pairs(pages) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-10,0,37)
    button.Position = UDim2.fromOffset(5,y)
    button.BackgroundColor3 = Color3.fromRGB(60,43,82)
    button.TextColor3 = Color3.new(1,1,1)
    button.TextSize = 12
    button.Text = name
    button.Parent = sidebar

    Instance.new("UICorner",button)

    button.MouseButton1Click:Connect(function()
        showPage(name)
    end)

    y = y + 43
end

showPage("防護")

print("MOON HUB V1 Loaded 🌙")
