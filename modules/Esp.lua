local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local Snw = {}

local Snw = {}
Snw.__index = Snw

function Snw.new()
  local self = setmetatable({}, Snw)
  return self
end

function Snw:createEsp()
    local esp = Instance.new("Highlight")
    esp.Name = "SnwEsp-"
    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    esp.Enabled = true
    return esp
end

function Snw:clearAll()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") and string.sub(obj.Name, 1, 7) == "SnwEsp-" then
            obj:Destroy()
        end
    end
end

function Snw:clearGroup(group)
    local searchName = "SnwEsp-" .. group
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Highlight") and obj.Name == searchName then
            obj:Destroy()
        end
    end
end

function Snw:add(target, cfg)
    cfg = cfg or {}
    local AccentColor = cfg.AccentColor or Color3.fromRGB(255, 255, 255)
    local OutlineColor = cfg.OutlineColor or AccentColor
    local AccentTransparency = cfg.AccentTransparency or 0.7
    local OutlineTransparency = cfg.OutlineTransparency or 0.6
    local groupName = cfg.GroupName or "obj"
    
    local esp = Snw:createEsp()
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

return Snw
