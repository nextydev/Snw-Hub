--[ Hello! This is in current test, if you want help tell me errors! ]--

local workspace = game:GetService("Workspace")
local players = game:GetService("Players")

local function createEsp()
    local esp = Instance.new("Highlight")
    esp.name = "SnwEsp-"
    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    esp.Enabled = true
    return esp
end

local function clearAll()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:StartsWith("SnwEsp-") then
            obj:Destroy()
        end
    end
end

local function clearGroup(group)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:StartsWith("SnwEsp-" .. group) then
            obj:Destroy()
        end
    end
end

local function add(target, cfg)
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
    end

    if target:IsA("Player") and target ~= players.LocalPlayer then
        local char = target.Character
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        esp.Adornee = char
        esp.Parent = rootPart
    end
end


return {
    clearAll(),
    clearGroup(),
    add(),
}
