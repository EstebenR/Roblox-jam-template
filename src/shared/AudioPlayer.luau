local SoundService = game:GetService("ReplicatedStorage")

local AudioPlayer = {}

local function getGroup(name: string): SoundGroup?
	local groupFolder = SoundService:FindFirstChild(name)
	if not groupFolder or not groupFolder:IsA("SoundGroup") then
		warn("Group folder not found: " .. name)
		return nil
	end

	return groupFolder
end

function AudioPlayer:PlayGroup(groupName: string, restartAll: boolean)
	local group = getGroup(groupName)
	if not group then
		return
	end

	for _, sound in group:GetChildren() do
		if sound:IsA("Sound") then
			sound:Play()
		end
	end
end

function AudioPlayer:StopGroup(groupName: string)
	local group = getGroup(groupName)
	if not group then
		return
	end

	for _, sound in group:GetChildren() do
		if sound:IsA("Sound") then
			sound:Stop()
		end
	end
end

function AudioPlayer:PlaySingle(groupName: string, audioName: string)
	local group = getGroup(groupName)
	if not group then
		return
	end

	local audio = group:FindFirstChild(audioName)
	if not audio or not audio:IsA("Sound") then
		warn(`Audio {audio} not found in group {groupName}`)
		return
	end

	audio:Play()
end

function AudioPlayer:StopSingle(groupName: string, audioName: string)
	local group = getGroup(groupName)
	if not group then
		return
	end

	local audio = group:FindFirstChild(audioName)
	if not audio or not audio:IsA("Sound") then
		warn(`Audio {audio} not found in group {groupName}`)
		return
	end

	audio:Stop()
end
----- Init

for _, category in SoundService:GetChildren() do
	if category:IsA("SoundGroup") then
		local fader = category:FindFirstChild("AudioFader")
		if not fader then
		end
	end
end

return AudioPlayer
