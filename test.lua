local webhooks = {
    ["Rare"] = "",
    ["Epic"] =
    "https://discord.com/api/webhooks/1247745918132817940/3iz-dKpd8hcJWS6SDqtBZjzADbf80QPnrCaeVM9ZL17ZiQiL2BP6hXeTaYKCaFyk5yus",
    ["Legendary"] =
    "https://discord.com/api/webhooks/1247746014849269811/rJoQkIFhQowY0nTh-S7Lfxte-oBibj5YSrW_k6CyHgSgO9f6jpWG90hqI56EPJ0xlWLq",
    ["Mythic"] =
    "https://discord.com/api/webhooks/1247746549921087509/03K6KobirF9kHjohQrHbZjYsWCHJ3VvEi_0kUfy-W4KJ6cPfT_cLoIjUXUVuZFhVmQ4w",
    ["Secret"] =
    "https://discord.com/api/webhooks/1247746617780731914/8ue96sjIFmHFnan0Hh2bIW_J-TQvP5MXLR5y_RrJ14Y43_LiFke9VgnCofsY-aukjHoP",
}

local notifyIfRarity = {
    ["Rare"] = false,
    ["Epic"] = false,
    ["Legendary"] = false,
    ["Mythic"] = false,
    ["Secret"] = false,
}
local bannerName = "Standard"

local sellOfRarity = {
    ["Rare"] = true,
    ["Epic"] = true,
    ["Legendary"] = true,
    ["Mythic"] = false,
    ["Secret"] = false,
}


local VirtualInputManager = game:GetService("VirtualInputManager")
local function clickGui(gui, offsetY)
    local width, height = gui.AbsoluteSize.X, gui.AbsoluteSize.Y
    local x, y = gui.AbsolutePosition.X, gui.AbsolutePosition.Y
    local centerX, centerY = x + width / 2, y + height / 2
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY + offsetY, 0, true, game, 0)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY + offsetY, 0, false, game, 0)
    print("Clicking")
end

if game.Players.LocalPlayer.PlayerGui.PAGES.SettingsUI.ListFrame["Settings Auto Sell Deletes Shinies"].Frame.BooleanButton.StatusLabel.Text == "Off" then
    clickGui(game:GetService("Players").LocalPlayer.PlayerGui.TopBar.HolderFrame.Left.dropDown, 25)
    wait(0.3)
    clickGui(game.Players.LocalPlayer.PlayerGui.TopBar.HolderFrame.Left.dropDown.DropdownFrame.Settings, 25)
    local oldLayout = game.Players.LocalPlayer.PlayerGui.PAGES.SettingsUI.ListFrame
        ["Settings Auto Sell Deletes Shinies"].LayoutOrder

    game.Players.LocalPlayer.PlayerGui.PAGES.SettingsUI.ListFrame["Settings Auto Sell Deletes Shinies"].LayoutOrder = 1
    wait(0.3)
    clickGui(
        game.Players.LocalPlayer.PlayerGui.PAGES.SettingsUI.ListFrame["Settings Auto Sell Deletes Shinies"].Frame
        .BooleanButton, 25)
    wait(0.3)
    game.Players.LocalPlayer.PlayerGui.PAGES.SettingsUI.ListFrame["Settings Auto Sell Deletes Shinies"].LayoutOrder =
        oldLayout
    wait(0.3)
    clickGui(game.Players.LocalPlayer.PlayerGui.PAGES.SettingsUI.CloseButton, 25)
end

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

--game:GetService("ReplicatedStorage").Remotes.FirstTimeSummon:InvokeServer()


-- redeem code
--for i, v in codes do
--game:GetService("ReplicatedStorage").Remotes.UseCode:InvokeServer(v)
--task.wait(0.1)
--end


-- changed to tickets

spawn(function()
    Remote_Manager.FireSafeEnvironment("UNIT_EQUIP_BEST", {})
    while wait(10) do
        Remote_Manager.FireSafeEnvironment("UNIT_EQUIP_BEST", {})
    end
end)

print("Loading")
local rarityConvert = {
    [2] = "Rare",
    [3] = "Epic",
    [4] = "Legendary",
    [5] = "Mythic",
    [6] = "Secret"
}

function save()
    return game:GetService("ReplicatedStorage").Remotes.GetInventory:InvokeServer()
end

-- check inventory for troops of rarity
local UnitData = require(game:GetService("ReplicatedStorage").Modules.Bins.UnitData)
local unitDataV2 = {}

for i, v in UnitData do
    unitDataV2[i] = v.Rarity
end

-- get gem using UI 
local gems = game:GetService("Players").LocalPlayer.PlayerGui.HUD.Toolbar.CurrencyList.Gems.TextLabel

function getGems()
    return tonumber(gems.Text)
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
    while wait(1) do
Remote_Manager.FireSafeEnvironment("UNIT_SELL", { sellTable })
end
end)

print("Buying")
-- summon till you cant afford
repeat
    print("Buying 10 by 10")
    -- [detected] game:GetService("ReplicatedStorage").Remotes.Summon:InvokeServer("Standard", 1)
    spawn(function()
        Remote_Manager.InvokeSafeEnvironment("SUMMON", { bannerName, 10 })
    end)
    wait(0.5)
until getGems() < 100


repeat
    print("buying 1 by 1")
    spawn(function()
        Remote_Manager.InvokeSafeEnvironment("SUMMON", { bannerName, 1 })
    end)
until getGems() < 10


function webhook(url, data)
    pcall(function()
        local newdata = game:GetService("HttpService"):JSONEncode(data)

        local headers = {
            ["content-type"] = "application/json"
        }

        request = http_request or request or HttpPost or syn.request
        local a = { Url = url, Body = newdata, Method = "POST", Headers = headers }

        request(a)
    end)
end

for i, v in save().Units do
    local rarity = rarityConvert[unitDataV2[v.Type]]

    -- send webhook if got troop
    if notifyIfRarity[rarity] then
        webhook(
            webhooks[rarity],
            {
                ["content"] = game.Players.LocalPlayer.Name .. " rolled a rare troop",
                ["username"] = "Anime defender",
                ["embeds"] = {
                    {
                        ["title"] = game.Players.LocalPlayer.Name ..
                            " got a: " .. rarity .. " " .. v.Type,
                        ["type"] = "rich",
                        ["color"] = 8388736,
                        ["author"] = {
                            ["name"] = game.Players.LocalPlayer.Name,
                        }

                    }
                }
            })
    end
end


