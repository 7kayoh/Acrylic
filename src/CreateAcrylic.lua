local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage:FindFirstChild("Fusion", true))

local function createAcrylic(isEnabled)
    return Fusion.New "Part" {
        Name = "Body",
        Color = Color3.new(0, 0, 0),
        Material = Enum.Material.Glass,
        Size = Vector3.new(1, 1, 0),
        Anchored = true,
        CanCollide = false,
        Locked = true,
        CastShadow = false,
        Transparency = Fusion.Computed(function()
            return isEnabled:get() and 0.999 or 0
        end),

        [Fusion.Children] = {
            Fusion.New "SpecialMesh" {
                MeshType = Enum.MeshType.Brick,
                Offset = Vector3.new(0, 0, -0.000001),
            }
        }
    }
end

return createAcrylic
