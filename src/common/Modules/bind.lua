-- bind.lua
-- Coltrane Willsey
-- 2022-03-13 [16:54]

local UserInputService = game:GetService("UserInputService")

local binding = {}
binding.__index = binding

--[[
    ```lua
    local binding = bind({Enum.KeyCode.A, Enum.KeyCode.B, Enum.KeyCode.C}, function(inputObject)
        print("Key".. inputObject.KeyCode .."was pressed")
    end, "Ended")
    -- later
    binding:unbind()
    ```
    @param inputTypes {Enum.KeyCode | Enum.UserInputType}
    @param callback () -> (InputObject)
    @param state string?
    @return binding
--]]
function bind(inputTypes: {Enum.KeyCode | Enum.UserInputType}, callback: () -> (InputObject), state: string?)
    local self = setmetatable({}, binding)

    self.InputConnection = UserInputService["Input".. (state or "Began")]:Connect(function(obj)
        for _, itype in ipairs(inputTypes) do
            if itype == obj.KeyCode or itype == obj.UserInputType then
                callback(obj)
                return
            end
        end
    end)

    return self
end

function binding:unbind()
    self.InputConnection:Disconnect()
end

return bind