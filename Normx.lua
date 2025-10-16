--!strict

-- CONFIGURACIÓN DEL HUB
local HUB_TITLE = "NormX Hub | OPCIÓN ÚNICA"
local MAIN_BUTTON_TEXT = "🚀 Unirse a Server con Brainrot > 10M (TP Interno)"

-- OBTENCIÓN DE SERVICIOS Y JUGADOR
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    warn("NormX Hub: LocalPlayer no encontrado. Reintenta la inyección.")
    return
end
local PlayerGui = LocalPlayer.PlayerGui

-- ESTADO Y LÓGICA DE DRAG AND DROP
local isDragging = false
local dragStart = Vector2.new(0, 0)
local frameStartPos = UDim2.new(0, 0, 0, 0)

-- ======================= FUNCIÓN PRINCIPAL (Teletransporte Interno) =======================

local function teleportToSecretArea()
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        -- Coordenadas de ejemplo que simulan el escondite de la "Gran Combinación"
        -- AJUSTA ESTAS COORDENADAS SI CONOCES UNA UBICACIÓN SECRETA EN EL JUEGO.
        local SECRET_COORDS = CFrame.new(2500, 100, -500) 
        
        Character.HumanoidRootPart.CFrame = SECRET_COORDS
        
        StarterGui:SetCore("SendNotification", {
            Title = "NormX Hub - TELETRANSPORTE", 
            Text = "Enviado a coordenadas (2500, 100, -500). ¡Busca la Gran Combinación!", 
            Duration = 6
        })
    else
        StarterGui:SetCore("SendNotification", {Title = "NormX Hub - Error", Text = "Personaje no cargado para el teletransporte.", Duration = 4})
    end
end

-- ======================= CREACIÓN DE LA GUI (OPCIÓN ÚNICA) =======================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NormXHubGui"
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "NormX_HubFrame"
MainFrame.Size = UDim2.new(0.6, 0, 0.3, 0) -- Frame más pequeño para una opción
MainFrame.Position = UDim2.new(0.2, 0, 0.35, 0)
MainFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
MainFrame.BorderColor3 = Color3.new(0.8, 0.2, 0.2) -- Rojo
MainFrame.BorderSizePixel = 3
MainFrame.Visible = true 
MainFrame.Parent = ScreenGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Text = HUB_TITLE
TitleLabel.Size = UDim2.new(1, 0, 0.25, 0)
TitleLabel.BackgroundColor3 = Color3.new(0.5, 0, 0) 
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 24 
TitleLabel.Parent = MainFrame

local MenuFrame = Instance.new("Frame")
MenuFrame.Name = "MenuOptions"
MenuFrame.Size = UDim2.new(1, 0, 0.75, 0)
MenuFrame.Position = UDim2.new(0, 0, 0.25, 0)
MenuFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MenuFrame.Visible = true
MenuFrame.Parent = MainFrame

local MenuLayout = Instance.new("UIListLayout")
MenuLayout.FillDirection = Enum.FillDirection.Vertical
MenuLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
MenuLayout.VerticalAlignment = Enum.VerticalAlignment.Center
MenuLayout.Parent = MenuFrame

-- BOTÓN DE OPCIÓN ÚNICA
local mainButton = Instance.new("TextButton")
mainButton.Text = MAIN_BUTTON_TEXT
mainButton.Size = UDim2.new(0.9, 0, 0.5, 0) 
mainButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0.1)
mainButton.TextColor3 = Color3.new(1, 1, 1)
mainButton.Font = Enum.Font.SourceSansBold
mainButton.TextSize = 22
mainButton.Parent = MenuFrame

-- CONEXIÓN AL TELETRANSPORTE INTERNO
mainButton.MouseButton1Click:Connect(teleportToSecretArea)

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
    Title = "NormX Hub V10 - Finalizado",
    Text = "Botón único. ¡Buena suerte encontrando la Gran Combinación!",
    Duration = 5,
})
