for _, child in script:GetChildren() do
	if child:IsA("ModuleScript") and string.match(child.Name, "Controller") then
		local success, error = pcall(require,child)
		if not success then
			warn(`Error when loading client script {child.Name}: {error}`)
		end
	end
end