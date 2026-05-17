local themer = require("./theme_manager")
local style = require("./styling_components")
local frame = Instance.new("Frame")
frame.Transparency = 1
frame.Size = UDim2.new(1, 0, 1, 0)
return function(parent: Instance?, theme: ("Foreground" | "Background")?)
	local clone = frame:Clone()
	if theme then
		clone.Transparency = 0
		style.corner(clone)
		style.stroke(clone)
		style.padding(clone)
		themer:add_custom_gui_instance(clone, theme)
	end
	clone.Parent = parent
	return clone
end
