local codes = {
    "TIKTOK50K",
    "ROST10K",
    "SLAYER",
    "LATEUPDATESORRY"
}

local autoDeleteRarity = {
    "Rare",
}

local notifyIfRarity = {
    "Epic",
    "Legendary",
    "Mythic",
    "Secret"
}

local webhooks = {
    ["Epic"] = "https://discord.com/api/webhooks/1277944088728961084/x8E5vTzZ5xCxRrzXbI5ykOZ46lj4KQZPMEVGR8EuhBpq7xxHWRavCNdsij_MZ99EkE8r",
    ["Legendary"] = "https://discord.com/api/webhooks/1277944088728961084/x8E5vTzZ5xCxRrzXbI5ykOZ46lj4KQZPMEVGR8EuhBpq7xxHWRavCNdsij_MZ99EkE8r",
    ["Mythic"] = "https://discord.com/api/webhooks/1276076987437289564/nGbqKiWhsIInnzPE0j79rCCuKFS7S7YAu4Ia2-RQL1BWBkFzFJS-gGMMtbUP0yJq4uyQ",
    ["Secret"] = "https://discord.com/api/webhooks/1276076911738753074/rYYm1C5-btuAF9tjTzHQr0NrysCvgrIWE8X0DxE4XG5wbsCViO0wP0KCCYlVOLEevafU"
}


local summonCFrame = CFrame.new(-377.539185, 50.9425964, 746.048828, -0.977286458, -5.76542156e-08, -0.211922646,
    -4.38978809e-08, 1, -6.96169593e-08, 0.211922646, -5.8732752e-08, -0.977286458)
local units = game:GetService("Players").LocalPlayer.PlayerGui.Windows.Units.Holder.Main.Units

repeat wait(1) until game:IsLoaded()

--#region funcs


local unitHandler = require(game:GetService("StarterPlayer").Modules.Interface.Loader.Windows.UnitWindowHandler)

function notify(data, url)
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

function sellRare()
    local idToName = {}

    for i, v in next, game:GetService("Players").LocalPlayer.PlayerGui.Windows.Units.Holder.Main.Units:GetChildren() do
        pcall(function()
            idToName[v.Name] = v.Holder:FindFirstChildOfClass("UIGradient").Name
        end)
    end


    function getUnits()
        return unitHandler._Cache
    end

    local sellTable = {}

    for i, v in next, getUnits() do
        local rarity = idToName[i]
        if rarity and rarity == "Rare" then
            table.insert(sellTable, i)
        end
    end

    game:GetService("ReplicatedStorage").Networking.Units.SellEvent:FireServer(sellTable)
end

function summon(type)
    game:GetService("ReplicatedStorage").Networking.Units.SummonEvent:FireServer(type, 'Special')
    sellRare()
end

function doStarterDialog()
    local fileName = game.Players.LocalPlayer.Name .. "doneDialog" .. ".txt"
    if isfile(fileName) then return end

    local args = {
        [1] = "Interact",
        [2] = {
            [1] = "StarterUnitDialogue",
            [2] = 2,
            [3] = "Yeah!"
        }
    }

    game:GetService("ReplicatedStorage").Networking.State.DialogueEvent:FireServer(unpack(args))


    local args = {
        [1] = "Select",
        [2] = "Roku"
    }

    game:GetService("ReplicatedStorage").Networking.Units.UnitSelectionEvent:FireServer(unpack(args))

    writefile(fileName, "")
end

function enableAutoSell(rarity)
    local fileName = game.Players.LocalPlayer.Name .. "setRarity" .. rarity .. ".txt"
    if isfile(fileName) then return end

    game:GetService("ReplicatedStorage").Networking.Settings.SettingsEvent:FireServer('Toggle', rarity)

    writefile(fileName, "")
end

function getGems()
    local text = game:GetService("Players").LocalPlayer.PlayerGui.HUD.Main.Currencies.Gems.Gems.Text

    text = text:gsub(",", "")
    text = tonumber(text)

    return text
end

--#endregion

doStarterDialog()

for i, v in next, codes do
    game:GetService("ReplicatedStorage").Networking.CodesEvent:FireServer(v)

    wait(0.5)
end

wait(1)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = summonCFrame

wait(0.5)
game:GetService("ReplicatedStorage").Networking.ClientListeners.TutorialEvent:FireServer('SaveTutorial', "SummonTutorial")
game:GetService("ReplicatedStorage").Networking.ClientListeners.TutorialEvent:FireServer('ClaimTutorial',
    "SummonTutorial")

wait(0.5)

for i, v in next, autoDeleteRarity do
    enableAutoSell(v)
    wait(0.3)
end

-- claim all

local args = {
    [1] = "ClaimAll"
}

game:GetService("ReplicatedStorage").Networking.Units.CollectionEvent:FireServer(unpack(args))


units.ChildAdded:Connect(function(child)
    child:WaitForChild("Glow")
    child:WaitForChild("Holder")
    local rarity = child.Glow:FindFirstChildOfClass("UIGradient").Name
    local name = child.Holder.Main.UnitName.Text

    if table.find(notifyIfRarity, rarity) then
        local data = {
            ["content"] = game.Players.LocalPlayer.Name .. " summoned unit",
            ["username"] = "notify",
            ["embeds"] = {
                {
                    ["title"] = name,
                    ['description'] = "got " .. rarity .. " unit " .. name,
                    ["type"] = "rich",
                    ["color"] = 8388736
                }
            }
        }
        notify(data, webhooks[rarity])
    end
end)

while getGems() >= 500 do
    summon('SummonTen')
    wait(0.5)
end

while getGems() >= 50 do
    summon('SummonOne')
    wait(0.5)
end


local unitPath = game:GetService("Players").LocalPlayer.PlayerGui.Windows.Units.Holder.Main.Units
local units = {}

local rarityDictator = {
    ["Rare"] = 1,
    ["Epic"] = 2,
    ["Legendary"] = 3,
    ["Mythic"] = 4,
    ["Secret"] = 5,
}

-- Function to sort units based on rarity and level
function compareUnits(a, b)
    -- Compare rarity first
    if rarityDictator[a.rarity] ~= rarityDictator[b.rarity] then
        return rarityDictator[a.rarity] > rarityDictator[b.rarity]
    else
        -- If rarity is the same, compare levels
        return a.level > b.level
    end
end

function getBestMount()
    units = {}

    -- Loop through each unit in the unitPath
    for i, v in next, unitPath:GetChildren() do
        if not v:FindFirstChild("Holder") then continue end
        local rarity = v.Holder:FindFirstChildOfClass("UIGradient").Name
        local level = tonumber(v.Holder.Main.LevelFrame.Level.Text)
        local name = v.Holder.Main.UnitName.Text
        local id = v.Name -- ID is the name of the instance

        -- Store the unit details in the units table
        table.insert(units, { name = name, level = level, rarity = rarity, id = id })
    end

    -- Sort the units by rarity and level
    table.sort(units, compareUnits)

    -- Return the sorted list of units
    return units
end

local unlockedN = 0
function getMaxUnlockedSlots()
    unlockedN = 0
    for i, v in next, game:GetService("Players").LocalPlayer.PlayerGui.HUD.Main.Units:GetChildren() do
        if not v:IsA("Frame") then continue end
        if not v:FindFirstChild("Locked") or v:FindFirstChild("Locked") and not v.Locked.Visible then
            unlockedN = unlockedN + 1
        end
    end
    return unlockedN
end

local max = getMaxUnlockedSlots()
local equipped = 0

for i, v in next, getBestMount() do
    if equipped < max then
        game:GetService("ReplicatedStorage").Networking.Units.EquipEvent:FireServer("Equip", v.id)

        equipped = equipped + 1
    end
end



writefile(game.Players.LocalPlayer.Name .. '.txt', "Yummytool")
