local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage:FindFirstChild("Fusion", true))
local createAcrylic = require(script.Parent.CreateAcrylic)
local viewportPointToWorld, getOffset = unpack(require(script.Parent.Utils))

local function createAcrylicBlur(distance)
	local cleanups = {}

    distance = distance or 0.001
    local positions = {
        topLeft = Vector2.new(),
        topRight = Vector2.new(),
        bottomRight = Vector2.new()
    }
    local model = createAcrylic(Fusion.Value(true))
    model.Parent = workspace

    local function updatePositions(size, position)
        positions.topLeft = position
        positions.topRight = position + Vector2.new(size.X, 0)
        positions.bottomRight = position + size
    end

    local function render()
        local res = workspace.CurrentCamera
        if res then
            res = res.CFrame
		end
		local cond = res
		if not cond then
			cond = CFrame.new()
		end
		
		local camera = cond
        local topLeft = positions.topLeft
        local topRight = positions.topRight
        local bottomRight = positions.bottomRight

        local topLeft3D = viewportPointToWorld(topLeft, distance)
        local topRight3D = viewportPointToWorld(topRight, distance)
        local bottomRight3D = viewportPointToWorld(bottomRight, distance)
		--[[
		print(topLeft3D)
		print(topRight3D)
		print(bottomRight3D)
		--]]
        local width = (topRight3D - topLeft3D).Magnitude
        local height = (topRight3D - bottomRight3D).Magnitude

        model.CFrame = CFrame.fromMatrix(
            (topLeft3D + bottomRight3D) / 2,
            camera.XVector,
            camera.YVector,
            camera.ZVector
        )
        model.Mesh.Scale = Vector3.new(width, height, 0)
    end

    local function onChange(rbx)
        local offset = getOffset()
        local size = rbx.AbsoluteSize - Vector2.new(offset, offset)
        local position = rbx.AbsolutePosition + Vector2.new(offset / 2, offset / 2)

        updatePositions(size, position)
        task.spawn(render)
    end

    local function renderOnChange()
        local camera = workspace.CurrentCamera
        if not camera then
            return
        end
		
        table.insert(cleanups, camera:GetPropertyChangedSignal("CFrame"):Connect(render))
		table.insert(cleanups, camera:GetPropertyChangedSignal("ViewportSize"):Connect(render))
		table.insert(cleanups, camera:GetPropertyChangedSignal("FieldOfView"):Connect(render))
        task.spawn(render)
    end

	model.Destroying:Connect(function()
		for _, item in cleanups do
			if item:IsA("RBXScriptConnection") then
				item:Disconnect()
			end
		end
	end)

	renderOnChange()

    return onChange, model
end

return function(distance)
	local onChange, model = createAcrylicBlur(distance)
	
	local comp; comp = Fusion.New "Frame" {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		[Fusion.OnChange "AbsoluteSize"] = function()
			onChange(comp)
		end,
		[Fusion.OnChange "AbsolutePosition"] = function()
			onChange(comp)
		end,
		[Fusion.Cleanup] = model
	}
	
	return comp
end