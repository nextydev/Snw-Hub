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

local function getBeast()
    for _, target in ipairs(players:GetChildren()) do
        local char = target.Character
        if char and char:FindFirstChild("BeastPowers") then
            return target
        end
    end
    return nil
end

local ESPIndicator = loadstring([[local e={} e.__index=e local a=game:GetService("RunService") local _=game:GetService("Players") local b=game:GetService("HttpService") local l=game:GetService("TweenService") e.Groups={} e.TargetIndex={} e.Defaults={AccentColor=Color3.new(1,1,0),HighlightFillTransparency=0.7,HighlightOutlineTransparency=0,HighlightDepthMode=Enum.HighlightDepthMode.AlwaysOnTop,ArrowShow=false,ArrowEdgePadding=50,ArrowMinDistance=0,ArrowSize=UDim2.new(0,30,0,30),ArrowImage="rbxassetid://97136202386756",ArrowShowDistanceText=true,ArrowDistanceFont=Enum.Font.Montserrat,ArrowDistanceTextSize=18,ShowLabel=false,LabelText="Target",LabelMaxDistance=99999,LabelOffset=Vector3.new(0,2,0),Parent=game:GetService("CoreGui")} function e.new(b)local c=setmetatable({},e) c.Settings={} for a,_ in pairs(e.Defaults)do c.Settings[a]=(b and b[a]~=nil)and b[a]or _ end local _=c.Settings.Parent or _.LocalPlayer:WaitForChild("PlayerGui") c.ScreenGui=Instance.new("ScreenGui") c.ScreenGui.Name="ESPIndicators" c.ScreenGui.IgnoreGuiInset=true c.ScreenGui.ResetOnSpawn=false c.ScreenGui.Parent=_ c.ArrowTemplate=Instance.new("ImageLabel") c.ArrowTemplate.Name="ArrowTemplate" c.ArrowTemplate.Size=c.Settings.ArrowSize c.ArrowTemplate.AnchorPoint=Vector2.new(0.5,0.5) c.ArrowTemplate.BackgroundTransparency=1 c.ArrowTemplate.Image=c.Settings.ArrowImage c.ArrowTemplate.ImageColor3=c.Settings.AccentColor c.ArrowTemplate.Visible=false c.ArrowTemplate.Parent=c.ScreenGui c.Scaler=Instance.new("UIScale") c.Scaler.Name="Scaler" c.Scaler.Scale=0 c.Scaler.Parent=c.ArrowTemplate c.Indicators={} c._updateConn=a.RenderStepped:Connect(function()c:_update()end) c._cleanupConn=a.Heartbeat:Connect(function()c:_cleanupOrphanedArrows() c:_cleanupOrphanedHighlights() c:_cleanupOrphanedLabels()end) return c end function e:AddGroup(_)local a=e.Groups[_] if not a then a={enabled=true,properties={},targets={}} e.Groups[_]=a end return a end function e:GetGroup(_)return e.Groups[_]end function e:RemoveGroup(b)local _=e.Groups[b] if not _ then return false end for _,_ in ipairs(_.targets)do local c=e.TargetIndex[_] if c then for _,a in ipairs(c)do if a==b then table.remove(c,_) break end end if#c==0 then e.TargetIndex[_]=nil end end if not e.TargetIndex[_]then self:Remove(_)end end e.Groups[b]=nil return true end function e:ClearAllGroups()for a,_ in pairs(e.Groups)do self:RemoveGroup(a)end end function e:ToggleGroup(_,a)local b=e.Groups[_] if not b then return end b.enabled=(a~=nil)and a or not b.enabled for _,_ in ipairs(b.targets)do local _=self.Indicators[_] if _ then if _.Highlight then _.Highlight.Enabled=b.enabled end if _.Arrow then _.Arrow.Visible=b.enabled and self.Settings.ArrowShow end if _.Label then _.Label.Enabled=b.enabled end end end return b.enabled end function e:SetGroupProperty(_,a,b)local _=self:AddGroup(_) _.properties[a]=b for _,_ in ipairs(_.targets)do local _=self.Indicators[_] if _ then if a=="AccentColor"then if _.Highlight then _.Highlight.FillColor=b _.Highlight.OutlineColor=b end if _.Arrow then _.Arrow.ImageColor3=b end if _.DistanceLabel then _.DistanceLabel.TextColor3=b end if _.Label and _.Label:FindFirstChild("TextLabel")then _.Label.TextLabel.TextColor3=b end end end end end function e:Add(a,g)assert(a,"ESPIndicator:Add requires a non-nil target") g=g or{} local d=Instance.new("Highlight") d.Name="Highlight_"..b:GenerateGUID(false) d.Adornee=a d.FillTransparency=g.HighlightFillTransparency or self.Settings.HighlightFillTransparency d.FillColor=g.AccentColor or self.Settings.AccentColor d.OutlineColor=g.AccentColor or self.Settings.AccentColor d.OutlineTransparency=g.HighlightOutlineTransparency or self.Settings.HighlightOutlineTransparency d.DepthMode=g.HighlightDepthMode or self.Settings.HighlightDepthMode d.Parent=self.ScreenGui local c,_,e if(g.ArrowShow or self.Settings.ArrowShow)then c=self.ArrowTemplate:Clone() c.Name="Arrow_"..b:GenerateGUID(false) c.ImageColor3=g.AccentColor or self.Settings.AccentColor c.Visible=true c.Parent=self.ScreenGui _=c:FindFirstChild("Scaler") if(g.ArrowShowDistanceText or self.Settings.ArrowShowDistanceText)then e=Instance.new("TextLabel") e.Name="DistanceLabel" e.AnchorPoint=Vector2.new(0.5,0) e.BackgroundTransparency=1 e.Font=g.ArrowDistanceFont or self.Settings.ArrowDistanceFont e.TextSize=g.ArrowDistanceTextSize or self.Settings.ArrowDistanceTextSize e.TextColor3=g.AccentColor or self.Settings.AccentColor e.Parent=c end end local f if(g.ShowLabel or self.Settings.ShowLabel)then f=Instance.new("BillboardGui") f.Name="Label_"..b:GenerateGUID(false) f.AlwaysOnTop=true f.MaxDistance=self.Settings.LabelMaxDistance f.Size=UDim2.new(0,70,0,70) f.StudsOffset=self.Settings.LabelOffset f.Adornee=a f.Parent=self.ScreenGui local _=Instance.new("TextLabel") _.Name="TextLabel" _.Size=UDim2.new(1,0,1,0) _.AnchorPoint=Vector2.new(0.5,0.5) _.Position=UDim2.new(0.5,0,0.5,0) _.BackgroundTransparency=1 _.Font=Enum.Font.SourceSansBold _.TextScaled=true _.TextWrapped=true _.TextSize=14 _.TextColor3=g.AccentColor or self.Settings.AccentColor _.Text=g.LabelText or self.Settings.LabelText _.Parent=f Instance.new("UIStroke",_)end self.Indicators[a]={Highlight=d,Arrow=c,Scaler=_,DistanceLabel=e,Label=f,Options=g} local _=g.GroupName or self.Settings.GroupName if _ then self:AddToGroup(a,_)end end function e:Remove(c)local _=self.Indicators[c] if not _ then return end if _.Highlight then _.Highlight.Adornee=nil _.Highlight:Destroy()end if _.Arrow then _.Arrow:Destroy()end if _.Label then _.Label:Destroy()end local _=e.TargetIndex[c] if _ then for _,_ in ipairs(_)do local b=e.Groups[_] if b then for a,_ in ipairs(b.targets)do if _==c then table.remove(b.targets,a) break end end end end e.TargetIndex[c]=nil end self.Indicators[c]=nil end function e:AddToGroup(c,b)local _=self:AddGroup(b) if not table.find(_.targets,c)then table.insert(_.targets,c)end local a=e.TargetIndex[c] if not a then a={} e.TargetIndex[c]=a end if not table.find(a,b)then table.insert(a,b)end for a,_ in pairs(_.properties)do self:SetGroupProperty(b,a,_)end if not _.enabled then local _=self.Indicators[c] if _ and _.Highlight then _.Highlight.Enabled=false end end return true end function e:RemoveFromGroup(d,b)local c=e.Groups[b] if not c then return false end if table.find(c.targets,d)then for _,a in ipairs(c.targets)do if a==d then table.remove(c.targets,_) break end end else return false end local c=e.TargetIndex[d] if c then for a,_ in ipairs(c)do if _==b then table.remove(c,a) break end end if#c==0 then e.TargetIndex[d]=nil end end return true end function e:GetGroupTargets(_)local _=e.Groups[_] return _ and _.targets or{}end function e:GetTargetGroups(_)return e.TargetIndex[_]or{}end function e:_cleanupOrphanedHighlights()for _,_ in ipairs(self.ScreenGui:GetChildren())do if _:IsA("Highlight")and not table.find(self:_allHighlights(),_)then _.Adornee=nil _:Destroy()end end end function e:_allHighlights()local a={} for _,_ in pairs(self.Indicators)do if _.Highlight then table.insert(a,_.Highlight)end end return a end function e:_cleanupOrphanedArrows()for _,_ in ipairs(self.ScreenGui:GetChildren())do if _:IsA("ImageLabel")and _.Name:match("^Arrow_")then if not table.find(self:_allArrows(),_)then _:Destroy()end end end end function e:_allArrows()local a={} for _,_ in pairs(self.Indicators)do if _.Arrow then table.insert(a,_.Arrow)end end return a end function e:_cleanupOrphanedLabels()for _,_ in ipairs(self.ScreenGui:GetChildren())do if _:IsA("BillboardGui")and _.Name:match("^Label_")then if not table.find(self:_allLabels(),_)then _.Adornee=nil _:Destroy()end end end end function e:_allLabels()local a={} for _,_ in pairs(self.Indicators)do if _.Label then table.insert(a,_.Label)end end return a end function e:_update()local a=workspace.CurrentCamera local _=a.ViewportSize local f,i=_.X,_.Y for _,p in pairs(self.Indicators)do local j=p.Options local h=p.Arrow local k=p.Scaler if((not h)or(not k))and self.Settings.ArrowShow then self:Remove(_) continue end if not h then continue end local n if _:IsA("Model")then n=(_.PrimaryPart and _.PrimaryPart.Position)or _:GetModelCFrame().p elseif _:IsA("BasePart")then n=_.Position else continue end local m,e=a:WorldToViewportPoint(n) local c=(a.CFrame.p-n).Magnitude local _=j.ArrowMinDistance or self.Settings.ArrowMinDistance local o=j.ArrowEdgePadding or self.Settings.ArrowEdgePadding if e and c>_ then l:Create(k,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0}):Play()else l:Create(k,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=1}):Play() local d,g=f-o*2,i-o*2 local b=a.CFrame local _=math.sqrt((d/2)^2+(g/2)^2) local a=n-b.Position local a=b:VectorToObjectSpace(a) local n=Vector2.new(a.X,a.Y).Unit local a=math.clamp(m.X,o,f-o) local b=math.clamp(m.Y,o,i-o) if a==m.X and b==m.Y and e then l:Create(k,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Scale=0}):Play()else local _=n*_ local b if math.abs(_.Y)>g/2 then b=n*math.abs((g/2)/n.Y)else b=n*math.abs((d/2)/n.X)end local a=f/2+b.X local _=i/2-b.Y local b=math.atan2(n.X,n.Y) l:Create(h,TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.fromOffset(a,_),Rotation=math.deg(b)}):Play()end if p.DistanceLabel then p.DistanceLabel.Text=string.format("%dm",math.round(c)) local _=(j.ArrowSize and j.ArrowSize.Y.Offset or self.Settings.ArrowSize.Y.Offset)+16 p.DistanceLabel.Position=UDim2.new(0.5,0,0,_)end end end end function e:Destroy()if self._updateConn then self._updateConn:Disconnect()end if self._cleanupConn then self._cleanupConn:Disconnect()end self:ClearAllGroups() for _,_ in pairs(self.Indicators)do if _.Highlight then _.Highlight:Destroy()end if _.Arrow then _.Arrow:Destroy()end if _.Label then _.Label:Destroy()end end self.ScreenGui:Destroy() self.Indicators={} e.Groups={} e.TargetIndex={}end return e]])()
local espcontainer = ESPIndicator.new({ArrowEdgePadding = 50, ArrowShowDistanceText = false,})

local function reloadObj()
    espcontainer:ClearAllGroups()
    
    for _, obj in ipairs(workspace:GetDescendants()) do

        if obj.Name == "ComputerTable" and cfg.esp.pcs then
            if obj.Screen.Color == Color3.fromRGB(40, 127, 71) then
                espcontainer:Add(obj, {
                    AccentColor = Color3.fromRGB(40, 127, 71),
                    ArrowShow = false,
                    ShowLabel = false,
                    GroupName = "pcs"
                })
            else 
                espcontainer:Add(obj, {
                    AccentColor = Color3.fromRGB(63, 159, 255),
                    ArrowShow = false,
                    ShowLabel = false,
                    GroupName = "pcs"
                })
            end
        end

        if obj.Name == "FreezePod" and cfg.esp.pods then
            espcontainer:Add(obj, {
                AccentColor = Color3.fromRGB(0, 89, 255),
                ShowLabel = false,
                ArrowShow = false,
                GroupName = "pods"
            })
        end

        if obj.Name == "ExitDoor" and cfg.esp.players then
            espcontainer:Add(obj, {
                AccentColor = Color3.fromRGB(255, 242, 98),
                ShowLabel = false,
                ArrowShow = false,
                GroupName = "exits"
            })
        end
    end
end

local function reloadPlr()
    espcontainer:ClearAllGroups()

    for _, target in ipairs(players:GetChildren()) do
        local char = target.Character
        if char ~= nil and target ~= players.LocalPlayer and cfg.esp.players then
            espcontainer:Add(char, {
                AccentColor = Color3.fromRGB(255, 255, 255),
                ArrowShow = false,
                ShowLabel = false,
                GroupName = "players"
            })
        end
    end
end

local isGameActive = game:GetService("ReplicatedStorage"):WaitForChild("IsGameActive", 5)
local gameStatus = game:GetService("ReplicatedStorage"):WaitForChild("GameStatus", 5)

if isGameActive and gameStatus then
    isGameActive.Changed:Connect(function()
        reloadObj()
        reloadPlr()
    end)
    gameStatus.Changed:Connect(function()
        reloadObj()
        reloadPlr()
    end)
end

reloadPlr()
reloadObj()
print("[SnwEsp] Loaded!")
