
local sellOfRarity = {
    ["Rare"] = true,
    ["Epic"] = true,
    ["Legendary"] = true,
    ["Mythic"] = false,
    ["Secret"] = false,
}


----------------- ANTI-CHEAT BYPASS ----------------- ANTI-CHEAT BYPASS ----------------- start
local Remote_Manager = {}

Remote_Manager.SafeEnvironment = nil

Remote_Manager.FireSafeEnvironment = function(remoteName, args)
    repeat task.wait() until Remote_Manager.SafeEnvironment
    _G.A = remoteName
    _G.B = args
    _G.TYPE = "Fire"
    repeat task.wait() until not _G.A and not _G.B and not _G.TYPE
end

Remote_Manager.InvokeSafeEnvironment = function(remoteName, args)
    repeat task.wait() until Remote_Manager.SafeEnvironment
    _G.A = remoteName
    _G.B = args
    _G.TYPE = "Invoke"
    repeat task.wait() until not _G.A and not _G.B and not _G.TYPE
end


Remote_Manager.Init = function()
    setthreadcontext(2)

    local RS = game:GetService("ReplicatedStorage")
    local a = require(RS:WaitForChild("Actions"))


    local c = require(game:GetService("ReplicatedStorage").SupportModules.Ping)
    local old = c.GetPlayerPing
    c.GetPlayerPing = function(...)
        if not Remote_Manager.SafeEnvironment then
            Remote_Manager.SafeEnvironment = true
            old(...)
            print("get env: ", i)
            while task.wait() do
                repeat task.wait() until _G.A and _G.B and _G.TYPE
                local a_, b, type = _G.A, _G.B, _G.TYPE
                if type == "Fire" then
                    a[a_]:Fire(table.unpack(b))
                else
                    a[a_]:Invoke(table.unpack(b))
                end
                task.wait(.5)
                _G.A = nil
                _G.B = nil
                _G.TYPE = nil
            end
        else
            return old(...)
        end
    end
end


task.spawn(Remote_Manager.Init)
----------------- ANTI-CHEAT BYPASS ----------------- ANTI-CHEAT BYPASS ----------------- end

-- wait for game load
local RS = game:GetService("ReplicatedStorage")
local plrControl = require(game.ReplicatedFirst.Classes.PlayerControl)

if plrControl.LocalPlayer == nil then
    plrControl.LocalPlayerLoaded.Event:Wait()
end

repeat task.wait(0.1) until game:IsLoaded()

task.wait(3)
repeat wait() until Remote_Manager.SafeEnvironment
print("Loaded")

spawn(function()
    Remote_Manager.FireSafeEnvironment("UNIT_EQUIP_BEST", {})
    while wait(10) do
        Remote_Manager.FireSafeEnvironment("UNIT_EQUIP_BEST", {})
    end
end)


function save()
    return game:GetService("ReplicatedStorage").Remotes.GetInventory:InvokeServer()
end

-- check inventory for troops of rarity
local UnitData = require(game:GetService("ReplicatedStorage").Modules.Bins.UnitData)
local unitDataV2 = {}

for i, v in UnitData do
    unitDataV2[i] = v.Rarity
end

print("Setting auto delete")
if tostring(game.Players.LocalPlayer.PlayerGui.PAGES.SummonPage.Holder.HolderAutoSell.DefaultButton.AutoDelete_Rare.UIGradient.Color) ~= "0 1 0.454902 0.290196 0 1 1 0.054902 0.0705882 0 " then
    for i = 2, 4 do
        print("Firing!")
        Remote_Manager.FireSafeEnvironment("AUTO_DELETE_RARITY", { tostring(i) })
    end
end

print("Selling troops")
local sellTable = {}
for i, v in save().Units do
    local rarity = rarityConvert[unitDataV2[v.Type]]
    if sellOfRarity[rarity] then
        table.insert(sellTable, i)
    end
end
print("firing remote to sell all troop")

spawn(function()
Remote_Manager.FireSafeEnvironment("UNIT_SELL", { sellTable })
    while wait(10) do
Remote_Manager.FireSafeEnvironment("UNIT_SELL", { sellTable })
end
end)

