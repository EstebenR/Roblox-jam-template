--!strict
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LemonSignal = require(ReplicatedStorage.Packages.LemonSignal)
local Find = require(ReplicatedStorage.Shared.Find)


local extras = {
	main = Find.waitPath(Players.LocalPlayer.PlayerGui, "Extras", 10) :: ScreenGui,
	overlay = Find.path(Players.LocalPlayer.PlayerGui, "Extras/Overlay") :: Frame,
	letterboxU = Find.path(Players.LocalPlayer.PlayerGui, "Extras/LetterboxU") :: Frame,
	letterboxD = Find.waitPath(Players.LocalPlayer.PlayerGui, "Extras/LetterboxD") :: Frame,
	subtitles = Find.waitPath(Players.LocalPlayer.PlayerGui, "Extras/Subtitles") :: TextLabel,
	vignette = Find.waitPath(Players.LocalPlayer.PlayerGui, "Extras/Vignette") :: ImageLabel,
}

local playStageEvent = LemonSignal.wrap(script.PlayStage.Event)
local curStage = "Menu"
local StageHandler = {}

function StageHandler.PlayStage(stageName: string): boolean
	if curStage == stageName then
		warn(debug.traceback(`Already in stage "{stageName}"`))
		return false
	end

	local func = script:FindFirstChild(stageName)

	if not func then
		warn(`Stage function "{stageName}" not found`)
		return false
	end

	(require)(func)()
	return true
end

local function showExtras()
	extras.main.Enabled = true
	extras.letterboxU.Visible = true
	extras.letterboxD.Visible = true
	extras.vignette.Visible = true
end

local function clearExtras()
	extras.letterboxU.Visible = false
	extras.letterboxD.Visible = false
	extras.vignette.Visible = false
	extras.subtitles.Text = ""
end

local function restoreCamera()
	local curCam = workspace.CurrentCamera
	curCam.CameraType = Enum.CameraType.Custom
	curCam.FieldOfView = 70
end

local function registerTrigger(trigger: Instance)
	if not trigger:IsA("BasePart") then
		warn("Trigger isn't a basepart: ", trigger:GetFullName())
		return
	end

	local conn
	conn = trigger.Touched:Connect(function(hit)
		local char = hit.Parent
		if not char then
			return
		end

		if not char:FindFirstChild("Humanoid") then
			return
		end

		conn:Disconnect()
		StageHandler.PlayStage(trigger:GetAttribute("Stage") :: string)
	end)
end

----- Init

for _, trigger in CollectionService:GetTagged("StageTrigger") do
	registerTrigger(trigger)
end

----- Connections

playStageEvent:Connect(StageHandler.PlayStage)
CollectionService:GetInstanceAddedSignal("StageTrigger"):Connect(registerTrigger)

return StageHandler
