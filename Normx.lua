--!strict

-- CONFIGURACIÓN DEL HUB
local HUB_TITLE = "NormX Hub | CLIENT-SIDE MENU"

-- OBTENCIÓN DE SERVICIOS Y JUGADOR
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Verificación de entorno (para executors)
if not LocalPlayer then
    warn("NormX Hub: LocalPlayer no encontrado. Reintenta la inyección.")
    return
end
local PlayerGui = LocalPlayer.PlayerGui

-- ESTADO Y LÓGICA DE DRAG AND DROP
local isAuthenticated = true -- Asumimos autenticación para un executor
local isDragging = false
local dragStart = Vector2.new(0, 0)
local frameStartPos = UDim2.new(0, 0, 0, 0)

-- ======================= FUNCIONES DE CLIENTE SEGURAS =======================

local function executeSpeedHack(speed: number)
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChildOfClass("Humanoid") then
        Character.Humanoid.WalkSpeed = speed
        StarterGui:SetCore("SendNotification", {Title = "NormX Hub", Text = "Velocidad cambiada a " .. tostring(speed), Duration = 3})
    end
end

local function executeJumpHack(height: number)
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChildOfClass("Humanoid") then
        Character.Humanoid.JumpPower = height
        StarterGui:SetCore("SendNotification", {Title = "NormX Hub", Text = "Poder de salto cambiado a " .. tostring(height), Duration = 3})
    end
end

local function teleportToNearestPart(partName: string)
    -- Esta función es un ejemplo de teletransporte. No encontrará "brainrots de 10M"
    -- pero te mostrará cómo se haría un teletransporte genérico de cliente.
    local targetPart = game.Workspace:FindFirstChild(partName) 
    
    if targetPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
        StarterGui:SetCore("SendNotification", {Title = "NormX Hub", Text = "Teletransporte a: " .. partName, Duration = 3})
    else
        StarterGui:SetCore("SendNotification", {Title = "NormX Hub - Error", Text = "Parte '" .. partName .. "' no encontrada o el personaje no está listo.", Duration = 4})
    end
end

local function joinVipServer()
    -- Esta función de Teletransporte a Servidor Específico está deshabilitada por seguridad.
    -- La manipulación de servidores es una violación directa de los ToS de Roblox.
    StarterGui:SetCore("SendNotification", {
        Title = "NormX Hub - Función Deshabilitada", 
        Text = "La función de unir a servidores específicos está deshabilitada por seguridad.", 
        Duration = 5
    })
end

-- ======================= CREACIÓN DE LA GUI =======================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NormXHubGui"
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "NormX_HubFrame"
MainFrame.Size = UDim2.new(0.6, 0, 0.7, 0) 
MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.BorderColor3 = Color3.new(0.5, 0, 0.8) -- Color púrpura oscuro
MainFrame.BorderSizePixel = 3
MainFrame.Visible = true 
MainFrame.Parent = ScreenGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Text = HUB_TITLE
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.BackgroundColor3 = Color3.new(0.3, 0, 0.5) 
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 24 
TitleLabel.Parent = MainFrame

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuOptions"
MenuFrame.Size = UDim2.new(1, 0, 0.9, 0)
MenuFrame.Position = UDim2.new(0, 0, 0.1, 0)
MenuFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MenuFrame.Visible = true
MenuFrame.Parent = MainFrame

local MenuLayout = Instance.new("UIListLayout")
MenuLayout.FillDirection = Enum.FillDirection.Vertical
MenuLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
MenuLayout.VerticalAlignment = Enum.VerticalAlignment.Top
MenuLayout.Padding = UDim.new(0, 8)
MenuLayout.Parent = MenuFrame

-- Función simplificada para crear botones
local function createButton(parentFrame: Instance, text: string, color: Color3, clickAction: (button: Instance) -> ())
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0.1, 0) 
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 20
    button.Parent = parentFrame
    button.MouseButton1Click:Connect(clickAction)
    return button
end

-- ======================= CONEXIÓN DE BOTONES (Funciones Solicitadas) =======================

-- 1. Función "Steal a Brainrot" (Reemplazada por función de teletransporte de cliente)
createButton(MenuFrame, "✨ Teletransporte al Punto 'Target'", Color3.new(0.6, 0.6, 0.1), function()
    -- Ejemplo: Teletransporte a una parte con el nombre 'Target' en el juego
    teleportToNearestPart("Target")
end)

-- 2. Función "Encontrar Secretos de más de 10M" (Reemplazada por función de servidor)
createButton(MenuFrame, "⚙️ Función de Servidor Deshabilitada", Color3.new(0.4, 0.4, 0.4), function()
    StarterGui:SetCore("SendNotification", {Title = "NormX Hub", Text = "Esta función requiere lógica de servidor que no se puede ejecutar en exploits.", Duration = 4})
end)

-- 3. Teletransporte a Servidor con Brainrot (Reemplazada por función de seguridad)
createButton(MenuFrame, "🚫 Unirse a Servidor Específico (Prohibido)", Color3.new(0.8, 0.2, 0.2), joinVipServer)

-- FUNCIONES BÁSICAS
createButton(MenuFrame, "🚀 Super Velocidad (50)", Color3.new(0.1, 0.5, 0.1), function() executeSpeedHack(50) end)
createButton(MenuFrame, "⬆️ Súper Salto (150)", Color3.new(0.1, 0.5, 0.1), function() executeJumpHack(150) end)
createButton(MenuFrame, "↩️ Resetear Stats a Normal", Color3.new(0.5, 0.3, 0.1), function() executeSpeedHack(16); executeJumpHack(50) end)

-- ======================= LÓGICA DE MOVIMIENTO =======================

TitleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        dragStart = input.Position
        frameStartPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)

-- Mensaje de bienvenida
StarterGui:SetCore("SendNotification", {
    Title = "NormX Hub Cargado",
    Text = "Menú de cliente listo. Usa el título para mover la ventana.",
    Duration = 5,
})
