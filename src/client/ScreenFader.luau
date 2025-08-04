local blackScreen = nil
local initialized = false
local ScreenFader = {}

local function checkInit(shouldBeInitialized: boolean): boolean
	if initialized ~= shouldBeInitialized then
		warn(`ScreenFader is {if shouldBeInitialized then "not" else "already"} initialized`)
		return false
	end
	return true
end

function ScreenFader.FadeOut()
	if not checkInit(true) then
		return
	end
end

function ScreenFader.FadeIn()
	if not checkInit(true) then
		return
	end
end

function ScreenFader.Init(parent: Instance?)
	if not checkInit(false) then
		return
	end

	if not parent then
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "Fader"
		screenGui.DisplayOrder = 100
		parent = screenGui
	end

	blackScreen = Instance.new("Frame")
	blackScreen.Parent = parent
	initialized = true
end

return ScreenFader
