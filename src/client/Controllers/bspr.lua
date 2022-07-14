-- bspr.lua
-- Coltrane Willsey
-- 2022-07-13 [23:21]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Knit = require(Packages.knit)

local bspr = Knit.CreateController { Name = "bspr"; }



--

function bspr:KnitInit()
end

function bspr:KnitStart()
end

return bspr
