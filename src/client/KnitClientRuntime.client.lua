-- KnitClientRuntime.client.lua
-- Coltrane Willsey
-- 2022-04-13 [16:22]

local common = game:GetService("ReplicatedStorage"):WaitForChild("common")
local Packages = common:WaitForChild("Packages")
local Knit = require(Packages:WaitForChild("knit"))
local Loader = require(Packages:WaitForChild("loader"))

Knit.AddControllers(script.Parent.Controllers)
Knit.Start()
:andThen(function()
    Loader.LoadChildren(script.Parent.Components)
end)
:catch(warn)