--!strict

-- CONFIGURACIÓN CLAVE Y URL
local CORRECT_KEY = "Tilín"
local KEY_URL = "https://scriptxxinsane.blogspot.com/2025/10/consigue-la-key-aqui.html?m=1"

-- OBTENCIÓN DE SERVICIOS Y JUGADOR (Versión para Executor)
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Si el script se ejecuta demasiado pronto, puede que LocalPlayer sea nil.
-- Usamos 'pcall' y comprobamos, pero en un executor, LocalPlayer casi siempre existe.
if not LocalPlayer then
    warn("NormHub: LocalPlayer no encontrado. Intenta reinyectar el script.")
    return
end

local PlayerGui = LocalPlayer.PlayerGui

-- ESTADO
local isAuthenticated = false
local isDragging = false
local dragStart = Vector2.new(0, 0)
local frameStartPos = UDim2.new(0, 0, 0, 0)

-- ======================= LÓGICA DE UTILIDAD Y CORE =======================

local function executeSpeedHack(speed: number)
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChildOfClass("Humanoid") then
        Character.Humanoid.WalkSpeed = speed
        StarterGui:SetCore("SendNotification", {Title = "NormHub", Text = "Velocidad: " .. tostring(speed), Duration = 3})
    end
end

local function displayKeyUrl()
    StarterGui:SetCore("SendNotification", {
        Title = "NormHub - URL (Copia manual)",
        Text = "URL: " .. KEY_URL .. " (Cópiala y úsala en tu navegador).",
        Duration = 10,
    })
end

local function toggleFunctionsMenu()
    local MainFrame = PlayerGui:FindFirstChild("NormHubGui"):FindFirstChild("NormHub_Frame")
    if not MainFrame then return end
    
    local KeyOptions = MainFrame:FindFirstChild("KeyOptions")
    local FunctionsMenu = MainFrame:FindFirstChild("FunctionsMenu")
    
    if isAuthenticated then
        if KeyOptions.Visible then
            KeyOptions.Visible = false
            FunctionsMenu.Visible = true
            StarterGui:SetCore("SendNotification", {Title = "NormHub", Text = "Menú de ejecución abierto.", Duration = 3})
        else
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
MainFrame.Size = UDim2.new(0.6, 0, 0.7, 0) 
MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderColor3 = Color3.new(0, 0.8, 1)
MainFrame.BorderSizePixel = 2
MainFrame.Visible = true 
MainFrame.Parent = ScreenGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Text = "NormHub V6 (Executor Ready)"
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.BackgroundColor3 = Color3.new(0, 0.4, 0.8)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 24 
TitleLabel.Parent = MainFrame

-- Key Options Frame
local KeyOptionsFrame = Instance.new("Frame")
KeyOptionsFrame.Name = "KeyOptions"
KeyOptionsFrame.Size = UDim2.new(1, 0, 0.9, 0)
KeyOptionsFrame.Position = UDim2.new(0, 0, 0.1, 0)
KeyOptionsFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
KeyOptionsFrame.Visible = true
KeyOptionsFrame.Parent = MainFrame

local KeyButtonLayout = Instance.new("UIListLayout")
KeyButtonLayout.FillDirection = Enum.FillDirection.Vertical
KeyButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
KeyButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Top
KeyButtonLayout.Padding = UDim.new(0, 10)
KeyButtonLayout.Parent = KeyOptionsFrame

-- Input de Contraseña
local KeyInputBox = Instance.new("TextBox")
KeyInputBox.Name = "KeyInput"
KeyInputBox.PlaceholderText = "Escribe la Key aquí: Tilín"
KeyInputBox.Size = UDim2.new(0.9, 0, 0.1, 0)
KeyInputBox.Text = ""
KeyInputBox.TextSize = 20
KeyInputBox.TextWrapped = true
KeyInputBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
KeyInputBox.TextColor3 = Color3.new(1, 1, 1)
KeyInputBox.Font = Enum.Font.SourceSans
KeyInputBox.Parent = KeyOptionsFrame

-- Marco del Menú de Funciones
local FunctionsMenu = Instance.new("Frame")
FunctionsMenu.Name = "FunctionsMenu"
FunctionsMenu.Size = UDim2.new(1, 0, 1, 0)
FunctionsMenu.Position = UDim2.new(0, 0, 0, 0)
FunctionsMenu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FunctionsMenu.Visible = false
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
FunctionsTitle.TextSize = 22
FunctionsTitle.Parent = FunctionsMenu

-- Función simplificada para crear botones
local function createButton(parentFrame: Instance, text: string, clickAction: (button: Instance) -> ())
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0.12, 0) 
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 20
    button.Parent = parentFrame
    button.MouseButton1Click:Connect(clickAction)
    return button
end

-- ======================= CONEXIÓN DE BOTONES =======================

-- Key Options (Opciones 1, 2, 3)
createButton(KeyOptionsFrame, "Opción 1: Entrar/Alternar Menú", toggleFunctionsMenu)

createButton(KeyOptionsFrame, "Opción 2: Mostrar URL de Key", displayKeyUrl)

createButton(KeyOptionsFrame, "Opción 3: Verificar Key Ingresada", function()
    local enteredKey = KeyInputBox.Text
    if isAuthenticated then return end

    if enteredKey == CORRECT_KEY then
        isAuthenticated = true
        MainFrame.BorderColor3 = Color3.new(0, 1, 0)
        KeyInputBox.PlaceholderText = "¡Key Correcta! 🎉"
        KeyInputBox.Text = "" 
        StarterGui:SetCore("SendNotification", {Title = "NormHub - Éxito", Text = "¡Key correcta! Usa Opción 1 para el menú de ejecución.", Duration = 7})
    else
        KeyInputBox.PlaceholderText = "Key incorrecta. Inténtalo de nuevo."
        StarterGui:SetCore("SendNotification", {Title = "NormHub - Error", Text = "Key incorrecta. Inténtalo de nuevo.", Duration = 5})
    end
end)

-- Functions Menu
createButton(FunctionsMenu, "🚀 Super Velocidad", function() executeSpeedHack(50) end)
createButton(FunctionsMenu, "⬆️ Súper Salto", function() 
    local Character = LocalPlayer.Character
    if Character and Character:FindFirstChildOfClass("Humanoid") then
        Character.Humanoid.JumpPower = 150
        StarterGui:SetCore("SendNotification", {Title = "NormHub", Text = "Súper Salto activado.", Duration = 3})
    end
end)
createButton(FunctionsMenu, "↩️ Resetear Stats a Normal", function() executeSpeedHack(16); LocalPlayer.Character.Humanoid.JumpPower = 50; StarterGui:SetCore("SendNotification", {Title = "NormHub", Text = "Stats reseteadas.", Duration = 3}) end)
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

-- Mensaje de bienvenida
StarterGui:SetCore("SendNotification", {
    Title = "NormHub V6 (Delta/Executor)",
    Text = "Ingresa la Key 'Tilín' en el cuadro de texto y usa Opción 3 para autenticar.",
    Duration = 8,
})
