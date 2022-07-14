-- ldbin.lua
-- Coltrane Willsey
-- 2022-07-08 [09:16]

local bins = game:GetService("ReplicatedStorage").common.bin

--[=[
    loadbinary
    ```lua
    ldbin('r')
    -- returns 'r' lib
    ldbin('r', true)
    -- returns 'r' POSIX-like lib
    ```
--]=]
function ldbin(bin: string | ModuleScript, getstandardlib: boolean?)
    local module

    xpcall(function()
        module = require(
            (typeof(bin) == "Instance" and bin:IsA("ModuleScript")) and bin
            or bins[bin]
        )
    end,
    function()
        warn(("Invalid binary '%s'"):format(bin.Name))
    end)

    if getstandardlib then
        xpcall(function()
            module = module.getstandardlib()
        end,
        function()
            warn(("Binary '%s' does not include a standard library"):format(bin.Name))
        end)
    end

    return module
end

return ldbin