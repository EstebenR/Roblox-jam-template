local Lighting = game:GetService("Lighting")

local LightingUtils = {}

--loads config from a Configuration under Lighting
function LightingUtils.LoadLighting(configName : string)
	local oLightingConfig = Lighting:FindFirstChild(configName)

	if not oLightingConfig then
		warn("Lighting config: " .. configName .. " was not found.")
		return
	end

	if oLightingConfig then
		for atr, val in pairs(oLightingConfig:GetAttributes()) do
			Lighting[atr] = val
		end

		--Delete existing light children that aren't config and copy new ones
		for _, child in ipairs(Lighting:GetChildren()) do
			if not child:IsA("Configuration") then
				child:Destroy()
			end
		end

		for _, child in ipairs(oLightingConfig:GetChildren()) do
			local copy = child:Clone()
			copy.Parent = Lighting
		end
	end
end

return LightingUtils