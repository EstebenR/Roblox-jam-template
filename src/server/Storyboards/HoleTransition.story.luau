local ReplicatedStorage = game:GetService("ReplicatedStorage")

local vide = require(ReplicatedStorage.Shared.vide)
local HoleTransition = require(ReplicatedStorage.UI.HoleTransition)

local controls = {}

local story = {
	controls = controls,
	vide = vide,
	story = function(props)
		local item = HoleTransition.Create()
		item.Parent = props.target

		HoleTransition.BouncePart(workspace.SpawnLocation):Once(function()
			task.wait(0.5)
			HoleTransition.Hide()
		end)

		return item
	end,
}

return story
