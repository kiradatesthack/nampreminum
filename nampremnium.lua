local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

-- Đợi game tải
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Khởi tạo biến lưu trữ
getgenv().LastServerId = getgenv().LastServerId or game.JobId -- Lưu server ID hiện tại
getgenv().ScriptLoaded = getgenv().ScriptLoaded or false -- Trạng thái script đã chạy

-- Giao diện intro cải tiến
local function introAnimation()
    local screenGui = Instance.new("ScreenGui", PlayerGui)
    screenGui.IgnoreGuiInset = true
    screenGui.Name = "IntroGui"

    -- Frame chính với gradient
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    frame.BackgroundTransparency = 0.3
    
    local gradient = Instance.new("UIGradient", frame)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 80))
    }
    gradient.Rotation = 45
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 15)

    -- Logo
    local logo = Instance.new("ImageLabel", frame)
    logo.Size = UDim2.new(0, 150, 0, 150)
    logo.Position = UDim2.new(0.5, -75, 0.4, -75)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://75676578090181"
    logo.ImageTransparency = 1

    -- Text
    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(0.8, 0, 0, 100)
    textLabel.Position = UDim2.new(0.1, 0, 0.6, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "Nấm VIP\nTác giả: Nấm VN & Habato\nNgười test: Nấm Gamer"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBlack
    textLabel.TextTransparency = 1
    textLabel.TextStrokeTransparency = 0.7
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 150, 255)

    -- Hiệu ứng intro
    local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 0}):Play()
    TweenService:Create(logo, tweenInfo, {ImageTransparency = 0}):Play()
    TweenService:Create(textLabel, tweenInfo, {TextTransparency = 0}):Play()
    task.wait(2.5)
    TweenService:Create(frame, tweenInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(logo, tweenInfo, {ImageTransparency = 1}):Play()
    TweenService:Create(textLabel, tweenInfo, {TextTransparency = 1}):Play()
    task.wait(1.5)
    screenGui:Destroy()
end
pcall(introAnimation)

-- Âm thanh startup
local function playStartupSound()
    local sound = Instance.new("Sound", SoundService)
    sound.SoundId = "rbxassetid://8987546731"
    sound.Volume = 1.5
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end
pcall(playStartupSound)

-- Preload tài nguyên
pcall(function()
    ContentProvider:PreloadAsync({
        "rbxassetid://75676578090181",
        "rbxassetid://89326205091486",
        "rbxassetid://8987546731"
    })
end)

-- Kiểm tra hop server
local function checkServerChange()
    if getgenv().LastServerId ~= game.JobId and getgenv().ScriptLoaded then
        getgenv().LastServerId = game.JobId
        getgenv().ScriptLoaded = false
        detectGameAndAddTabs()
    end
end

-- Tạo menu chính với giao diện cải tiến
local function createMainGui()
    local screenGui = Instance.new("ScreenGui", PlayerGui)
    screenGui.Name = "MainGui"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false

    -- Frame chính
    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0, 500, 0, 400)
    frame.Position = UDim2.new(0.5, -250, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BackgroundTransparency = 0.1
    
    local gradient = Instance.new("UIGradient", frame)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 100))
    }
    gradient.Rotation = 45
    
    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 15)

    -- Title
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Nấm VIP - Script Hub"
    title.TextColor3 = Color3.fromRGB(200, 200, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBlack
    title.TextStrokeTransparency = 0.7
    title.TextStrokeColor3 = Color3.fromRGB(0, 150, 255)

    -- Minimize Button
    local minimizeButton = Instance.new("TextButton", frame)
    minimizeButton.Size = UDim2.new(0, 40, 0, 40)
    minimizeButton.Position = UDim2.new(1, -50, 0, 10)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    minimizeButton.Text = "—"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.TextScaled = true
    minimizeButton.Font = Enum.Font.GothamBold
    local buttonCorner = Instance.new("UICorner", minimizeButton)
    buttonCorner.CornerRadius = UDim.new(0, 8)
    
    -- Hiệu ứng hover cho minimize button
    minimizeButton.MouseEnter:Connect(function()
        TweenService:Create(minimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
    end)
    minimizeButton.MouseLeave:Connect(function()
        TweenService:Create(minimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
    end)

    -- Logic thu gọn
    local isMinimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 200, 0, 60)}):Play()
            minimizeButton.Text = "+"
        else
            TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 400)}):Play()
            minimizeButton.Text = "—"
        end
    end)

    return frame
end

-- Hàm thêm nút với giao diện cải tiến
local function addButton(tab, name, callback)
    local button = Instance.new("TextButton", tab)
    button.Size = UDim2.new(0.9, 0, 0, 50)
    button.Position = UDim2.new(0.05, 0, 0, #tab:GetChildren() * 60)
    button.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", button)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1.5
    
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
end

-- Hàm thêm nút sao chép
local function addCopyButton(tab, name, url)
    addButton(tab, name, function()
        pcall(function()
            setclipboard(url)
            StarterGui:SetCore("SendNotification", {
                Title = "Thông Báo",
                Text = "Đã sao chép link " .. name .. "!",
                Duration = 5
            })
        end)
    end)
end

-- Hàm thêm nút chạy script
local function addScriptButton(tab, name, url)
    addButton(tab, name, function()
        pcall(function()
            loadstring(game:HttpGet(url))()
            StarterGui:SetCore("SendNotification", {
                Title = "Thông Báo",
                Text = "Đã chạy script " .. name .. "!",
                Duration = 5
            })
        end)
    end)
end

-- Hàm phát hiện admin
local function checkAdmin()
    local adminIds = {[912348] = true, [120173604] = true}
    for _, player in pairs(Players:GetPlayers()) do
        if adminIds[player.UserId] or player:GetRoleInGroup(game.CreatorId) == "Admin" then
            StarterGui:SetCore("SendNotification", {
                Title = "Cảnh Báo",
                Text = "Phát hiện admin trong server!",
                Duration = 5
            })
        end
    end
    Players.PlayerAdded:Connect(function(player)
        if adminIds[player.UserId] or player:GetRoleInGroup(game.CreatorId) == "Admin" then
            StarterGui:SetCore("SendNotification", {
                Title = "Cảnh Báo",
                Text = "Phát hiện admin trong server!",
                Duration = 5
            })
        end
    end)
end
pcall(checkAdmin)

-- Hàm tạo các tab và nội dung
local function detectGameAndAddTabs()
    local mainFrame = createMainGui()

    -- Tab Blox Fruits
    local tab1 = Instance.new("ScrollingFrame", mainFrame)
    tab1.Size = UDim2.new(0.95, 0, 0.75, -10)
    tab1.Position = UDim2.new(0.025, 0, 0.2, 0)
    tab1.BackgroundTransparency = 1
    tab1.CanvasSize = UDim2.new(0, 0, 0, 0)
    tab1.ScrollBarThickness = 5
    local tab1Label = Instance.new("TextLabel", mainFrame)
    tab1Label.Size = UDim2.new(0, 100, 0, 30)
    tab1Label.Position = UDim2.new(0.05, 0, 0.15, 0)
    tab1Label.BackgroundTransparency = 1
    tab1Label.Text = "Blox Fruits"
    tab1Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab1Label.TextScaled = true
    tab1Label.Font = Enum.Font.GothamBold

    addScriptButton(tab1, "W-AZURE", "https://api.luarmor.net/files/v3/loaders/85e904ae1ff30824c1aa007fc7324f8f.lua")
    addScriptButton(tab1, "Quantum Hub", "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua")
    addScriptButton(tab1, "Tạo Server Mọi Game", "https://raw.githubusercontent.com/JoshzzAlteregooo/FreePrivateServer/refs/heads/main/UniversalFreePrivateServerByJoshzz")
    addScriptButton(tab1, "Giảm Lag", "https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua")
    addScriptButton(tab1, "Maru Premium Fake", "https://raw.githubusercontent.com/hnc-roblox/Free/refs/heads/main/MaruHubPremiumFake.HNC%20Roblox.lua")
    addScriptButton(tab1, "Gravity Hub", "https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua")

    -- Tab 99 Đêm
    local tab3 = Instance.new("ScrollingFrame", mainFrame)
    tab3.Size = UDim2.new(0.95, 0, 0.75, -10)
    tab3.Position = UDim2.new(0.025, 0, 0.2, 0)
    tab3.BackgroundTransparency = 1
    tab3.CanvasSize = UDim2.new(0, 0, 0, 0)
    tab3.ScrollBarThickness = 5
    tab3.Visible = false
    local tab3Label = Instance.new("TextLabel", mainFrame)
    tab3Label.Size = UDim2.new(0, 100, 0, 30)
    tab3Label.Position = UDim2.new(0.25, 0, 0.15, 0)
    tab3Label.BackgroundTransparency = 1
    tab3Label.Text = "99 Đêm"
    tab3Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab3Label.TextScaled = true
    tab3Label.Font = Enum.Font.GothamBold

    addScriptButton(tab3, "NATHUB", "https://get.nathub.xyz/loader")
    addScriptButton(tab3, "H4X", "https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua")
    addScriptButton(tab3, "Speed Hub", "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua")
    addScriptButton(tab3, "Hack Farm Kim Cương", "https://raw.githubusercontent.com/sleepyvill/script/refs/heads/main/99nights.lua")
    addScriptButton(tab3, "Skibidi", "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua")
    addScriptButton(tab3, "Ringta", "https://raw.githubusercontent.com/wefwef127382/99daysloader.github.io/refs/heads/main/ringta.lua")
    addScriptButton(tab3, "Thunder Kaitun", "https://raw.githubusercontent.com/NAVAAI098/Thunder-Hub/main/Kaitun.lua")

    -- Tab Hop Server
    local tabHop = Instance.new("ScrollingFrame", mainFrame)
    tabHop.Size = UDim2.new(0.95, 0, 0.75, -10)
    tabHop.Position = UDim2.new(0.025, 0, 0.2, 0)
    tabHop.BackgroundTransparency = 1
    tabHop.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabHop.ScrollBarThickness = 5
    tabHop.Visible = false
    local tabHopLabel = Instance.new("TextLabel", mainFrame)
    tabHopLabel.Size = UDim2.new(0, 100, 0, 30)
    tabHopLabel.Position = UDim2.new(0.45, 0, 0.15, 0)
    tabHopLabel.BackgroundTransparency = 1
    tabHopLabel.Text = "Hop Server"
    tabHopLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabHopLabel.TextScaled = true
    tabHopLabel.Font = Enum.Font.GothamBold

    addScriptButton(tabHop, "Teddy Hub", "https://raw.githubusercontent.com/Teddyseetink/Haidepzai/refs/heads/main/TEDDYHUB-FREEMIUM")
    addScriptButton(tabHop, "VisionX", "https://raw.githubusercontent.com/xSync-gg/VisionX/refs/heads/main/Server_Finder.lua")

    -- Tab Hệ Thống
    local tabSystem = Instance.new("ScrollingFrame", mainFrame)
    tabSystem.Size = UDim2.new(0.95, 0, 0.75, -10)
    tabSystem.Position = UDim2.new(0.025, 0, 0.2, 0)
    tabSystem.BackgroundTransparency = 1
    tabSystem.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabSystem.ScrollBarThickness = 5
    tabSystem.Visible = false
    local tabSystemLabel = Instance.new("TextLabel", mainFrame)
    tabSystemLabel.Size = UDim2.new(0, 100, 0, 30)
    tabSystemLabel.Position = UDim2.new(0.65, 0, 0.15, 0)
    tabSystemLabel.BackgroundTransparency = 1
    tabSystemLabel.Text = "Hệ Thống"
    tabSystemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabSystemLabel.TextScaled = true
    tabSystemLabel.Font = Enum.Font.GothamBold

    addCopyButton(tabSystem, "Sao Chép Key Speed Hub", "KfHLmNFnuaRmvbkQRwZGXDROXkxhdYAE")

    -- Điều hướng tab
    local tabs = {tab1, tab3, tabHop, tabSystem}
    local tabLabels = {tab1Label, tab3Label, tabHopLabel, tabSystemLabel}
    for i, label in ipairs(tabLabels) do
        label.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                for _, tab in ipairs(tabs) do
                    tab.Visible = false
                end
                tabs[i].Visible = true
                for _, lbl in ipairs(tabLabels) do
                    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
                label.TextColor3 = Color3.fromRGB(0, 150, 255)
            end
        end)
    end

    -- Cập nhật CanvasSize
    for _, tab in ipairs(tabs) do
        tab.CanvasSize = UDim2.new(0, 0, 0, #tab:GetChildren() * 60)
    end

    StarterGui:SetCore("SendNotification", {
        Title = "Thông Báo",
        Text = "Đã load tất cả tab!",
        Duration = 5
    })
end

-- Chỉ chạy script nếu chưa chạy trước đó
if not getgenv().ScriptLoaded then
    getgenv().ScriptLoaded = true
    detectGameAndAddTabs()
end

-- Theo dõi hop server
game:GetService("RunService").Heartbeat:Connect(checkServerChange)

-- Tải UI Redz V2
pcall(function()
    local success, result = pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua")))
    if not success then
        StarterGui:SetCore("SendNotification", {
            Title = "Lỗi",
            Text = "Không thể tải UI: " .. tostring(result),
            Duration = 10
        })
    end
end)
