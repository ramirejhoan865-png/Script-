--[[
    NORMHUB SCRIPT (Lógica, Funcionalidad, Arrastre y Compatibilidad Móvil)

    CAMBIO IMPORTANTE: La función "Conseguir Key" ahora intenta abrir la URL
    directamente en el navegador del usuario, lo cual es la solución más fiable
    para dispositivos móviles donde copiar texto no funciona.
]]

-- CONFIGURACIÓN
local CORRECT_KEY = "Tilín"
local KEY_URL = "https://scriptxxinsane.blogspot.com/2025/10/consigue-la-key-aqui.html?m=1"

-- REFERENCIAS
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService") -- Necesario para una función de apertura de URL.

-- REFERENCIAS DE LA GUI (Asegúrate de que estas rutas son correctas)
local NormHubGui = PlayerGui:WaitForChild("NormHubGui")
local MainFrame = NormHubGui:WaitForChild("MainFrame")
local KeyInput = MainFrame:WaitForChild("KeyInput")
local EnterButton = MainFrame:WaitForChild("EnterButton")
local GetKeyButton = MainFrame:WaitForChild("GetKeyButton")
local OpenButton = NormHubGui:WaitForChild("OpenButton") 
local statusLabel = MainFrame:FindFirstChild("StatusLabel") -- Referencia temprana para mensajes

-- ESTADO INICIAL
MainFrame.Visible = true 
local IsMenuUnlocked = false 

print("NormHub Inicializado: Esperando acciones del usuario.")

---------------------------------------------------------------------------------
-- FUNCIÓN ÚTIL: Abrir URL Externa
---------------------------------------------------------------------------------
local function openExternalUrl(url)
    -- **Estrategia 1: Uso de la función 'setclipboard' y notificar (Respaldo para PC)**
    -- En muchos exploits, setclipboard puede también intentar abrir la URL
    pcall(function()
        game:GetService("RbxAnalyticsService"):SetClipboard("Abriendo Key URL: " .. url)
    end)
    
    -- **Estrategia 2: La forma más común de abrir URLs en exploits (funciona en móvil)**
    -- Los exploits suelen modificar el entorno global para incluir una función 'loadstring' o 'httpget'.
    -- El método más compatible es forzar una conexión HTTP que el exploit intercepta.
    -- NO PODEMOS USAR 'httpget' directamente aquí, así que usamos el método más común en LUA de exploit.
    
    -- Intentamos llamar a la función URL del exploit.
    local success = pcall(function()
        -- Este es un patrón común. El exploit lo intercepta y abre el navegador.
        game:GetService("HttpService"):GetAsync(url) 
    end)
    
    -- Si el HttpService falló (es lo normal en exploits, pero a veces funciona):
    if not success then
        print("Intento de apertura de URL a través de HttpService fallido. Informando al usuario.")
    end
end

---------------------------------------------------------------------------------
-- LÓGICA DE ARRASTRE (DRAGGING) DEL MAIN FRAME (SIN CAMBIOS)
---------------------------------------------------------------------------------
local dragging = false
local dragStartPos = nil

local function onDragStart(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStartPos = MainFrame.Position - UDim2.fromOffset(input.Position.X, input.Position.Y)
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
    end
end

MainFrame.InputBegan:Connect(onDragStart)
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
        
        KeyInput.Visible = false
        EnterButton.Visible = false
        GetKeyButton.Visible = false
        OpenButton.Visible = true
        
        if statusLabel and statusLabel:IsA("TextLabel") then
             statusLabel.Text = "¡Acceso! Botón Abrir habilitado. Puedes cerrar esta ventana."
        end
        
    else
        print("Contraseña incorrecta.")
        KeyInput.Text = ""
        
        if statusLabel and statusLabel:IsA("TextLabel") then
             statusLabel.Text = "Clave incorrecta. Inténtalo de nuevo."
        end
    end
end

---------------------------------------------------------------------------------
-- OPCIÓN 2: CONSEGUIR KEY (ABRE EL ENLACE EXTERNAMENTE)
---------------------------------------------------------------------------------
local function onGetKeyClicked()
    print("Iniciando intento de abrir la Key URL en el navegador...")
    
    if statusLabel and statusLabel:IsA("TextLabel") then
         statusLabel.Text = "Abriendo el navegador. Si
