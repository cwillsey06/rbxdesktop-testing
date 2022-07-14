-- Rx.lua
-- Coltrane Willsey
-- 2022-07-14 [01:52]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Component = require(Packages.component)

local Modules = common.Modules
local new = require(Modules.new)

local Rx = Component.new { Tag = "Rx"; }

function Rx:Echo(...: string)
    local lines = {...}
    for _, line in ipairs(lines) do
        new("TextLabel", self.Content, {
            Name = "Output";
            BackgroundTransparency = 1;
            Size = UDim2.fromScale(1, 0);
            AutomaticSize = Enum.AutomaticSize.Y;
            TextXAlignment = Enum.TextXAlignment.Left;
            TextYAlignment = Enum.TextYAlignment.Top;
            Text = line;
        })
    end
    self.Content.CanvasPosition = Vector2.new(0, math.huge)
end

function Rx:Construct()
    local scrollMiddle = "rbxasset://textures/ui/Scroll/scroll-middle.png"
    self.Content = new("ScrollingFrame", nil, {
        Name = "RxContent";
        BackgroundTransparency = 1;
        Size = UDim2.fromScale(1, 1);
        CanvasSize = UDim2.fromScale(0, 0);
        AutomaticSize = Enum.AutomaticSize.Y;
        ScrollBarThickness = 6;
        TopImage = scrollMiddle;
        BottomImage = scrollMiddle;
    })
    new("UIListLayout", self.Content, {
        VerticalAlignment = Enum.VerticalAlignment.Bottom;
    })
end

function Rx:Start()
    self.Content.Parent = self.Instance
    self:Echo("Hello, Rx!")
end

function Rx:Destroy()
    self.Instance:Destroy()
end

return Rx
