-- SWILL Suite Loader
-- Основной загрузчик всех модулей

local SWILL = {
    Version = "3.1",
    Modules = {},
    Config = {
        AutoLoadGUI = true,
        EnableLogging = true
    }
}

-- Загрузка модулей
function SWILL:LoadModule(name)
    local module = self.Modules[name]
    if not module then
        if self.Config.EnableLogging then
            warn("[SWILL] Loading module: " .. name)
        end
        -- Здесь будет загрузка из соответствующих файлов
        -- В Executor это будет через include или require
    end
    return module
end

-- Инициализация всех модулей
function SWILL:Initialize()
    -- Загрузка основных модулей
    self.Modules.Core = self:LoadModule("core")
    self.Modules.GUI = self:LoadModule("gui") 
    self.Modules.PlayerIntel = self:LoadModule("player_intel")
    self.Modules.MovementTracker = self:LoadModule("movement_tracker")
    self.Modules.ObjectScanner = self:LoadModule("object_scanner")
    self.Modules.SettingsManager = self:LoadModule("settings_manager")
    
    -- Инициализация ядра
    if self.Modules.Core then
        self.Modules.Core:Initialize(self)
    end
    
    -- Автозагрузка GUI
    if self.Config.AutoLoadGUI and self.Modules.GUI then
        self.Modules.GUI:CreateMainInterface()
    end
    
    print("[SWILL] Suite v" .. self.Version .. " loaded successfully")
    print("[SWILL] Modules: " .. table.concat(self:GetLoadedModules(), ", "))
end

-- Получение списка загруженных модулей
function SWILL:GetLoadedModules()
    local loaded = {}
    for name, module in pairs(self.Modules) do
        if module then
            table.insert(loaded, name)
        end
    end
    return loaded
end

-- Глобальный доступ
getgenv().SWILL = SWILL

-- Автозапуск
spawn(function()
    SWILL:Initialize()
end)

return SWILL