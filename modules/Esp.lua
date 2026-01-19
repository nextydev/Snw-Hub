local workspace = game:GetService("Workspace")
local players = game:GetService("Players")

local function createEsp()
    local esp = Instance.new("Highlight")
    esp.Name = "SnwEsp-"  -- Corrigido: Name com maiúscula
    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    esp.Enabled = true
    return esp
end

local function clearAll()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") and string.sub(obj.Name, 1, 7) == "SnwEsp-" then
            obj:Destroy()
        end
    end
end

local function clearGroup(group)
    local searchName = "SnwEsp-" .. group
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") and obj.Name == searchName then
            obj:Destroy()
        end
    end
end

local function add(target, cfg)
    cfg = cfg or {}
    local AccentColor = cfg.AccentColor or Color3.fromRGB(255, 255, 255)
    local OutlineColor = cfg.OutlineColor or AccentColor
    local AccentTransparency = cfg.AccentTransparency or 0.7
    local OutlineTransparency = cfg.OutlineTransparency or AccentTransparency
    local groupName = cfg.GroupName or "obj"
    
    local esp = createEsp()
    esp.FillColor = AccentColor
    esp.OutlineColor = OutlineColor
    esp.FillTransparency = AccentTransparency
    esp.OutlineTransparency = OutlineTransparency
    esp.Name = "SnwEsp-" .. groupName

    if target:IsA("Model") then
        esp.Adornee = target
        esp.Parent = target
    elseif target:IsA("Player") and target ~= players.LocalPlayer then
        local char = target.Character
        if char then
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            if rootPart then
                esp.Adornee = char
                esp.Parent = rootPart
            end
        end
    end
end

return {
    clearAll = clearAll,
    clearGroup = clearGroup,
    add = add,
}
