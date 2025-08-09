local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local vide = require(ReplicatedStorage.Shared.vide)
local HoleTransition = require(ReplicatedStorage.UI.HoleTransition)
local ScreenFader = require(ReplicatedStorage.UI.ScreenFader)
local UIController = {}

----- Init

vide.root(function()
	vide.create("ScreenGui")({
		Name = "Fullscreen Overlays",
		DisplayOrder = 100,
		Parent = Players.LocalPlayer.PlayerGui,
		ClipToDeviceSafeArea = false,
		ScreenInsets = Enum.ScreenInsets.None,

		ScreenFader.Create(),

		HoleTransition.Create(),
	})
end)

-- task.spawn(function()
-- 	while task.wait(5) do
-- 		HoleTransition.BouncePart(workspace.SpawnLocation):Once(function()
-- 			task.wait(0.5)
-- 			HoleTransition.Hide()
-- 		end)
-- 	end
-- end)

return UIController
