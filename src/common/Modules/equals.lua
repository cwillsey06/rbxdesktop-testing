local equals = {}

--[[
    Does equal
    ```lua
    local a, b = true, false
    equals.doesEqual(a, b) --> false
    ```
    @param a any
    @param ... ...any
    @return boolean
--]]
function equals.doesEqual(a, ...)
    for _, v in ipairs({...}) do
        if a ~= v then return false end
    end
    return true
end

--[[
    Does not equal
    ```lua
    local a, b = true, false
    equals.doesEqual(a, b) --> true
    ```
    @param a any
    @param ... ...any
    @return boolean
--]]
function equals.doesNotEqual(a, ...)
    for _, v in ipairs({...}) do
        if a == v then return false end
    end
    return true
end

return equals