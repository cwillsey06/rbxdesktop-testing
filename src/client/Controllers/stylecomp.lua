-- stylecomp.lua
-- Coltrane Willsey
-- 2022-07-14 [01:13]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)

local Modules = common.Modules
local tween = require(Modules.tween)

local stylecomp = Knit.CreateController { Name = "stylecomp"; }

function stylecomp:KnitInit()
    self.deps = {
        Rorg = Knit.GetController("Rorg");
    }
end

function stylecomp:KnitStart()
    local Rorg = self.deps.Rorg
    Rorg.WindowCreated:Connect(function(WindowObj)
        WindowObj.Window.GroupTransparency = 1
        tween(WindowObj.Window, {GroupTransparency = 0}, 0.2)
    end)
end

return stylecomp
