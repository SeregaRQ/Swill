-- SWILL Core Module
-- Основная логика и управление

local Core = {
    Initialized = false,
    Services = {},
    Events = {}
}

function Core:Initialize(main)
    self.Main = main
    self.Services = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"),
        Workspace = game:GetService("Workspace"),
        Lighting = game:GetService("Lighting"),
        TeleportService = game:GetService("TeleportService")
    }
    
    self:SetupEvents()
    self.Initialized = true
    
    return true
end

function Core:SetupEvents()
    -- Обработчик изменения игроков
    self.Services.Players.PlayerAdded:Connect(function(player)
        self:OnPlayerAdded(player)
    end)
    
    self.Services.Players.PlayerRemoving:Connect(function(player)
        self:OnPlayerRemoved(player)
    end)
end

function Core:OnPlayerAdded(player)
    if self.Main.Config.EnableLogging then
        print("[SWILL] Player joined: " .. player.Name)
    end
end

function Core:OnPlayerRemoved(player)
    if self.Main.Config.EnableLogging then
        print("[SWILL] Player left: " .. player.Name)
    end
end

function Core:GetLocalPlayer()
    return self.Services.Players.LocalPlayer
end

function Core:GetLocalCharacter()
    local player = self:GetLocalPlayer()
    return player and player.Character
end

function Core:SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("[SWILL] Error in safe call: " .. tostring(result))
    end
    return success, result
end

return Core