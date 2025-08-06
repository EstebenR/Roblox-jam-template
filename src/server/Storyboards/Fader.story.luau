local ReplicatedStorage = game:GetService("ReplicatedStorage")

local vide = require(ReplicatedStorage.Shared.vide)
local ScreenFader = require(ReplicatedStorage.UI.ScreenFader)

local controls = {
	Fade = false,
	Time = 1,
	Color = Color3.new(0, 0, 0),
}

local story = {
	controls = controls,
	vide = vide,
	story = function(props)
		local item = ScreenFader.Create()
		item.Parent = props.target

		vide.effect(function()
			local dir = props.controls.Fade()

			ScreenFader.Fade(
				if dir then 0 else 1,
				vide.untrack(props.controls.Time),
				vide.untrack(props.controls.Color)
			)
		end)

		return item
	end,
}

return story
