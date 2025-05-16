_G.FastAttack = true

if _G.FastAttack then
    local _ENV = (getgenv or getrenv or getfenv)()

    local function SafeWaitForChild(parent, childName)
        local success, result = pcall(function()
            return parent:WaitForChild(childName)
        end)
        if not success or not result then
            warn("noooooo: " .. childName)
        end
        return result
    end

    local function WaitChilds(path, ...)
        local last = path
        for _, child in {...} do
            last = last:FindFirstChild(child) or SafeWaitForChild(last, child)
            if not last then break end
        end
        return last
    end
end

pcall(function()
local a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p=game,task.wait,Vector3.new,CFrame.new,math.huge,{},{},0,nil,false,nil,nil,nil,nil,nil,nil,nil;repeat b() until a:IsLoaded()and a.Players.LocalPlayer;local q=a.Players.LocalPlayer repeat b() until q.Character;local r=a:GetService("VirtualInputManager")local s=a:GetService("RunService")local t=a:GetService("UserInputService")local u=a:GetService("ReplicatedStorage")local v=a:GetService("Workspace")local w=u:WaitForChild("Remotes")local x={};function x:Check(y)local z=0;for A,B in pairs(y:GetChildren())do if B:IsA("Tool")then z=z+1 end end;if z>=2 then return true end end;function x:GetWeapon(y)for A,B in pairs(y:GetChildren())do if B:IsA("Tool")then return B end end end;function x:GetMonC()for A,B in pairs(v.Enemies:GetChildren())do if B:FindFirstChild("Humanoid")and B:FindFirstChild("HumanoidRootPart")and B:FindFirstChild("IsAlive")and B:FindFirstChild("IsAlive"):FindFirstChild("Value")and B:FindFirstChild("IsAlive").Value==true and B.Humanoid.Health>0 then return B end end end;function x:GetMob()for A,B in pairs(v.Enemies:GetChildren())do if B:FindFirstChild("Humanoid")and B:FindFirstChild("HumanoidRootPart")and B.Humanoid.Health>0 and B:FindFirstChild("IsAlive")and B:FindFirstChild("IsAlive"):FindFirstChild("Value")and B:FindFirstChild("IsAlive").Value==true and (q.Character.HumanoidRootPart.Position-B.HumanoidRootPart.Position).magnitude<50 then return B end end end;function x:Equip()if not x:Check(q.Backpack)then return end;local C=x:GetWeapon(q.Backpack)if C then repeat b()q.Character.Humanoid:EquipTool(C)until q.Character:FindFirstChild(C.Name)end end;function x:Attack()if tick()-j<0.5 then return end;j=tick()if not x:Check(q.Backpack)and not x:Check(q.Character)then return end;local C=q.Character:FindFirstChildOfClass("Tool")or x:GetWeapon(q.Backpack)if not C then return end;x:Equip()local D=q.Character;if not D:FindFirstChild("Humanoid")or not D:FindFirstChild("HumanoidRootPart")then return end;local E=x:GetMob()or x:GetMonC()if not E then return end;w:FindFirstChild("Combat"):InvokeServer(C)for F=1,1 do r:SendMouseButtonEvent(0,0,0,true,a)r:SendMouseButtonEvent(0,0,0,false,a)w:FindFirstChild("Combat"):InvokeServer(C)end end;s.Stepped:Connect(function()if not q.Character then return end;local C=q.Character:FindFirstChildOfClass("Tool")if not C then return end;C:Activate()end)s.Heartbeat:Connect(function()x:Attack()end)
end)
