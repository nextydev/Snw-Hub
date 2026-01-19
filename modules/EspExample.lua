--[ Hello! This is an example of the Esp Module! ]--
--[ Game: Flee The Facility, Old esp version of SnwHub ]--

local workspace = game:GetService("Workspace")
local players = game:GetService("Players")

local cfg = {
    esp = {
        players = true,
        pcs = true,
        pods = true,
        exits = true,
    },
}

local function getPlayerBeast()
    for _, target in ipairs(players:GetChildren()) do
        local char = target.Character
        if char and char:FindFirstChild("BeastPowers") then
            return target
        end
    end
    return nil
end

local SnwModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/nextydev/Snw-Hub/refs/heads/main/modules/Esp.lua"))()
local SnwEsp = SnwModule.new()

local function reloadEsp()
    SnwEsp:clearAll()
    
    for _, obj in ipairs(workspace:GetDescendants()) do

        if obj.Name == "ComputerTable" and cfg.esp.pcs then
            if obj.Screen.Color == Color3.fromRGB(40, 127, 71) then
                SnwEsp:add(obj, {
                    AccentColor = Color3.fromRGB(40, 127, 71),
                    GroupName = "pcs"
                })
            else 
                SnwEsp:add(obj, {
                    AccentColor = Color3.fromRGB(63, 159, 255),
                    GroupName = "pcs",
                })
            end
        end

        if obj.Name == "FreezePod" and cfg.esp.pods then
            SnwEsp:add(obj, {
                AccentColor = Color3.fromRGB(0, 89, 255),
                GroupName = "pods",
            })
        end

        if obj.Name == "ExitDoor" and cfg.esp.exits then
            SnwEsp:add(obj, {
                AccentColor = Color3.fromRGB(255, 242, 98),
                GroupName = "exits",
            })
        end
    end


    for _, target in ipairs(players:GetChildren()) do
        if target ~= players.LocalPlayer and cfg.esp.players then
            if target == getPlayerBeast() then
                SnwEsp:add(target, {
                    AccentColor = Color3.fromRGB(255, 31, 31),
                    GroupName = "players",
                })
            else
                SnwEsp:add(target, {
                    AccentColor = Color3.fromRGB(255, 255, 255),
                    GroupName = "players",
                })
            end
        end
    end
end

local isGameActive = game:GetService("ReplicatedStorage"):WaitForChild("IsGameActive")
local gameStatus = game:GetService("ReplicatedStorage"):WaitForChild("GameStatus")

if isGameActive and gameStatus then
    isGameActive.Changed:Connect(function()
        reloadEsp()
    end)
    gameStatus.Changed:Connect(function()
        reloadEsp()
    end)
end

reloadEsp()
print("[SnwEsp] Loaded!")
