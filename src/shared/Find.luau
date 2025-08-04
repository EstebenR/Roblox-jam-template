local Find = {}

function Find.path(parent: Instance, path: string)
	local pathParts = string.split(path, "/")

	local instance = parent
	for _, pathPart: string in pathParts do
		local child = instance:FindFirstChild(pathPart)
		if child == nil then
			error(`Failed to find {pathPart} in {instance:GetFullName()} (full path: {path})`, 2)
		end
		instance = child
	end

	return instance
end

function Find.waitPath(parent: Instance, path: string, maxWait: number?)
	maxWait = maxWait or 10
	local pathParts = string.split(path, "/")

	local instance = parent
	for _, pathPart: string in pathParts do
		local child = instance:WaitForChild(pathPart, maxWait :: number)
		if child == nil then
			error(`Failed to wait for {pathPart} in {instance:GetFullName()} (full path: {path})`, 2)
		end
		instance = child
	end

	return instance
end

return Find
