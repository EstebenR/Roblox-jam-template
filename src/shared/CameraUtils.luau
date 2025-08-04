local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local CameraUtils = {}

local updateConn: RBXScriptConnection? = nil
local fromCF: CFrame = nil
local toCF: CFrame = nil
local animationTime: number, targetTime: number = 0, 0
local callback = nil

function CameraUtils.CreateCamBlock(fromCamera: Camera, key: Enum.KeyCode?)
	local camBlock = Instance.new("Part")
	camBlock.Name = "CameraBlock"
	camBlock.Anchored = true
	camBlock.CanCollide = false
	camBlock.Transparency = 1
	camBlock.Size = Vector3.new(0.1, 0.1, 0.1)
	camBlock.CFrame = fromCamera.CFrame
	camBlock.Parent = workspace

	local info = Instance.new("NumberValue")
	info.Name = "FOV"
	info.Parent = camBlock
	info.Value = fromCamera.FieldOfView

	if key then
		--store key as string value inside camblock for later retrieval
		local keyVal = Instance.new("NumberValue")
		keyVal.Name = "Key"
		keyVal.Parent = camBlock
		keyVal.Value = key.Value
	end

	CollectionService:AddTag(camBlock, "SetCamera")

	return camBlock
end

function CameraUtils.ExportCurrentView(key: Enum.KeyCode?)
	local camBlock = CameraUtils.CreateCamBlock(workspace.CurrentCamera, key)
	return camBlock
end

function CameraUtils.CopyCam(fromCameraBlock: Part)
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	workspace.CurrentCamera.CFrame = fromCameraBlock.CFrame
	local fovVal = fromCameraBlock:FindFirstChild("FOV")
	if fovVal and fovVal:IsA("NumberValue") then
		workspace.CurrentCamera.FieldOfView = fovVal.Value
	end
	--local cam = Instance.new("Camera")
	--cam.CFrame = fromCameraBlock.CFrame
	--cam.FieldOfView = fromCameraBlock.FOV.Value
	--cam.Parent = workspace

	--workspace.CurrentCamera = cam
end

local function OnRenderStepped(dt: number)
	if animationTime > 0 then
		--TODO easing?
		animationTime -= dt

		local lerpVal = 1 - animationTime / targetTime
		workspace.CurrentCamera.CFrame = fromCF:Lerp(toCF, lerpVal)
	else
		if updateConn then
			updateConn:Disconnect()
			updateConn = nil
		end
		if callback then
			callback()
		end
	end
end

function CameraUtils.TweenCamToCFrame(cf: CFrame, time: number, onFinish: () -> ())
	fromCF = workspace.CurrentCamera.CFrame

	toCF = cf

	animationTime = time
	targetTime = animationTime

	updateConn = RunService.RenderStepped:Connect(OnRenderStepped)
	callback = onFinish
end

function CameraUtils.fitSphereToCamera(radius: number, fovDeg: number?, aspectRatio: number?): number
	local halfFov = 0.5 * math.rad(fovDeg or workspace.CurrentCamera.FieldOfView)
	if aspectRatio == nil then
		aspectRatio = workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y
	end
	if aspectRatio < 1 then
		halfFov = math.atan(aspectRatio * math.tan(halfFov))
	end

	return radius / math.tan(halfFov)
end

--Returns distance to move the camera back from the bounding box
function CameraUtils.fitBoundingBoxToCamera(size: Vector3, fovDeg: number?, aspectRatio: number?): number
	local radius = size.Magnitude / 2

	return CameraUtils.fitSphereToCamera(radius, fovDeg, aspectRatio)
end

return CameraUtils
