for _, child in script:GetChildren() do
	if child:IsA("ModuleScript") and string.match(child.Name, "Handler") then
		local success, error = pcall(require,child)
		if not success then
			warn(`Error when loading server script {child.Name}: {error}`)
		end
	end
end