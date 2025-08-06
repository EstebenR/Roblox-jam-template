local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local vide = require(ReplicatedStorage.Shared.vide)
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
	})
end)

return UIController
