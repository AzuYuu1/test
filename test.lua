repeat wait() until game:IsLoaded();
    if _G.Script_Mode=="PVP"then 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadP.lua",true))()
    elseif _G.Script_Language=="Thai"then 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadTh.lua",true))()
    elseif getgenv().Script_Mode=="Kaitun_Script"then 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadKT.lua",true))()
    else 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadNormal.lua",true))()
    end 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadKL.lua",true))()
elseif 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/CreamSoScute/main/LoadAm.lua",true))()
end
