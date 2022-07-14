-- tween.lua
-- Coltrane Willsey
-- 2022-04-27 [08:40]

local TweenService = game:GetService("TweenService")

--[=[
    TweenService wrapper that makes tweening easy!

    ```lua
    local Tween = tween(
        Part,
        {
            ["Color"] = Color3.new(1, 0, 0);
            ["Size"] = Vector3.new(4, 4, 4);
        },
        1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.InOut
    )
    ```

    @param instance Instance
    @param goals {[string]: any}
    @param tweenTime number?
    @param tweenStyle Enum.EasingStyle?
    @param tweenDirection Enum.EasingDirection?

    @return Tween
--]=]
function tween(instance: Instance, goals: {[string]: any}, tweenTime: number?, tweenStyle: Enum.EasingStyle?, tweenDirection: Enum.EasingDirection?): Tween
    local Info = TweenInfo.new(tweenTime or 1, tweenStyle or Enum.EasingStyle.Linear, tweenDirection or Enum.EasingDirection.Out)
    local Tween = TweenService:Create(instance, Info, goals)

    task.defer(function()
        Tween.Completed:Wait()
        Tween:Destroy()
    end)

    Tween:Play()
    return Tween
end

return tween