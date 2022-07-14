-- .rinitrc.client.lua
-- Coltrane Willsey
-- 2022-07-13 [23:03]

local common = game:GetService("ReplicatedStorage"):WaitForChild("common")
local Packages = common:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("knit"))

local Modules = common:WaitForChild("Modules")
local pkeys = require(Modules:WaitForChild("pkeys"))
local bind = require(Modules:WaitForChild("bind"))
local new = require(Modules:WaitForChild("new"))

-- function getDeps()
--     return {
--         Rorg = Knit.GetController("Rorg");
--         bspr = Knit.GetController("bspr");
--         srhkd = Knit.GetController("srhkd");
--     }
-- end

function main()
    -- Get dependencies
    -- local Deps = getDeps()
    local Rorg = Knit.GetController("Rorg")

    -- Create display
    local Display = new("ScreenGui", Knit.Player.PlayerGui, {
        Name = "Display";
        ResetOnSpawn = false;
        IgnoreGuiInset = true;
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    })
    -- Deps.Rorg.RandR(Display, true)
    Rorg.RandR(Display, true)

    -- Bind debug keys
    bind({ Enum.KeyCode.N }, function()
        Rorg.CreateWindow("Rx")
    end)
    bind({ Enum.KeyCode.X }, function()
        Rorg.DestroyWindow(#Rorg.GetWindows())
    end)
    bind({ Enum.KeyCode.D }, function()
        print(pkeys(Rorg.GetDisplays(), '\n'))
    end)
    bind({ Enum.KeyCode.W }, function()
        print(pkeys(Rorg.GetWindows(), '\n'))
    end)
end

Knit.OnStart()
:andThen(main)
:catch(warn)
