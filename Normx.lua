--!strict

-- CONFIGURACIÓN CLAVE Y URL
local CORRECT_KEY = "Tilín"
local KEY_URL = "https://scriptxxinsane.blogspot.com/2025/10/consigue-la-key-aqui.html?m=1"

-- OBTENCIÓN DE SERVICIOS Y JUGADOR
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Esperar a que el PlayerGui esté disponible
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ESTADO
local isAuthenticated = false

-- ======================= LÓGICA DE UTILIDAD (Funciones, copiar, etc.) =======================

local function executeSpeedHack(speed: number)
    local Character = LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.WalkSpeed = speed
            StarterGui:SetCore("SendNotification", {Title = "NormHub", Text = "Velocidad: " .. tostring(speed), Duration = 3})
        end
    end
end

local function copyToClipboard(text: string)
    -- Lógica para copiar URL
    local tempTextBox = Instance.new("TextBox")
    tempTextBox.Text = text
    tempTextBox.Parent = PlayerGui
    tempTextBox:CaptureFocus()
    tempTextBox.TextEditable = true
    StarterGui:SetCore("SendNotification", {Title = "NormHub - Key", Text = "¡Enlace copiado! (Presiona Ctrl+C / Cmd+C).", Duration = 7})
    task.wait(0.1)
    tempTextBox:Destroy()
end

local function toggleFunctionsMenu()
    if isAuthenticated then
        local KeyOptions = PlayerGui.NormHubGui.NormHub_Frame.KeyOptions
        local FunctionsMenu = PlayerGui.NormHubGui.NormHub_Frame.FunctionsMenu
        
        -- Alternar: si las KeyOptions están visibles, muestra el FunctionsMenu
        if KeyOptions.Visible then
            KeyOptions.Visible = false
            FunctionsMenu.Visible = true
            StarterGui:SetCore("SendNotification", {Title = "NormHub", Text = "Menú de ejecución abierto.", Duration = 3})
        else
            -- Si el FunctionsMenu está visible, lo oculta y vuelve a KeyOptions (o cierra si prefieres)
            FunctionsMenu.Visible = false
            KeyOptions.Visible = true
            StarterGui:SetCore("SendNotification", {Title = "NormHub", Text = "Volviendo a opciones de Key.", Duration = 3})
        end
    else
        StarterGui:SetCore("SendNotification", {Title = "NormHub - Error", Text = "¡Debes ingresar la Key primero! (Opción 3)", Duration = 5})
    end
end

-- ======================= CREACIÓN DE LA GUI =======================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NormHubGui"
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "NormHub_Frame"
MainFrame.Size = UDim2.new(0.25, 0, 0.55, 0)
MainFrame.Position = UDim2.new(0.375, 0, 0.225, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderColor3 = Color3.new(0, 0.8, 1)
MainFrame.BorderSizePixel = 2
MainFrame.Visible = true -- VISIBLE SIEMPRE
MainFrame.Parent = ScreenGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Text = "NormHub"
TitleLabel.Size = UDim2.new(1, 0, 0.12, 0)
TitleLabel.BackgroundColor3 = Color3.new(0, 0.4, 0.8)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 24
TitleLabel.Parent = MainFrame

local KeyOptionsFrame = Instance.new("Frame")
KeyOptionsFrame.Name = "KeyOptions"
KeyOptionsFrame.Size = UDim2.new(1, 0, 0.88, 0)
KeyOptionsFrame.Position = UDim2.new(0, 0, 0.12, 0)
KeyOptionsFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
KeyOptionsFrame.Visible = true
KeyOptionsFrame.Parent = MainFrame

local KeyButtonLayout = Instance.new("UIListLayout")
KeyButtonLayout.FillDirection = Enum.FillDirection.Vertical
KeyButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
KeyButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
KeyButtonLayout.Padding = UDim.new(0, 10)
KeyButtonLayout.Parent = KeyOptionsFrame

local FunctionsMenu = Instance.new("Frame")
FunctionsMenu.Name = "FunctionsMenu"
FunctionsMenu.Size = UDim2.new(1, 0, 1, 0)
FunctionsMenu.Position = UDim2.new(0, 0, 0, 0)
FunctionsMenu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FunctionsMenu.Visible = false -- Oculto al inicio
FunctionsMenu.Parent = MainFrame

local FunctionsLayout = Instance.new("UIListLayout")
FunctionsLayout.FillDirection = Enum.FillDirection.Vertical
FunctionsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
FunctionsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
FunctionsLayout.Padding = UDim.new(0, 5)
FunctionsLayout.Parent = FunctionsMenu

local FunctionsTitle = Instance.new("TextLabel")
FunctionsTitle.Name = "MenuTitle"
FunctionsTitle.Text = "MENU DE EJECUCIÓN (DESBLOQUEADO)"
FunctionsTitle.Size = UDim2.new(1, 0, 0.1, 0)
FunctionsTitle.BackgroundColor3 = Color3.new(0.1, 0.3, 0.1)
FunctionsTitle.TextColor3 = Color3.new(1, 1, 1)
FunctionsTitle.Font = Enum.Font.SourceSansBold
FunctionsTitle.TextSize = 18
FunctionsTitle.Parent = FunctionsMenu

-- Función simplificada para crear botones
local function createButton(parentFrame: Instance, text: string, clickAction: (button: Instance) -> ())
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0.15, 0)
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.Parent = parentFrame
    button.MouseButton1Click:Connect(clickAction)
    return button
end

-- ======================= CONEXIÓN DE BOTONES =======================

-- Key Options (Opciones 1, 2, 3)
createButton(KeyOptionsFrame, "Opción 1: Entrar/Alternar Menú", toggleFunctionsMenu)

createButton(KeyOptionsFrame, "Opción 2: Conseguir Key", function()
    copyToClipboard(KEY_URL)
end)

createButton(KeyOptionsFrame, "Opción 3: Abrir/Ingresar Key", function(button)
    if isAuthenticated then return end

    local result = game:GetService("StarterGui"):GetCore("PromptUserClippingKey", {
        Title = "NormHub - Contraseña",
        Text = "Introduce la Key para activar el Hub:",
    })

    if result and result == CORRECT_KEY then
        isAuthenticated = true
        MainFrame.BorderColor3 = Color3.new(0, 1, 0)
        button.Text = "¡Key Correcta! 🎉"
        button.BackgroundColor3 = Color3.new(0, 0.6, 0)
        StarterGui:SetCore("SendNotification", {Title = "NormHub - Éxito", Text = "¡Key correcta! Usa Opción 1 para el menú de ejecución.", Duration = 7})
    elseif result then
        StarterGui:SetCore("SendNotification", {Title = "NormHub - Error", Text = "Key incorrecta. Inténtalo de nuevo.", Duration = 5})
    end
end)

-- Functions Menu
createButton(FunctionsMenu, "🚀 Super Velocidad", function() executeSpeedHack(50) end)
createButton(FunctionsMenu, "⬆️ Súper Salto", function() executeJumpHack(150) end)
createButton(FunctionsMenu, "↩️ Resetear Stats a Normal", function() executeSpeedHack(16); executeJumpHack(50) end)
createButton(FunctionsMenu, "⬅️ Volver a Opciones de Key", function() 
    FunctionsMenu.Visible = false
    KeyOptionsFrame.Visible = true
end)

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

-- Mostrar mensaje inicial
StarterGui:SetCore("SendNotification", {
    Title = "NormHub Cargado",
    Text = "El menú está visible. ¡Usa la Opción 3 para la Key!",
    Duration = 6,
})
