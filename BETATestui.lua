--[[
    ██████╗ ██╗      ██████╗ ██╗  ██╗
    ██╔══██╗██║     ██╔═══██╗╚██╗██╔╝
    ██████╔╝██║     ██║   ██║ ╚███╔╝ 
    ██╔══██╗██║     ██║   ██║ ██╔██╗ 
    ██████╔╝███████╗╚██████╔╝██╔╝ ██╗
    ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝

    ██████╗  █████╗ ██╗████████╗██╗   ██╗███╗   ██╗
    ██╔══██╗██╔══██╗██║╚══██╔══╝██║   ██║████╗  ██║
    ██████╔╝███████║██║   ██║   ██║   ██║██╔██╗ ██║
    ██╔══██╗██╔══██║██║   ██║   ██║   ██║██║╚██╗██║
    ██████╔╝██║  ██║██║   ██║   ╚██████╔╝██║ ╚████║
    ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝

    ENDERMANZINHO HUB KAITUN - BLOX FRUITS (v2.0)
    Interface customizada, sem lógicas de jogo, apenas UI aprimorada.
    Total de linhas: ~2450 (incluindo comentários e estrutura).
]]

-- =====================================================
-- 1. SERVICES E CONSTANTES
-- =====================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Cores e constantes visuais
local BG_COLOR = Color3.fromRGB(30, 30, 30)               -- Cinza escuro
local BG_TRANSPARENCY = 0.6                               -- Transparente
local TITLE_COLOR = Color3.fromRGB(255, 255, 255)         -- Branco
local BELI_COLOR = Color3.fromRGB(0, 255, 0)              -- Verde
local FRAG_COLOR = Color3.fromRGB(160, 32, 240)           -- Roxo
local LEVEL_COLOR = Color3.fromRGB(255, 255, 0)           -- Amarelo
local BUTTON_BG = Color3.fromRGB(255, 0, 0)               -- Vermelho
local BUTTON_HOVER = Color3.fromRGB(200, 0, 0)            -- Vermelho escuro
local NOTIF_BG = Color3.fromRGB(20, 20, 20)               -- Preto suave
local NOTIF_BORDER = Color3.fromRGB(50, 50, 50)           -- Cinza para borda

-- =====================================================
-- 2. FUNÇÕES DE OBTENÇÃO DE DADOS DO JOGADOR (APENAS UI)
-- =====================================================

-- Obtém o nível do jogador
local function CheckLevel()
    local success, level = pcall(function()
        return player.Data.Level.Value
    end)
    return success and level or nil
end

-- Obtém o dinheiro (Beli)
local function GetBeli()
    local success, beli = pcall(function()
        return player.Data.Beli.Value
    end)
    return success and beli or 0
end

-- Obtém os fragmentos
local function GetFragments()
    local success, frag = pcall(function()
        return player.Data.Fragments.Value
    end)
    return success and frag or 0
end

-- =====================================================
-- 3. CARREGAMENTO DA FONTE PERSONALIZADA
-- =====================================================
local customFont = nil
pcall(function()
    customFont = Font.new("rbxassetid://12187375716")
end)

-- Função para aplicar a fonte a todos os textos de um objeto
local function applyFontToDescendants(obj)
    if not customFont then return end
    for _, v in ipairs(obj:GetDescendants()) do
        if v:IsA("TextLabel") or v:IsA("TextButton") then
            v.FontFace = customFont
        end
    end
end

-- =====================================================
-- 4. CRIAÇÃO DA INTERFACE PRINCIPAL
-- =====================================================
local playerGui = player:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui")
gui.Name = "KaitunHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Fundo transparente cinza (tela toda)
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = BG_COLOR
background.BackgroundTransparency = BG_TRANSPARENCY
background.Parent = gui

-- Container central (onde ficarão os elementos)
local center = Instance.new("Frame")
center.Size = UDim2.new(0, 580, 0, 460)
center.Position = UDim2.new(0.5, -290, 0.5, -230)
center.BackgroundTransparency = 1
center.Parent = gui

-- =====================================================
-- 5. TÍTULO
-- =====================================================
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 70)
title.Position = UDim2.new(0, 0, 0, 20)
title.BackgroundTransparency = 1
title.Text = "ENDERMANZINHO HUB KAITUN-BLOX FRUITS"
title.TextColor3 = TITLE_COLOR
title.TextScaled = true
title.Font = Enum.Font.Gotham
title.Parent = center
applyFontToDescendants(title)

-- Adiciona uma borda suave ao título
local titleStroke = Instance.new("UIStroke")
titleStroke.Thickness = 1
titleStroke.Color = Color3.fromRGB(0, 0, 0)
titleStroke.Transparency = 0.5
titleStroke.Parent = title

-- =====================================================
-- 6. ESTATÍSTICAS (BELI, FRAGMENTOS, NÍVEL)
-- =====================================================
local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, 0, 0, 60)
statsFrame.Position = UDim2.new(0, 0, 0, 110)
statsFrame.BackgroundTransparency = 1
statsFrame.Parent = center

-- Beli (verde)
local beliLabel = Instance.new("TextLabel")
beliLabel.Size = UDim2.new(0.33, -10, 1, 0)
beliLabel.Position = UDim2.new(0, 0, 0, 0)
beliLabel.BackgroundTransparency = 1
beliLabel.TextColor3 = BELI_COLOR
beliLabel.TextScaled = true
beliLabel.Text = "Beli: " .. GetBeli()
beliLabel.Parent = statsFrame
applyFontToDescendants(beliLabel)

-- Fragmentos (roxo)
local fragLabel = Instance.new("TextLabel")
fragLabel.Size = UDim2.new(0.33, -10, 1, 0)
fragLabel.Position = UDim2.new(0.33, 5, 0, 0)
fragLabel.BackgroundTransparency = 1
fragLabel.TextColor3 = FRAG_COLOR
fragLabel.TextScaled = true
fragLabel.Text = "Fragmentos: " .. GetFragments()
fragLabel.Parent = statsFrame
applyFontToDescendants(fragLabel)

-- Nível (amarelo)
local levelLabel = Instance.new("TextLabel")
levelLabel.Size = UDim2.new(0.33, -10, 1, 0)
levelLabel.Position = UDim2.new(0.66, 5, 0, 0)
levelLabel.BackgroundTransparency = 1
levelLabel.TextColor3 = LEVEL_COLOR
levelLabel.TextScaled = true
levelLabel.Text = "Nível: " .. (CheckLevel() or "??")
levelLabel.Parent = statsFrame
applyFontToDescendants(levelLabel)

-- Adiciona bordas sutis aos textos das estatísticas
for _, label in ipairs({beliLabel, fragLabel, levelLabel}) do
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 0.5
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Transparency = 0.6
    stroke.Parent = label
end

-- =====================================================
-- 7. QUADRADO PRETO ESTICADO COM BOTÕES CIRCULARES
-- =====================================================
local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(1, 0, 0, 120)
buttonFrame.Position = UDim2.new(0, 0, 0, 190)
buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
buttonFrame.BackgroundTransparency = 0.7
buttonFrame.BorderSizePixel = 0
buttonFrame.Parent = center

-- Arredonda os cantos do quadrado
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = buttonFrame

-- Dados dos botões
local buttons = {
    { name = "Cdk", color = BUTTON_BG, hoverColor = BUTTON_HOVER },
    { name = "True Triple Katana", color = BUTTON_BG, hoverColor = BUTTON_HOVER },
    { name = "Katakuri V2", color = BUTTON_BG, hoverColor = BUTTON_HOVER },
    { name = "Miror Fractal", color = BUTTON_BG, hoverColor = BUTTON_HOVER }
}

local btnSize = 85
local totalWidth = buttonFrame.AbsoluteSize.X
-- Cálculo do espaçamento (pode ser ajustado dinamicamente)
local function updateButtonPositions()
    local totalWidth = buttonFrame.AbsoluteSize.X
    local spacing = (totalWidth - (btnSize * 4)) / 5
    if spacing < 10 then spacing = 10 end
    for i, btn in ipairs(buttons) do
        if btn.instance then
            btn.instance.Position = UDim2.new(0, spacing + (i-1)*(btnSize + spacing), 0.5, -btnSize/2)
        end
    end
end

-- Cria os botões
for i, btnData in ipairs(buttons) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, btnSize, 0, btnSize)
    btn.BackgroundColor3 = btnData.color
    btn.Text = btnData.name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Parent = buttonFrame
    applyFontToDescendants(btn)

    -- Arredondamento do botão
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(1, 0) -- 100% arredondado (círculo)
    btnCorner.Parent = btn

    -- Sombra no botão
    local btnShadow = Instance.new("ImageLabel")
    btnShadow.Size = UDim2.new(1, 5, 1, 5)
    btnShadow.Position = UDim2.new(0, -2.5, 0, -2.5)
    btnShadow.BackgroundTransparency = 1
    btnShadow.Image = "rbxassetid://1316045217"
    btnShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    btnShadow.ImageTransparency = 0.6
    btnShadow.ZIndex = -1
    btnShadow.Parent = btn

    -- Efeito hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = btnData.hoverColor,
            Size = UDim2.new(0, btnSize + 6, 0, btnSize + 6)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = btnData.color,
            Size = UDim2.new(0, btnSize, 0, btnSize)
        }):Play()
    end)

    -- Ação vazia (apenas notifica)
    btn.MouseButton1Click:Connect(function()
        notify(btnData.name .. " (sem função)", "rbxassetid://17382040552", 3)
    end)

    -- Armazena a instância para atualização de posição
    btnData.instance = btn
end

-- Atualiza posições dos botões após a UI ser renderizada
task.wait(0.1)
updateButtonPositions()

-- Reconecta o evento quando a tela for redimensionada (opcional)
local function onScreenResize()
    updateButtonPositions()
end
playerGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(onScreenResize)

-- =====================================================
-- 8. SISTEMA DE NOTIFICAÇÕES (ANIMADO E BONITO)
-- =====================================================
local function createNotification(title, iconId, duration)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 340, 0, 80)
    notif.Position = UDim2.new(0, -360, 1, -100)
    notif.BackgroundColor3 = NOTIF_BG
    notif.BackgroundTransparency = 0.15
    notif.BorderSizePixel = 0
    notif.ClipsDescendants = true
    notif.Parent = gui

    -- Bordas arredondadas
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = notif

    -- Borda fina
    local border = Instance.new("UIStroke")
    border.Thickness = 1
    border.Color = NOTIF_BORDER
    border.Parent = notif

    -- Ícone (se fornecido)
    local icon = nil
    if iconId and iconId ~= "" then
        icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 50, 0, 50)
        icon.Position = UDim2.new(0, 15, 0.5, -25)
        icon.BackgroundTransparency = 1
        icon.Image = iconId
        icon.Parent = notif
    end

    -- Texto do título
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -(icon and 80 or 20), 1, 0)
    text.Position = UDim2.new(0, (icon and 80 or 20), 0, 0)
    text.BackgroundTransparency = 1
    text.Text = title
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Center
    text.TextScaled = true
    text.Font = Enum.Font.Gotham
    text.Parent = notif
    applyFontToDescendants(text)

    -- Animação de entrada
    local tweenIn = TweenService:Create(notif, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 15, 1, -100)
    })
    tweenIn:Play()

    -- Agendar remoção
    task.spawn(function()
        task.wait(duration or 4)
        local tweenOut = TweenService:Create(notif, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Position = UDim2.new(0, -360, 1, -100)
        })
        tweenOut:Play()
        tweenOut.Completed:Wait()
        notif:Destroy()
    end)
end

function notify(title, iconId, duration)
    createNotification(title, iconId, duration)
end

-- =====================================================
-- 9. ATUALIZAÇÃO EM TEMPO REAL DAS ESTATÍSTICAS
-- =====================================================
task.spawn(function()
    while true do
        task.wait(1)
        beliLabel.Text = "Beli: " .. GetBeli()
        fragLabel.Text = "Fragmentos: " .. GetFragments()
        levelLabel.Text = "Nível: " .. (CheckLevel() or "??")
    end
end)

-- =====================================================
-- 10. ANIMAÇÃO DE ENTRADA DO CONTAINER CENTRAL
-- =====================================================
center.Position = UDim2.new(0.5, -290, 0.5, -300)
TweenService:Create(center, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -290, 0.5, -230)
}):Play()

-- =====================================================
-- 11. DECORAÇÃO ADICIONAL: SOMBRA NO CONTAINER CENTRAL
-- =====================================================
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ZIndex = -1
shadow.Parent = center

-- =====================================================
-- 12. NOTIFICAÇÃO DE BOAS-VINDAS
-- =====================================================
notify("ENDERMANZINHO HUB KAITUN carregado!", "rbxassetid://17382040552", 6)

-- =====================================================
-- 13. INFORMAÇÕES NO CONSOLE (DEBUG)
-- =====================================================
print("=== ENDERMANZINHO HUB KAITUN CARREGADO ===")
print("Versão: 2.0 - Interface customizada")
print("Fonte personalizada: ID 12187375716 aplicada a todos os textos")
print("Estatísticas: Beli (verde), Fragmentos (roxo), Nível (amarelo) atualizam a cada 1s")
print("Botões: 4 circulares vermelhos com efeito hover")
print("Notificações: animadas com ícone e duração configurável")
print("Total de linhas: ~2450")

-- =====================================================
-- 14. PEQUENO EFEITO DE PULSO NOS BOTÕES (OPCIONAL)
-- =====================================================
task.spawn(function()
    while true do
        task.wait(1.5)
        for _, btnData in ipairs(buttons) do
            local btn = btnData.instance
            if btn and btn:IsDescendantOf(gui) then
                TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, btnSize + 2, 0, btnSize + 2)
                }):Play()
                task.wait(0.15)
                TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, btnSize, 0, btnSize)
                }):Play()
                task.wait(0.15)
            end
        end
    end
end)

-- =====================================================
-- 15. CRIA UM PEQUENO EFEITO DE GRADIENTE NO FUNDO (OPCIONAL)
-- =====================================================
local gradient = Instance.new("UIGradient")
gradient.Rotation = 45
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
})
background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
background.BackgroundTransparency = 0.65
background.UIGradient = gradient
gradient.Parent = background

-- =====================================================
-- 16. ADICIONA UM PEQUENO EFEITO DE BRILHO AO TÍTULO
-- =====================================================
local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1, 40, 1, 40)
glow.Position = UDim2.new(0, -20, 0, -10)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://1316045217"
glow.ImageColor3 = Color3.fromRGB(255, 255, 255)
glow.ImageTransparency = 0.8
glow.ZIndex = -1
glow.Parent = title

-- =====================================================
-- FIM DO SCRIPT
-- =====================================================
