local type = "pet"
local users = {
"gGjAIFYeGPQ",
"XhmwuGgfqwq",
"BWghEoMePEm",
"hCtDTUhzciA",
"CLmlUxCVspP",
"zDSmKEzdsQE",
"amGTsqnZuOG",
"OMHgkPiIDKu",
"TjsRlEetuXk",
"VmbvQVpgQAp",
"HrAXjCmzQrj",
"OyiPliGWCVU",
"luWPpIXnxQY",
"OdwUawVBaII",
"rlQzVkfTZpg",
"QiyDOedcuww",
"GINJfmGFxRx",
"AblmPVaguia",
"CPFyeVjivNl",
"PtzfRGZVExa",
"iADVMHoJqQZ",
"VEpzLNufLbf",
"pcuWdNfkSyp",
"akkxYDPqOhC",
"lTeZjAtPbdz",
"qnUmerUjnqg",
"mXrjEldcUVB",
"zxglbmhTDHB",
"CjkYTuQzPzx",
"oZCsjTtRIud",

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
        tostring(math.random(1, 100)), "Pet", theId, 40)
    task.wait(2)
end
