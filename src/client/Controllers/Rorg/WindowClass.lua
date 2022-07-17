-- WindowClass.lua
-- Coltrane Willsey
-- 2022-07-14 [00:00]

export type WindowProperties = {
    Title: string?;
    Display: number?;
    OverrideWM: boolean?;
    Position: Vector2?;
    Size: Vector2?;
}

local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local common = game:GetService("ReplicatedStorage").common
local Packages = common.Packages
local Caretaker = require(Packages.caretaker)
local Signal = require(Packages.signal)

local Modules = common.Modules
local new = require(Modules.new)

local WindowClass = {}
WindowClass.__index = WindowClass

function WindowClass:SetContent(content: GuiObject, layer: boolean?)
    if not layer then
        self:RemoveContent()
    end

    content.Parent = self.Window
    self._contentCT:Add(content)
end

function WindowClass:RemoveContent()
    self._contentCT:Destroy()
end

function WindowClass:_createWindow(mount: Instance?, content: (GuiObject | string)?, properties: WindowProperties?)
    assert(not self.Window, "_createWindow has already been called")

    local WindowCanvas = new("CanvasGroup", mount, {
        Name = self.GUID;
        Size = properties['Size'] and UDim2.fromOffset(properties.Size.X, properties.Size.Y) or UDim2.fromOffset(500, 300);
        Position = properties['Position'] and UDim2.fromOffset(properties.Position.X, properties.Position.Y) or UDim2.fromOffset(0, 0);
        -- TODO: Implement other window properties
    })

    self._caretaker:Add(WindowCanvas)

    self.Window = WindowCanvas

    if typeof(content) == "Instance" then
        self:SetContent(content)
    elseif typeof(content) == "string" then
        CollectionService:AddTag(WindowCanvas, content)
    end
end

function WindowClass.new(mount: Instance?, content: GuiObject?, properties: WindowProperties?)
    properties = properties or {}

    local self = setmetatable({}, WindowClass)
    self._caretaker = Caretaker.new()
    self._contentCT = self._caretaker:Extend()

    self.GUID = HttpService:GenerateGUID()
    self.Title = properties['Title'] or self.Title
    self.OverrideWM = properties['OverrideWM'] or false

    -- task.defer(self._createWindow, self, mount, content, properties)
    self:_createWindow(mount, content, properties)

    self.WindowCreating = Signal.new()
    self.WindowCreated = true

    self.WindowDestroying = Signal.new()
    self.WindowDestroyed = false

    self._caretaker:Add(self.WindowCreating)
    self._caretaker:Add(self.WindowDestroying)

    return self
end

function WindowClass:Destroy()
    self._caretaker:Destroy()
end

return WindowClass
