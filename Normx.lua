btnConseguir.MouseButton1Click:Connect(function()
    setStatus("Intentando abrir la página de la key...")

    local function showCopyUI()
        -- Cuadro con el link y botón copiar
        local dialog = Instance.new("Frame")
        dialog.Size = UDim2.new(0, 540, 0, 150)
        dialog.Position = UDim2.new(0.5, -270, 0.12, 0)
        dialog.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
        dialog.Parent = screenGui
        Instance.new("UICorner", {Parent = dialog, CornerRadius = UDim.new(0, 10)})

        local title = Instance.new("TextLabel")
        title.Parent = dialog
        title.Size = UDim2.new(1, 0, 0, 30)
        title.Position = UDim2.new(0, 0, 0, 8)
        title.BackgroundTransparency = 1
        title.Text = "Copia la URL manualmente para conseguir tu key:"
        title.Font = Enum.Font.Gotham
        title.TextSize = 14
        title.TextColor3 = Color3.fromRGB(230, 230, 230)

        local box = Instance.new("TextBox")
        box.Parent = dialog
        box.Size = UDim2.new(1, -24, 0, 44)
        box.Position = UDim2.new(0, 12, 0, 40)
        box.Text = KEY_URL
        box.Font = Enum.Font.Gotham
        box.TextSize = 14
        box.ClearTextOnFocus = false
        box.TextColor3 = Color3.fromRGB(240,240,240)
        box.BackgroundColor3 = Color3.fromRGB(30,30,32)
        Instance.new("UICorner", {Parent = box, CornerRadius = UDim.new(0, 6)})

        local copyBtn = Instance.new("TextButton")
        copyBtn.Parent = dialog
        copyBtn.Size = UDim2.new(0, 120, 0, 36)
        copyBtn.Position = UDim2.new(0.5, -60, 1, -50)
        copyBtn.Text = "Copiar"
        copyBtn.Font = Enum.Font.GothamBold
        copyBtn.TextSize = 16
        copyBtn.BackgroundColor3 = Color3.fromRGB(45, 120, 250)
        copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", {Parent = copyBtn, CornerRadius = UDim.new(0, 8)})

        copyBtn.MouseButton1Click:Connect(function()
            if setclipboard then
                setclipboard(KEY_URL)
                setStatus("✅ Link copiado al portapapeles.")
                copyBtn.Text = "Copiado!"
                task.wait(1)
                dialog:Destroy()
            else
                setStatus("❌ No se pudo copiar automáticamente.")
            end
        end)
    end

    -- Intentar abrir navegador o fallback a copiar
    local success, err = pcall(function()
        if syn and syn.request then
            syn.request({Url = KEY_URL, Method = "GET"})
            setStatus("Abriendo la página en tu navegador...")
        elseif request then
            request({Url = KEY_URL, Method = "GET"})
            setStatus("Abriendo la página en tu navegador...")
        else
            showCopyUI()
        end
    end)

    if not success then
        setStatus("Error al intentar abrir el link.")
        showCopyUI()
    end
end)
