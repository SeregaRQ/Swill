-- SWILL GUI Module
-- Управление интерфейсом

local GUI = {
    Interface = nil,
    CurrentTab = "movement",
    IsMinimized = false
}

function GUI:CreateMainInterface()
    if self.Interface then
        self.Interface:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SWILLMainGUI"
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Основной фрейм
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 650, 0, 550)
    mainFrame.Position = UDim2.new(0, 100, 0, 100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Заголовок
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 25)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleBar.Active = true
    titleBar.Draggable = true
    titleBar.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -80, 1, 0)
    title.Position = UDim2.new(0, 5, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 50, 50)
    title.Text = "SWILL ROBLOX SUITE v3.1"
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.Code
    title.Parent = titleBar
    
    -- Кнопки управления
    self:CreateControlButtons(titleBar, mainFrame)
    self:CreateTabSystem(mainFrame)
    self:CreateContentArea(mainFrame)
    
    self.Interface = screenGui
    return screenGui
end

function GUI:CreateControlButtons(titleBar, mainFrame)
    local buttons = {
        {Name = "Minimize", Text = "_", Color = Color3.fromRGB(255, 150, 50), Position = UDim2.new(1, -50, 0, 0)},
        {Name = "Close", Text = "X", Color = Color3.fromRGB(255, 50, 50), Position = UDim2.new(1, -25, 0, 0)}
    }
    
    for _, btnInfo in pairs(buttons) do
        local button = Instance.new("TextButton")
        button.Name = btnInfo.Name .. "Button"
        button.Size = UDim2.new(0, 25, 0, 25)
        button.Position = btnInfo.Position
        button.BackgroundColor3 = btnInfo.Color
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Text = btnInfo.Text
        button.Font = Enum.Font.Code
        button.Parent = titleBar
        
        if btnInfo.Name == "Minimize" then
            button.MouseButton1Click:Connect(function()
                self:ToggleMinimize(mainFrame)
            end)
        elseif btnInfo.Name == "Close" then
            button.MouseButton1Click:Connect(function()
                self.Interface:Destroy()
                self.Interface = nil
            end)
        end
    end
end

function GUI:ToggleMinimize(mainFrame)
    self.IsMinimized = not self.IsMinimized
    if self.IsMinimized then
        mainFrame.Size = UDim2.new(0, 650, 0, 60)
    else
        mainFrame.Size = UDim2.new(0, 650, 0, 550)
    end
end

function GUI:CreateTabSystem(mainFrame)
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = "TabFrame"
    tabFrame.Size = UDim2.new(1, 0, 0, 35)
    tabFrame.Position = UDim2.new(0, 0, 0, 25)
    tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabFrame.Parent = mainFrame
    
    local tabs = {"Movement", "Players", "Objects", "Settings"}
    
    for i, tabName in pairs(tabs) do
        local tab = Instance.new("TextButton")
        tab.Name = tabName .. "Tab"
        tab.Size = UDim2.new(1 / #tabs, 0, 1, 0)
        tab.Position = UDim2.new((i-1) / #tabs, 0, 0, 0)
        tab.BackgroundColor3 = i == 1 and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)
        tab.TextColor3 = Color3.fromRGB(255, 255, 255)
        tab.Text = tabName:upper()
        tab.Font = Enum.Font.Code
        tab.Parent = tabFrame
        
        tab.MouseButton1Click:Connect(function()
            self:SwitchTab(tabName:lower())
        end)
    end
end

function GUI:CreateContentArea(mainFrame)
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -10, 1, -100)
    contentFrame.Position = UDim2.new(0, 5, 0, 65)
    contentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    contentFrame.Parent = mainFrame
    
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ContentScroll"
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 8
    scrollFrame.Parent = contentFrame
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "ContentLabel"
    contentLabel.Size = UDim2.new(1, -10, 1, 0)
    contentLabel.Position = UDim2.new(0, 5, 0, 5)
    contentLabel.BackgroundTransparency = 1
    contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.TextSize = 11
    contentLabel.Font = Enum.Font.Code
    contentLabel.Text = "SWILL Interface Ready"
    contentLabel.Parent = scrollFrame
    
    self.ContentLabel = contentLabel
    self.ScrollFrame = scrollFrame
end

function GUI:SwitchTab(tabName)
    self.CurrentTab = tabName
    self:UpdateContent()
end

function GUI:UpdateContent()
    if not self.ContentLabel then return end
    
    local content = "=== " .. self.CurrentTab:upper() .. " DATA ===\n\n"
    
    -- Здесь будет обновление контента в зависимости от вкладки
    if self.CurrentTab == "movement" then
        content = content .. "Movement data will be displayed here\n"
    elseif self.CurrentTab == "players" then
        content = content .. "Player information will be displayed here\n"
    elseif self.CurrentTab == "objects" then
        content = content .. "Object data will be displayed here\n"
    elseif self.CurrentTab == "settings" then
        content = content .. "Settings panel will be displayed here\n"
    end
    
    self.ContentLabel.Text = content
    self.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, self.ContentLabel.TextBounds.Y + 20)
end

return GUI