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

-- LÓGICA DE DRAG AND DROP (Para mover el Frame con el dedo)
local isDragging = false
local dragStart = Vector2.new(0, 0)
local frameStartPos = UDim2.new(0, 0, 0, 0)

-- ======================= LÓGICA DE UTILIDAD Y CORE =======================

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

-- Función para MOSTRAR la URL de la Key en un campo de texto (para móvil)
local function displayKeyUrl()
    -- Intenta usar el método más seguro (si no falla)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "URL de la Key (Copia manual)",
            Text = KEY_URL, -- Mostrar URL directamente
            Duration = 10,
        })
    end)
    -- Si el usuario necesita copiar la URL, simplemente debe verla
    StarterGui:SetCore("SendNotification", {
        Title = "NormHub - URL",
        Text = "URL: " .. KEY_URL .. " (Cópiala y úsala en tu navegador).",
        Duration = 10,
    })
end

local function toggleFunctionsMenu()
    if isAuthenticated then
        local MainFrame = PlayerGui.NormHubGui.NormHub_Frame
        local KeyOptions = MainFrame.KeyOptions
        local FunctionsMenu = MainFrame.FunctionsMenu
        
        -- Alternar: si las KeyOptions están visibles, muestra el FunctionsMenu
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

-- ======================= CREACIÓN DE LA GUI (V5) =======================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NormHubGui"
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "NormHub_Frame"
MainFrame.Size = UDim2.new(0.6, 0, 0.7, 0) -- Hacemos la GUI más grande para móvil
MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderColor3 = Color3.new(0, 0.8, 1)
MainFrame.BorderSizePixel = 2
MainFrame.Visible = true 
MainFrame.Parent = ScreenGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Text = "NormHub"
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.BackgroundColor3 = Color3.new(0, 0.4, 0.8)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 28 -- Más grande para móvil
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

-- Input de Contraseña (TextBox para móvil)
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

-- Función simplificada para crear botones (ajustados para móvil)
local function createButton(parentFrame: Instance, text: string, clickAction: (button: Instance) -> ())
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(0.9, 0, 0.12, 0) -- Un poco más grandes para el dedo
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
    if isAuthenticated then 
        StarterGui:SetCore("SendNotification", {Title = "NormHub", Text = "¡Ya autenticado!", Duration = 3})
        return 
    end

    if enteredKey == CORRECT_KEY then
        isAuthenticated = true
