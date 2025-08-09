local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local vide = require(ReplicatedStorage.Shared.vide)

local DEFAULT_TIME = 0.3
local WAIT_TIME = 1

local HoleTransition = {}
local screen = nil

function HoleTransition.BouncePart(part: BasePart): RBXScriptSignal<Enum.PlaybackState>
	assert(screen ~= nil, "Hole Screen doesn't exist")

	local cam = workspace.CurrentCamera
	local pos, isIn = cam:WorldToViewportPoint(part.Position)

	if not isIn then
		warn(`Part {part:GetFullName()} is not inside viewport`)
	end

	--Minimum size in screen to grab diameter
	local diameter = part.Size.Magnitude
	local sizedPos = cam:WorldToViewportPoint(part.Position + cam.CFrame.RightVector * diameter)
	local screenSize = sizedPos.X - pos.X + 10

	return HoleTransition.BouncePosition(UDim2.fromOffset(pos.X, pos.Y), UDim2.fromOffset(screenSize, screenSize))
end

function HoleTransition.BouncePosition(pos: UDim2, size: UDim2): RBXScriptSignal<Enum.PlaybackState>
	assert(screen ~= nil, "Hole Screen doesn't exist")

	local beginTwinfo = TweenInfo.new(DEFAULT_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local endTwinfo = TweenInfo.new(DEFAULT_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.In)

	screen.Position = pos
	screen.Size = UDim2.fromScale(1, 1)
	screen.Visible = true

	local first = TweenService:Create(screen, beginTwinfo, { Size = size })
	local second = TweenService:Create(screen, endTwinfo, { Size = UDim2.fromOffset(0, 0) })

	first:Play()
	first.Completed:Once(function()
		task.wait(WAIT_TIME)
		second:Play()
	end)

	return second.Completed
end

function HoleTransition.Hide()
	screen.Visible = false
end

function HoleTransition.Create(color: Color3?): ImageLabel
	if screen then
		return screen
	end

	local targetColor = color or Color3.new(0, 0, 0)

	local frame = vide.create("ImageLabel")({
		Name = "Hole Screen",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Image = "rbxassetid://112783164200405",
		ImageColor3 = targetColor,
		Visible = false,

		vide.create("UIAspectRatioConstraint")({
			AspectType = Enum.AspectType.ScaleWithParentSize,
		}),

		vide.create("Frame")({
			Name = "Left",
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.fromOffset(2000, 1000),
			Position = UDim2.fromScale(1, 0.5),
			BackgroundColor3 = targetColor,
		}),

		vide.create("Frame")({
			Name = "Right",
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.fromOffset(2000, 1000),
			Position = UDim2.fromScale(0, 0.5),
			BackgroundColor3 = targetColor,
		}),

		vide.create("Frame")({
			Name = "Top",
			AnchorPoint = Vector2.new(0.5, 1),
			Size = UDim2.fromOffset(5000, 2000),
			Position = UDim2.fromScale(0.5, 0),
			BackgroundColor3 = targetColor,
		}),

		vide.create("Frame")({
			Name = "Bottom",
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.fromOffset(5000, 2000),
			Position = UDim2.fromScale(0.5, 1),
			BackgroundColor3 = targetColor,
		}),
	})

	screen = frame
	return frame
end

----- Connections

-- ReplicatedStorage.ManualControl.FadeTransparency.Event:Connect(HoleTransition.Fade)

return HoleTransition
