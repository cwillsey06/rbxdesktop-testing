-- Rorg.lua
-- Coltrane Willsey
-- 2022-07-13 [22:56]

local WindowClass = require(script.WindowClass)

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Signal = require(Packages.signal)
local Knit = require(Packages.knit)

local Modules = common.Modules
local new = require(Modules.new)

local Rorg = Knit.CreateController{
    Name = "Rorg";

    Displays = {};
    Windows  = {};

    WindowCreated   = Signal.new();
    WindowDestroyed = Signal.new();
}
---@diagnostic disable-next-line: undefined-type
function Rorg.CreateWindow(windowContent: (GuiObject | string)?, properties: WindowClass.WindowProperties?)
    assert(Rorg.Displays.Primary, "No primary display detected")

    local Window = WindowClass.new(Rorg.Displays.Primary, windowContent, properties)
    table.insert(Rorg.Windows, Window)
    Rorg.WindowCreated:Fire(Window)

    return Window
end

function Rorg.DestroyWindow(index: number, callback: (string) -> ()?)
    assert(Rorg.Windows[index], ("Window '%s' not found"):format(index))

    Rorg.Windows[index]:Destroy()
    Rorg.Windows[index] = nil
    Rorg.WindowDestroyed:Fire()

    if callback then
        callback(index)
    end
end

function Rorg.RandR(Display: GuiBase | GuiObject, isPrimary: boolean?, rotation: number?)
    local namespace = (isPrimary or #Rorg.Displays < 1) and "Primary" or "Display-".. tostring(#Rorg.Displays + 1)
    if Rorg.Displays[namespace] then
        Rorg.Displays[namespace]:Destroy()
        Rorg.Displays[namespace] = nil
    end

    local DisplayCanvas = new("CanvasGroup", Display, {
        Name = "RDisplayCanvas";
        Size = UDim2.fromScale(1, 1);
        Rotation = rotation;
    })

    Rorg.Displays[namespace] = DisplayCanvas
end

function Rorg.GetDisplays()
    return Rorg.Displays
end

function Rorg.GetWindows()
    return Rorg.Windows
end

--

function Rorg:KnitInit()
end

function Rorg:KnitStart()
end

return Rorg
