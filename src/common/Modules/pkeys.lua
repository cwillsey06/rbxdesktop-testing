-- printkeys.lua
-- Coltrane Willsey
-- 2022-07-14 [00:15]

function printkeys(t: {[string]: any?}, sep: string?): string
    local s = ''
    for k, _ in pairs(t) do
        s ..= tostring(k) ..(sep or ' ')
    end
    return s:sub(0, -2)
end

return printkeys