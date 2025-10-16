--[[
    NORMHUB SCRIPT (Versión para Máxima Compatibilidad con Executors como Delta)

    - Se eliminan las funciones de red y portapapeles.
    - La opción "Conseguir Key" simplemente muestra la URL en el KeyInput para la copia manual.
]]

-- CONFIGURACIÓN
local CORRECT_KEY = "Tilín"
local KEY_URL = "https://scriptxxinsane.blogspot.com/2025/10/consigue-la-key-aqui.html?m=1"

-- REFERENCIAS
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- REFERENCIAS DE LA GUI (Asegúrate de que estas rutas son correctas)
local NormHubGui = PlayerGui:WaitForChild("NormHubGui")
local MainFrame = NormHubGui:WaitForChild("MainFrame")
local KeyInput = MainFrame:WaitForChild("KeyInput")
local EnterButton = MainFrame:WaitForChild("EnterButton")
local GetKeyButton = MainFrame:WaitForChild("GetKeyButton")
local OpenButton = NormHubGui:WaitForChild("OpenButton") 
local statusLabel = MainFrame:FindFirstChild("StatusLabel") -- Asume que tienes un TextLabel de estado

-- ESTADO INICIAL
MainFrame.Visible = true 
local IsMenuUnlocked = false 

print("NormHub Inicializado: Compatible con Delta. Esperando acciones del usuario.")

---------------------------------------------------------------------------------
-- LÓGICA DE ARRASTRE (DRAGGING) DEL MAIN FRAME (COMPATIBLE CON DELTA)
---------------------------------------------------------------------------------
local dragging = false
local dragStartPos = nil

local function onDragStart(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        -- Solo arrastrar si el usuario hace clic sobre el MainFrame (o un botón de arrastre)
        if input.Target == MainFrame or input.Target:IsDescendantOf(MainFrame) then
            dragging = true
            dragStartPos = MainFrame.Position - UDim2.fromOffset(input.Position.X, input.Position.Y)
            -- Subir ZIndex para que esté por encima de todo
            MainFrame.ZIndex = 5 
        end
    end
end

local function onDragMove(input)
    if dragging then
        local newPosition = UDim2.fromOffset(input.Position.X, input.Position.Y) + dragStartPos
        MainFrame.Position = newPosition
    end
end

local function onDragEnd(input)
    if dragging then
        dragging = false
        MainFrame.ZIndex = 1 -- Regresar ZIndex
    end
end

-- CONEXIÓN DEL ARRASTRE AL SERVICIO DE ENTRADA DEL USUARIO
UserInputService.InputBegan:Connect(onDragStart)
UserInputService.InputChanged:Connect(onDragMove)
UserInputService.InputEnded:Connect(onDragEnd)


---------------------------------------------------------------------------------
-- OPCIÓN 1: ENTRAR (Verificar Contraseña) (SIN CAMBIOS)
---------------------------------------------------------------------------------
local function onEnterClicked()
    local enteredKey = KeyInput.Text:trim()

    if enteredKey == CORRECT_KEY then
        print("¡Contraseña correcta! Acceso concedido.")
        IsMenuUnlocked = true
        
        -- Ocultar elementos de la key
        KeyInput.Visible = false
        EnterButton.
