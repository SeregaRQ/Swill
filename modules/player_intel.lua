-- SWILL Player Intel Module
-- Сбор информации об игроках

local PlayerIntel = {}

function PlayerIntel:GetAllPlayersData()
    local players = game:GetService("Players"):GetPlayers()
    local playerData = {}
    
    for _, player in pairs(players) do
        local data = self:GetPlayerData(player)
        table.insert(playerData, data)
    end
    
    -- Сортировка по дистанции
    table.sort(playerData, function(a, b)
        return a.Distance < b.Distance
    end)
    
    return playerData
end

function PlayerIntel:GetPlayerData(player)
    local character = player.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    local data = {
        Name = player.Name,
        UserId = player.UserId,
        AccountAge = player.AccountAge,
        Team = player.Team and player.Team.Name or "No Team",
        Health = humanoid and math.floor(humanoid.Health) or 0,
        MaxHealth = humanoid and math.floor(humanoid.MaxHealth) or 0,
        WalkSpeed = humanoid and math.floor(humanoid.WalkSpeed) or 0,
        JumpPower = humanoid and math.floor(humanoid.JumpPower) or 0,
        Distance = 0,
        Tools = 0,
        Status = "Unknown"
    }
    
    -- Расчет дистанции
    local localPlayer = game:GetService("Players").LocalPlayer
    local localCharacter = localPlayer.Character
    local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
    
    if rootPart and localRoot then
        data.Distance = math.floor((rootPart.Position - localRoot.Position).Magnitude)
    end
    
    -- Подсчет инструментов
    if character then
        local tools = 0
        for _, item in pairs(character:GetChildren()) do
            if item:IsA("Tool") then
                tools = tools + 1
            end
        end
        data.Tools = tools
    end
    
    -- Определение статуса
    if not character then
        data.Status = "RESPAWNING"
    elseif humanoid then
        data.Status = humanoid.Health > 0 and "ALIVE" or "DEAD"
    end
    
    return data
end

return PlayerIntel