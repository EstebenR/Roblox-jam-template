local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Promise = require(ReplicatedStorage.Packages.Promise)
local vide = require(ReplicatedStorage.Shared.vide)

local DEFAULT_TIME = 0.5

local ScreenFader = {}
local screen = nil

local function checkInit(shouldBeInitialized: boolean): boolean
	if screen == nil then
		warn(`ScreenFader is {if shouldBeInitialized then "not" else "already"} initialized`)
		return false
	end
	return true
end

--- Immediately starts fading and returns a promise that resolves with the tween
function ScreenFader.Fade(targetTransparency: number, time: number?, color: Color3?)
	if not checkInit(true) then
		return
	end

	screen.BackgroundColor3 = color or Color3.new(0, 0, 0)

	return Promise.new(function(resolve, reject, onCancel)
		local tweenInfo = TweenInfo.new(time or DEFAULT_TIME)
		local tween = TweenService:Create(screen, tweenInfo, { BackgroundTransparency = targetTransparency })

		if onCancel(function()
			tween:Cancel()
		end) then
			return
		end

		tween.Completed:Connect(resolve)
		tween:Play()
	end)
end

function ScreenFader.Create(): Frame
	if screen then
		return screen
	end

	local frame = vide.create("Frame")({
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 1,
	})

	screen = frame
	return frame
end

----- Connections

ReplicatedStorage.ManualControl.FadeTransparency.Event:Connect(ScreenFader.Fade)

return ScreenFader
