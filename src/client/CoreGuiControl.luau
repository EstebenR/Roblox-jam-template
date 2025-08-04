--!strict
local StarterGui = game:GetService('StarterGui')
local RunService = game:GetService('RunService')

local MAX_RETRIES = 8

local CoreGuiControl = {}

----- Functions

function coreCall(method: string, log:boolean, ...)
	local result = {}
	for retries = 1, MAX_RETRIES do
		result = {pcall(StarterGui[method], StarterGui, ...)}
		if result[1] then
			break
		end
		RunService.Stepped:Wait()
	end
	local ret = unpack(result)

	if log then
		print(ret)
	end

	return ret
end

----- Init

coreCall('SetCore', false,'ResetButtonCallback', false)
coreCall('SetCore', false,'TopbarEnabled', false)
coreCall("SetCoreGuiEnabled",false,Enum.CoreGuiType.All,false)

return CoreGuiControl