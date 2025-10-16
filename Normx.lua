-- LocalScript: NormxHub_Client
-- Pega esto en StarterPlayerScripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local remote = ReplicatedStorage:WaitForChild("NormxHub_VerifyKey")

local KEY_URL = "https://scriptxxinsane.blogspot.com/2025/10/consigue-la-key-aqui.html?m=1"

-- Helper para crear objetos
local function new(class, props)
    local obj = Instance.new(class)
    for k,v in pairs(props or {}) do
        if k == "Parent" then obj.Parent = v else obj[k] = v end
    end
    return obj
end

-- Crear ScreenGui (si ya existiera, lo reemplaza)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NormxHub_UI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Fondo y panel
local bg = new("Frame", {Parent = screenGui, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 0.5, BackgroundColor3 = Color3.fromRGB(10,10,12)})
local panel = new("Frame", {Parent = bg, Size = UDim2.new(0,420,0,280), Position = UDim2.new(0.5,-210,0.5,-140), BackgroundColor3 = Color3.fromRGB(28,28,30)})
new("UICorner", {Parent = panel, CornerRadius = UDim.new(0,12)})
new("TextLabel", {Parent = panel, Size = UDim2.new(1,0,0,50), BackgroundTransparency = 1, Text = "normx hub", Font = Enum.Font.GothamBold, TextSize = 24, TextColor3 = Color3.fromRGB(230,230,230)})
new("TextLabel", {Parent = panel, Size = UDim2.new(1,0,0,24), Position = UDim2.new(0,0,0,50), BackgroundTransparency = 1, Text = "Selecciona una opción", Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(170,170,170)})

local buttonsHolder = new("Frame", {Parent = panel, Size = UDim2.new(1,-24,1,-94), Position = UDim2.new(0,12,0,82), BackgroundTransparency = 1})

local function makeButton(text, y)
    local b = new("TextButton", {Parent = buttonsHolder, Size = UDim2.new(1,0,0,44), Position = UDim2.new(0,0,0,(y-1)*54), BackgroundColor3 = Color3.fromRGB(43,43,46), Text = text, Font = Enum.Font.GothamSemibold, TextSize = 18, TextColor3 = Color3.fromRGB(245,245,245)})
    new("UICorner", {Parent = b, CornerRadius = UDim.new(0,8)})
    return b
end

local btnEntrar = makeButton("Entrar", 1)
local btnConseguir = makeButton("Conseguir key", 2)
local btnAbrir = makeButton("Abrir", 3)

local status = new("TextLabel", {Parent = panel, Size = UDim2.new(1,0,0,32), Position = UDim2.new(0,0,1,-32), BackgroundTransparency = 1, Text = "Estado: Esperando acción", Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(170,170,170)})

local function setStatus(txt)
    status.Text = "Estado: "..txt
end

-- Accion Entrar (puedes personalizar)
btnEntrar.MouseButton1Click:Connect(function()
    setStatus("Has entrado al Normx Hub.")
    -- Ejemplo visual
    btnEntrar.BackgroundColor3 = Color3.fromRGB(70,160,70)
    task.delay(0.25, function() if btnEntrar then btnEntrar.BackgroundColor3 = Color3.fromRGB(43,43,46) end end)
end)

-- Función que muestra dialog con link + botón copiar y cerrar
local function showCopyDialog()
    local dialog = new("Frame", {Parent = screenGui, Size = UDim2.new(0,540,0,150), Position = UDim2.new(0.5,-270,0.12,0), BackgroundColor3 = Color3.fromRGB(22,22,24)})
    new("UICorner", {Parent = dialog, CornerRadius = UDim.new(0,10)})
    new("TextLabel", {Parent = dialog, Size = UDim2.new(1,0,0,30), Position = UDim2.new(0,0,0,8), BackgroundTransparency = 1, Text = "Copia la URL para conseguir la key:", Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(230,230,230)})
    local box = new("TextBox", {Parent = dialog, Size = UDim2.new(1,-24,0,44), Position = UDim2.new(0,12,0,40), Text = KEY_URL, Font = Enum.Font.Gotham, TextSize = 14, ClearTextOnFocus = false, BackgroundColor3 = Color3.fromRGB(30,30,32), TextColor3 = Color3.fromRGB(240,240,240)})
    new("UICorner", {Parent = box, CornerRadius = UDim.new(0,6)})
    local copyBtn = new("TextButton", {Parent = dialog, Size = UDim2.new(0,120,0,36), Position = UDim2.new(0.5,-60,1,-50), Text = "Copiar", Font = Enum.Font.GothamBold, TextSize = 16})
    new("UICorner", {Parent = copyBtn, CornerRadius = UDim.new(0,8)})
    local closeBtn = new("TextButton", {Parent = dialog, Size = UDim2.new(0,84,0,28), Position = UDim2.new(1,-92,1,-40), Text = "Cerrar", Font = Enum.Font.GothamBold, TextSize = 14})
    new("UICorner", {Parent = closeBtn, CornerRadius = UDim.new(0,6)})

    -- Intentar copiar al portapapeles; si no se puede, seleccionar el texto para que el usuario copie manual.
    copyBtn.MouseButton1Click:Connect(function()
        local copied = false
        local ok = pcall(function() 
            if setclipboard then
                setclipboard(KEY_URL)
                copied = true
            end
        end)
        if copied then
            setStatus("Link copiado al portapapeles.")
            copyBtn.Text = "Copiado!"
            task.wait(1)
            dialog:Destroy()
        else
            -- Si no pudo copiar, seleccionamos el texto y avisamos
            box:CaptureFocus()
            -- Selecciona todo (esto solo cambia el cursor/selección en el TextBox)
            pcall(function() box.SelectionStart = 1; box.SelectionLength = #KEY_URL end)
            setStatus("No se pudo copiar automáticamente. Texto seleccionado; copia manualmente (Ctrl+C / mantener pulsado).")
        end
    end)

    closeBtn.MouseButton1Click:Connect(function() dialog:Destroy(); setStatus("Dialog cerrado.") end)
end

-- Boton Conseguir key: abrir dialog interno (no consola)
btnConseguir.MouseButton1Click:Connect(function()
    setStatus("Mostrando ventana para conseguir la key...")
    showCopyDialog()
end)

-- Secret panel (se revela si el servidor valida la key)
local secretPanel = new("Frame", {Parent = panel, Size = UDim2.new(0,1,0,0), Position = UDim2.new(0,0,1,0), BackgroundColor3 = Color3.fromRGB(60,60,64)})
new("UICorner", {Parent = secretPanel, CornerRadius = UDim.new(0,8)})
new("TextLabel", {Parent = secretPanel, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Text = "Acceso concedido. Bienvenido al Normx Hub!", Font = Enum.Font.Gotham, TextSize = 16, TextColor3 = Color3.fromRGB(240,240,240)})

local function openSecret()
    secretPanel:TweenSizeAndPosition(UDim2.new(1,0,0,80), UDim2.new(0,0,1,-80), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.35, true)
end
local function closeSecret()
    secretPanel:TweenSizeAndPosition(UDim2.new(0,1,0,0), UDim2.new(0,0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
end

secretPanel.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        closeSecret()
        setStatus("Panel secreto cerrado.")
    end
end)

-- Boton Abrir: pide la key y la verifica en el servidor
btnAbrir.MouseButton1Click:Connect(function()
    local prompt = new("Frame", {Parent = screenGui, Size = UDim2.new(0,380,0,140), Position = UDim2.new(0.5,-190,0.2,0), BackgroundColor3 = Color3.fromRGB(25,25,27)})
    new("UICorner", {Parent = prompt, CornerRadius = UDim.new(0,10)})
    new("TextLabel", {Parent = prompt, Size = UDim2.new(1,0,0,32), Position = UDim2.new(0,0,0,8), BackgroundTransparency = 1, Text = "Introduce la contraseña para abrir", Font = Enum.Font.Gotham, TextSize = 16, TextColor3 = Color3.fromRGB(230,230,230)})
    local input = new("TextBox", {Parent = prompt, Size = UDim2.new(1,-24,0,40), Position = UDim2.new(0,12,0,44), Text = "", Font = Enum.Font.Gotham, TextSize = 16, ClearTextOnFocus = false})
    input.PlaceholderText = "Escribe la contraseña..."
    local btnOk = new("TextButton", {Parent = prompt, Size = UDim2.new(0,120,0,36), Position = UDim2.new(0.5,-62,1,-44), Text = "Verificar", Font = Enum.Font.GothamBold, TextSize = 15})
    new("UICorner", {Parent = btnOk, CornerRadius = UDim.new(0,8)})

    btnOk.MouseButton1Click:Connect(function()
        local typed = tostring(input.Text or "")
        setStatus("Enviando la contraseña al servidor...")
        -- Enviar al servidor para validar
        remote:FireServer(typed)
        -- Esperamos la respuesta (la maneja el OnClientEvent)
    end)

    -- Manejo de la respuesta del servidor (solo para este prompt en curso)
    local conn
    conn = remote.OnClientEvent:Connect(function(result)
        if not prompt or not prompt.Parent then
            if conn then conn:Disconnect() end
            return
        end
        if result == true then
            setStatus("Contraseña correcta. Abriendo...")
            openSecret()
            prompt:Destroy()
            if conn then conn:Disconnect() end
        else
            setStatus("Contraseña incorrecta.")
            input.Text = ""
            input:CaptureFocus()
            -- feedback visual
            task.spawn(function()
                local orig = prompt.BackgroundColor3
                prompt.BackgroundColor3 = Color3.fromRGB(120,40,40)
                task.wait(0.25)
                if prompt then prompt.BackgroundColor3 = orig end
            end)
        end
    end)
end)
