local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage:FindFirstChild("Fusion", true))

local AcrylicBlur = require(script.Parent.AcrylicBlur)

return function(props)
    local comp = Fusion.New "Frame" {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 0.9,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,

        [Fusion.Children] = {
            AcrylicBlur(),

            Fusion.New "UICorner" {
                CornerRadius = UDim.new(0, 8)
            },

            Fusion.New "Frame" {
                BackgroundColor3 = Color3.fromRGB(28, 31, 40),
                BackgroundTransparency = 0.4,
                Size = UDim2.fromScale(1, 1),
                BorderSizePixel = 0,

                [Fusion.Children] = {
                    Fusion.New "UICorner" {
                        CornerRadius = UDim.new(0, 8)
                    },
                },
            },

            Fusion.New "Frame" {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 0.4,
                Size = UDim2.fromScale(1, 1),
                BorderSizePixel = 0,

                [Fusion.Children] = {
                    Fusion.New "UICorner" {
                        CornerRadius = UDim.new(0, 8)
                    },

                    Fusion.New "UIGradient" {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromHex("#252221")),
                            ColorSequenceKeypoint.new(1, Color3.fromHex("#171515"))
                        }),
                        Rotation = 90,
                    },
                },
            },

            Fusion.New "ImageLabel" {
                Image = "rbxassetid://9968344105",
                ImageTransparency = 0.98,
                ScaleType = Enum.ScaleType.Tile,
                TileSize = UDim2.new(0, 128, 0, 128),
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,

                [Fusion.Children] = {
                    Fusion.New "UICorner" {
                        CornerRadius = UDim.new(0, 8)
                    },
                },
            },

            Fusion.New "ImageLabel" {
                Image = "rbxassetid://9968344227",
                ImageTransparency = 0.85,
                ScaleType = Enum.ScaleType.Tile,
                TileSize = UDim2.new(0, 128, 0, 128),
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,

                [Fusion.Children] = {
                    Fusion.New "UICorner" {
                        CornerRadius = UDim.new(0, 8)
                    },
                },
            },

            Fusion.New "Frame" {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                ZIndex = 2,

                [Fusion.Children] = {
                    Fusion.New "UICorner" {
                        CornerRadius = UDim.new(0, 8)
                    },

                    Fusion.New "UIStroke" {
                        Color = Color3.fromHex("#606060"),
                        Transparency = 0.5,
                        Thickness = 1.5,
                    },
                },
            },
        },
    }

    return Fusion.Hydrate(comp)(props or {})
end