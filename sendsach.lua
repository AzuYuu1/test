local type = "enchant"
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
"WhFbEotYcGk",
"mDxEHHglBph",
"dsdDpQKwRPU",
"poCRHnnBySr",
"YrOBOxWURjY",
"zTixBHIeJBn",
"XYdpKJEiMnV",
"bEUAQCWBSzy",
"ZfnKojCwSlY",
"xKmESeRLmGt",
"FqugsUrEvfP",
"sLFuePZwNjd",
"hQngBqdNwjG",
"ElTvvyfBvde",
"yGMznCIYEoS",
"jBHoijooNvr",
"pybBLaBRqfQ",
"UFrZmBOhblg",
"AboDbmDOWEo",
"fmSlAgMiNdx",
"GexLqnEPdwR",
"quFEgLeFRgV",
"JanviVLUIrh",
"BBDoTbDMiPr",
"ZoNgqPSLnlk",


}


local save = require(game:GetService("ReplicatedStorage").Library.Client.Save)
local theId = nil
for i, v in pairs(save.Get().Inventory.Enchant) do
    if type == "enchant" and v.id == "Coins" then
        theId = i
    end
end


for i, v in pairs(users) do
    game:GetService("ReplicatedStorage").Network["Mailbox: Send"]:InvokeServer(v,
        tostring(math.random(1, 100)), "Enchant", theId, 1)
    task.wait(1)
end
