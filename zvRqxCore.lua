local A1 = game:GetService("Players")
local A2 = game:GetService("RunService")
local A3 = game:GetService("ReplicatedStorage")
local A4 = game:GetService("Workspace")
local A5 = game:GetService("VirtualInputManager")
local A6 = A1.LocalPlayer
local A7 = A3:WaitForChild("Modules")
local A8 = A7:WaitForChild("Net")
local A9 = A8:WaitForChild("RE/RegisterAttack")
local B1 = A8:WaitForChild("RE/RegisterHit")
local B2 = A8:WaitForChild("RE/ShootGunEvent")
local B3 = A3:WaitForChild("Remotes"):WaitForChild("Validator2")
local B4 = {
    C1 = 65,
    C2 = true,
    C3 = true,
    C4 = 0.2,
    C5 = 0.3,
    C6 = 4,
    C7 = {"RightLowerArm", "RightUpperArm", "LeftLowerArm", "LeftUpperArm", "RightHand", "LeftHand"},
    C8 = true
}
local Z = {}
Z.__index = Z
function Z.X1()
    local X = setmetatable({
        Y1 = 0,
        Y2 = 0,
        Y3 = 0,
        Y4 = 0,
        Y5 = nil,
        Y6 = {},
        Y7 = {Dragonstorm = {MaxOverheat = 3, Cooldown = 0, TotalOverheat = 0, Distance = 350, Shooting = false}},
        Y8 = {["Dual Flintlock"] = 2},
        Y9 = {["Skull Guitar"] = "TAP", ["Bazooka"] = "Position", ["Cannon"] = "Position", ["Dragonstorm"] = "Overheat"}
    }, Z)
    pcall(function()
        X.Z1 = require(A7.Flags).COMBAT_REMOTE_THREAD
        X.Z2 = getupvalue(require(A3.Controllers.CombatController).Attack, 9)
        local Z3 = A6:WaitForChild("PlayerScripts"):FindFirstChildOfClass("LocalScript")
        if Z3 and getsenv then
            X.Z3 = getsenv(Z3)._G.SendHitsToServer
        end
    end)
    return X
end
function Z:Z4(E)
    local F = E and E:FindFirstChild("Humanoid")
    return F and F.Health > 0
end
function Z:Z5(G, H, I)
    local J = G:FindFirstChild("Stun")
    local K = G:FindFirstChild("Busy")
    if H.Sit and (I == "Sword" or I == "Melee" or I == "Blox Fruit") then
        return false
    elseif J and J.Value > 0 or K and K.Value then
        return false
    end
    return true
end
function Z:Z6(L, M)
    local N = L:GetPivot().Position
    local O = {}
    M = M or B4.C1
    local function P(Q)
        for _, R in ipairs(Q:GetChildren()) do
            if R ~= L and self:Z4(R) then
                local S = R:FindFirstChild(B4.C7[math.random(#B4.C7)]) or R:FindFirstChild("HumanoidRootPart")
                if S and (N - S.Position).Magnitude <= M then
                    if not self.Y5 then
                        self.Y5 = S
                    else
                        table.insert(O, {R, S})
                    end
                end
            end
        end
    end
    if B4.C2 then P(A4.Enemies) end
    if B4.C3 then P(A4.Characters) end
    return O
end
function Z:Z7(T, U)
    local V = self:Z6(T, U)
    local W, X = nil, math.huge
    for _, Y in ipairs(V) do
        local Z0 = (T:GetPivot().Position - Y[2].Position).Magnitude
        if Z0 < X then
            X = Z0
            W = Y[2]
        end
    end
    return W
end
function Z:Z8()
    local Z9 = (tick() - self.Y2) <= B4.C5 and self.Y4 or 0
    Z9 = Z9 >= B4.C6 and 1 or Z9 + 1
    self.Y2 = tick()
    self.Y4 = Z9
    return Z9
end
function Z:A0(AA)
    local AB = A6.Character
    if not self:Z4(AB) then return end
    local AC = AB:FindFirstChildOfClass("Tool")
    if not AC or AC.ToolTip ~= "Gun" then return end
    local AD = AC:FindFirstChild("Cooldown") and AC.Cooldown.Value or 0.3
    if (tick() - self.Y3) < AD then return end
    local AE = self.Y9[AC.Name] or "Normal"
    if AE == "Position" or (AE == "TAP" and AC:FindFirstChild("RemoteEvent")) then
        AC:SetAttribute("LocalTotalShots", (AC:GetAttribute("LocalTotalShots") or 0) + 1)
        B3:FireServer(self:A1())
        if AE == "TAP" then
            AC.RemoteEvent:FireServer("TAP", AA)
        else
            B2:FireServer(AA)
        end
        self.Y3 = tick()
    else
        A5:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.05)
        A5:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        self.Y3 = tick()
    end
end
function Z:A1()
    local A2 = getupvalue(self.Z2, 15)
    local A3 = getupvalue(self.Z2, 13)
    local A4 = getupvalue(self.Z2, 16)
    local A5 = getupvalue(self.Z2, 17)
    local A6 = getupvalue(self.Z2, 14)
    local A7 = getupvalue(self.Z2, 12)
    local A8 = getupvalue(self.Z2, 18)
    local A9 = A7 * A3
    local B0 = (A6 * A3 + A7 * A2) % A4
    B0 = (B0 * A4 + A9) % A5
    A6 = math.floor(B0 / A4)
    A7 = B0 - A6 * A4
    A8 = A8 + 1
    setupvalue(self.Z2, 15, A2)
    setupvalue(self.Z2, 13, A3)
    setupvalue(self.Z2, 16, A4)
    setupvalue(self.Z2, 17, A5)
    setupvalue(self.Z2, 14, A6)
    setupvalue(self.Z2, 12, A7)
    setupvalue(self.Z2, 18, A8)
    return math.floor(B0 / A5 * 16777215), A8
end
function Z:A2(BA, BB, BC)
    self.Y5 = nil
    local BD = self:Z6(BA)
    if self.Y5 then
        A9:FireServer(BC)
        if self.Z1 and self.Z3 then
            self.Z3(self.Y5, BD)
        else
            B1:FireServer(self.Y5, BD)
        end
    end
end
function Z:A3(BE, BF, BG)
    local BH = self:Z6(BE)
    if not BH[1] then return end
    local BI = (BH[1][2].Position - BE:GetPivot().Position).Unit
    BF.LeftClickRemote:FireServer(BI, BG)
end
function Z:A4()
    if not B4.C8 or (tick() - self.Y1) < B4.C4 then return end
    local BJ = A6.Character
    if not BJ or not self:Z4(BJ) then return end
    local BK = BJ.Humanoid
    local BL = BJ:FindFirstChildOfClass("Tool")
    if not BL then return end
    local BM = BL.ToolTip
    if not table.find({"Melee", "Blox Fruit", "Sword", "Gun"}, BM) then return end
    local BN = BL:FindFirstChild("Cooldown") and BL.Cooldown.Value or B4.C4
    if not self:Z5(BJ, BK, BM) then return end
    local BO = self:Z8()
    BN = BN + (BO >= B4.C6 and 0.05 or 0)
    self.Y1 = BO >= B4.C6 and BM ~= "Gun" and (tick() + 0.05) or tick()
    if BM == "Blox Fruit" and BL:FindFirstChild("LeftClickRemote") then
        self:A3(BJ, BL, BO)
    elseif BM == "Gun" then
        local BP = self:Z7(BJ, 120)
        if BP then
            self:A0(BP.Position)
        end
    else
        self:A2(BJ, BK, BN)
    end
end

local BQ = Z.X1()
table.insert(BQ.Y6, A2.Stepped:Connect(function()
    BQ:A4()
end))
