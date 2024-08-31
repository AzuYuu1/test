local type = "pet"
local users = {
"XjOwBYKKCXR",
"JOybTyLKLIR",
"ZmlMZZWyBdb",
"JJnAYDRHEcy",
"sThHGofybkL",
"fMsHvbgCtKW",
"xtveiQnpYxR",
"seHCguCnjdV",
"ymJSrejQDom",
"ydTqqQItxMh",
"LUNlZNsVBbA",
"tIPXEwwBWMY",
"RXPpMUBkRtw",
"YmAjlHtSaKB",
"PnReUiiLVSb",
"umfybxkwoAg",
"cwnnulADClr",
"AMWkwZAIivt",
"kTOiUjDIhkf",
"WGQCeSqYpyp",
"SSEalbvpkgb",
"pyUEJjUSWNL",
"oimoagLbxIk",
"qbsQvIICBnL",
"JqXKPRDKmYu",

}


local save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
local theId = nil
for i, v in pairs(save.Get().Inventory.Pet) do
    if type == "pet" and v.id == "Chef Monkey" then
        theId = i
    end
end


for i, v in pairs(users) do
    game:GetService("ReplicatedStorage").Network["Mailbox: Send"]:InvokeServer(v,
        tostring(math.random(1, 100)), "Pet", theId, 50)
    task.wait(1)
end
