--[ SnwEsp Module - Version 0.0.0 ]--

 --[[

addPlayer(playerCharacter, {
  FillColor = Color3.fromRGB(255,255,255),
  FillTransparency = 0.7,
  OutlineColor = Color3.fromRGB(0,0,0),
  OutlineTransparency = 0,
})

addObj(obj, {
  FillColor = Color3.fromRGB(128, 128, 128),
  FillTransparency = 0.7,
  OutlineColor = Color3.fromRGB(0,0,0),
  OutlineTransparency = 0,
})

]]--

local function createHg()
  local hg = Instance.new("Highlight")
  hg.Name = "snw"
  hg.Enabled = true
  hg.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  return hg
end

local function addPlayer(char, cfg)
  local cfg = cfg or {}
  if char == nil or not char then
    warn("[SnwEsp] Player Character not found!")
    return
  end
  local HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
  if not HumanoidRootPart then
    warn("[SnwEsp] HumanoidRootPart not found!")
    return
  end
  
  if HumanoidRootPart:FindFirstChild("snw") then
    HumanoidRootPart:FindFirstChild("snw"):Destroy()
  end
  
  local FillColor = cfg.FillColor or Color3.fromRGB(255,255,255)
  local FillTransparency = cfg.FillTransparency or 0.7
  local OutlineColor = cfg.OutlineColor or Color3.fromRGB(0,0,0)
  local OutlineTransparency = cfg.OutlineTransparency or 0
  
  local hg = createHg()
  hg.FillColor = FillColor
  hg.FillTransparency = FillTransparency
  hg.OutlineColor = OutlineColor
  hg.OutlineTransparency = OutlineTransparency
  hg.Adornee = char
  hg.Parent = HumanoidRootPart
end

local function addObj(obj, cfg)
  cfg = cfg or {}
  if obj == nil then
    warn("[SnwEsp] Object not found!")
    return
  end
  if obj:FindFirstChild("snw") then
    obj:FindFirstChild("snw"):Destroy()
  end
  
  local FillColor = cfg.FillColor or Color3.fromRGB(128, 128, 128)
  local FillTransparency = cfg.FillTransparency or 0.7
  local OutlineColor = cfg.OutlineColor or Color3.fromRGB(0,0,0)
  local OutlineTransparency = cfg.OutlineTransparency or 0
  
  local hg = createHg()
  hg.FillColor = FillColor
  hg.FillTransparency = FillTransparency
  hg.OutlineColor = OutlineColor
  hg.OutlineTransparency = OutlineTransparency
  hg.Adornee = obj
  hg.Parent = obj
end

local function clear()
  for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("Highlight") and obj.Name == "snw" then
      obj:Destroy()
    end
  end
end

return {
  addPlayer = addPlayer,
  addObj = addObj,
  clear = clear,
}
