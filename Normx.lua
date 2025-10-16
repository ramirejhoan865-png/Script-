--!strict

-- CONFIGURACIÓN CLAVE Y URL
local CORRECT_KEY = "Tilín"
local KEY_URL = "https://scriptxxinsane.blogspot.com/2025/10/consigue-la-key-aqui.html?m=1"

-- OBTENCIÓN DE SERVICIOS Y JUGADOR (Versión para Executor)
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

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

-- ======================= CREACIÓN DE LA GUI (V7) =======================

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
TitleLabel.Text = "NormHub V7 (Móvil Copy Fix)"
TitleLabel.Size = UDim2.new(1, 0, 0.1, 0)
TitleLabel.BackgroundColor3 = Color3.new(0, 0.4, 0.8)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 24 
TitleLabel.Parent = MainFrame

-- Key Options Frame
local KeyOptionsFrame = Instance.new("Frame")
KeyOptionsFrame.Name = "KeyOptions"
KeyOptionsFrame.Size = UDim2.new(1
