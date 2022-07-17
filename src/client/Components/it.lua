-- it-bg.lua
-- Coltrane Willsey
-- 2022-07-16 [20:59]

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Component = require(Packages.component)

local Modules = common.Modules
local new = require(Modules.new)

local it = Component.new { Tag = "it"; }

function it:makeBg(imageId: string, fillType: Enum.ScaleType)
    self.Content.Image = imageId;
    self.Content.ScaleType = fillType or Enum.ScaleType.Fit;

    self.Instance.Size = UDim2.fromScale(1, 1);
    self.Instance.Position = UDim2.fromScale(0, 0);
    self.Instance.ZIndex = -1000
    self.Instance:SetAttribute("Unmanaged", true)
end

function it:Construct()
    self.Content = new("ImageLabel", nil, {
        Size = UDim2.fromScale(1, 1);
        BackgroundTransparency = 1;
        Image = '';
    })
end

function it:Start()
    self.Content.Parent = self.Instance
end

function it:Destroy()
    self.Instance:Destroy()
end

return it
